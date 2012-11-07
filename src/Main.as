package src 
{
	import fl.controls.CheckBox;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GraphicsBitmapFill;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.errors.StackOverflowError;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.net.SharedObject;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import gs.TweenLite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.utils.getDefinitionByName;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;
	import flash.desktop.NativeApplication;
	/**
	 * ...
	 * @author JackyGu
	 */
	public class Main extends MovieClip{
		private const showSeconds:Number = 8;//3秒
		private const totalQuestion:Number = 20;//题目总数

		private var question:Sprite;
		private var scoreBox:Sprite;
		private var btnStart:Sprite;
		private var timer:Timer;
		private var questionSequence:Array;
		private var btnPause:MovieClip;
		private var btnExit:MovieClip;
		private var sound:SoundFactory;
		private var infoMc:Sprite;
		private var activeBar:Sprite;
		private var btnSetup:Sprite;
		private var setupMc:SetupMc;
		//private var btnConfig:Sprite;
		private var log:Log;
		private var keyInput:Sprite;
		private var answerMc:Sprite;
		private var exitBox:Sprite;
		
		private var answerBoxArray:Array;
		private var eachQuestionTimer:Timer;
		private var answerStr:String = "";
		
		private var id:int;
		private var ttlSeconds:int = 0;
		private var type:int = 0;
		private var jiange:int = 50;//字符之间间隔
		private var scale:Number;//本程序是针对320x480屏幕开发的，针对其他屏幕需要设一个缩放比例
		private var screenWidth:int;
		private var screenHeight:int;
		private var isPause:Boolean = false;
		private var answerBoxId:int;
		private var currentQuestionResult:Number

		public function Main() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			if (Capabilities.os.substr(0, 7) == "Windows") {
				screenWidth = 320;
				screenHeight = 480;//用于windows系下调试
			}else if (Capabilities.os.substr(0, 5) == "Linux" || Capabilities.os.substr(0, 6) == "iPhone") {
				screenWidth =  Capabilities.screenResolutionX;
				screenHeight =  Capabilities.screenResolutionY;
			}
			scale = screenWidth / 320;
			init();
		}
		
		private function init():void {
			initBackground();//游戏开始时主页底图
			initActiveBar();
			initScoreBox();
			initStartButtons();
			initKeyInput();
			initInfoMc();
			initSetupMc();
			initSetupButton();
			initTimer();
			//initLog();
			initStageEvent();
			getGrade();//获取用户等级数据
			initExitBox();
		}
		//==================初始化====================
		private var background:Bitmap;
		private var background2:Bitmap;
		private function initBackground():void {
			//初始化背景
			background = new Bitmap(new BG());
			background.width = screenWidth;
			background.height = screenHeight;
			background.x = 0;
			background.y = 0;
			this.addChild(background);

			background2 = new Bitmap(new BG2());
			background2.width = screenWidth;
			background2.height = screenHeight;
			background2.x = 0;
			background2.y = 0;
			background2.visible = false;
			this.addChild(background2);
		}
		private function initStartButtons():void {
			//初始化开始按钮
			btnStart = new BtnStart();
			btnStart.width = btnStart.width * scale;
			btnStart.height = btnStart.height * scale;
			btnStart.x = screenWidth / 2;
			btnStart.y = screenHeight / 2;
			this.addChild(btnStart);
			btnStart.addEventListener(MouseEvent.CLICK, onStartButtonClickHandler);
		}
		private function initInfoMc():void {
			//初始化对话框
			infoMc = new Info();
			infoMc.width = infoMc.width * scale;
			infoMc.height = infoMc.height * scale;
			infoMc.x = screenWidth / 2;
			infoMc.y = screenHeight / 2;
			this.addChild(infoMc);
			MovieClip(infoMc.getChildByName("btnConfirm")).addEventListener(MouseEvent.MOUSE_DOWN, onBtnConfirmClickHandler);
			infoMc.visible = false;
		}
		private function initActiveBar():void {
			//初始化ActiveBar
			activeBar = new ActiveBar();
			activeBar.width = screenWidth;
			activeBar.height = activeBar.height * scale;
			activeBar.x = 0;
			activeBar.y = 0;
			btnExit = activeBar.getChildByName("btnExit") as MovieClip;
			btnExit.addEventListener(MouseEvent.MOUSE_DOWN, onBtnExitClickHandler);
			btnPause = activeBar.getChildByName("btnPause") as MovieClip;
			btnPause.addEventListener(MouseEvent.MOUSE_DOWN, onBtnPauseClickHandler);
			this.addChild(activeBar);
			activeBar.visible = false;
		}
		private function initScoreBox():void {
			//初始化正确与错误的框
			scoreBox = new Score();
			scoreBox.width = scoreBox.width * scale;
			scoreBox.height = scoreBox.height * scale;
			scoreBox.x = 10 * scale;
			scoreBox.y = activeBar.height + 10 * scale;
			this.addChild(scoreBox);
			scoreBox.visible = false;
		}
		private function initSetupMc():void {
			setupMc = new SetupMc();
			setupMc.addEventListener("NEW_CONFIGDATA", onSetupFinishedHandler);
			setupMc.addEventListener("CONTINUE", onSetupCancelHandler);
			setupMc.width = setupMc.width * scale;
			setupMc.height = setupMc.height * scale;
			setupMc.x = 0;// (screenWidth - setupMc.width) / 2;
			setupMc.y = 0;// activeBar.height + 20;
			this.addChild(setupMc);
			setupMc.visible = false;
		}
		private function loadSharedObject():void {
			//从本地调用数据
			var data:Object = setupMc.loaddata();
			questionSequence = new Array();
			questionSequence.push(data.type1);
			questionSequence.push(data.type2);
			questionSequence.push(data.type3);
			questionSequence.push(data.type4);
			questionSequence.push(data.type5);
			questionSequence.push(data.type6);
			questionSequence.push(data.type7);
			//questionSequence.push(data.type8);
			Config.isSound = data.voice == 1 ? true : false;
			trace(String(questionSequence));
			trace("是否发音: " + Config.isSound);
		}
		private function initTimer():void {
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, onTimerHandler);
		}
		private function initSetupButton():void {
			//配置首页设置按钮
			btnSetup = new BtnConfig();
			btnSetup.width = 50 * scale;
			btnSetup.height = 47.65 * scale;
			btnSetup.x = screenWidth - 20;//放到距右边20个像素位置
			btnSetup.y = screenHeight - btnSetup.height - 20;//距底边20个像素位置
			this.addChild(btnSetup);
			btnSetup.addEventListener(MouseEvent.CLICK, onBtnConfigClickHandler);
		}
		private function initLog():void {
			log = new Log();
			log.width = log.width * scale;
			log.height = log.height * scale;
			log.x = 0;
			log.y = screenHeight;
			this.addChild(log);
		}
		private function initStageEvent():void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onStageKeyDownHandler);
		}
		private function initKeyInput():void {
			keyInput = new KeyInput();
			keyInput.width = screenWidth;
			keyInput.height = keyInput.height * scale;
			keyInput.x = 0;
			keyInput.y = screenHeight;
			keyInput.addEventListener(myEvent.KEY_DOWN, onKeyPressHandler);
			this.addChild(keyInput);
			keyInput.visible = false;
		}
		private function initExitBox():void {
			exitBox = new ExitBox();
			exitBox.width = exitBox.width * scale;
			exitBox.height = exitBox.height * scale;
			exitBox.x = screenWidth / 2;
			exitBox.y = screenHeight / 2;
			this.addChild(exitBox);
			var btnOk:MovieClip = exitBox.getChildByName("ok") as MovieClip;
			var btnKo:MovieClip = exitBox.getChildByName("ko") as MovieClip
			btnOk.addEventListener(MouseEvent.MOUSE_DOWN, onExitButtonOKHandler);
			btnKo.addEventListener(MouseEvent.MOUSE_DOWN, onExitButtonKOHandler);
			exitBox.visible = false;
		}
		//==============================事件处理==================================
		private var fun:Function = null;
		private function onBtnConfirmClickHandler(event:MouseEvent):void {
			//对话框确认按钮按下
			if(fun != null) fun();
			infoMc.visible = false;
		}
		/*
		private function onBtnNextClickHandler(event:MouseEvent):void {
			//下一题按钮按下
			checkAnswer( -999);
			next();
		}
		*/
		private function onSetupFinishedHandler(event:Event):void {
			//配置对话框确认按钮按下
			//gotoFirstPage();
			btnSetup.visible = true;
			//btnSetup.addEventListener(MouseEvent.MOUSE_DOWN, onBtnConfigClickHandler);
			//btnSetup.addEventListener(MouseEvent.MOUSE_DOWN, onBtnPauseClickHandler);
			//gotoFirstPage();
		}
		private function onSetupCancelHandler(event:Event):void {
			//配置未能生效，继续
			btnSetup.visible = true;
			//btnConfig.addEventListener(MouseEvent.MOUSE_DOWN, onBtnConfigClickHandler);
			//btnPause.addEventListener(MouseEvent.MOUSE_DOWN, onBtnPauseClickHandler);
			//resume();
		}
		private function onTimerHandler(event:TimerEvent):void {
			//每秒响应，改变所用时间秒数
			//trace("onTimerHandler");
			showActiveBar(++ttlSeconds);
		}
		private function onStartButtonClickHandler(event:MouseEvent):void {
			//开始按钮按下
			start();
		}
		private function onSoundPlayCompleteHandler(event:Event):void {
			//语音播放完毕

		}
		private function onEachQuestionTimerHandler(event:TimerEvent):void {
			checkAnswer( -999);
			//next();
		}
		private function onBtnConfigClickHandler(event:MouseEvent):void {
			//按下配置按钮
			//resetEachQuestionTimer(false);
			setupMc.visible = true;
			//if (question) question.visible = false;
			btnSetup.visible = false;
			//pause(false);
			//btnConfig.removeEventListener(MouseEvent.MOUSE_DOWN, onBtnConfigClickHandler);
			//btnPause.removeEventListener(MouseEvent.MOUSE_DOWN, onBtnPauseClickHandler);
		}
		private function onBtnPauseClickHandler(event:MouseEvent):void {
			resetEachQuestionTimer(false);
			if (btnPause.currentFrame == 1) {
				//处理暂停
				pause(true);
			}else if (btnPause.currentFrame == 2) {
				//处理继续
				resume();
			}
		}
		private function onBtnExitClickHandler(event:MouseEvent):void {
			gotoFirstPage();
		}
		private function onStageKeyDownHandler(event:KeyboardEvent):void {
			if (event.keyCode == Keyboard.BACK) {
				//log.message("按下BACK");
				event.preventDefault();
				exitBox.visible = true;
			}else if (event.keyCode == Keyboard.HOME) {
				//log.message("按下HOME");
				//event.preventDefault();
				pause(true);
			}else if (event.keyCode == Keyboard.MENU) {
				//log.message("按下MENU");
				event.preventDefault();
				//menuBox.visible = true;还没写好
			}
		}
		private function onKeyPressHandler(event:myEvent):void {
			//trace("OnKeyPressHandler");
			var key:String = String(event.params.input);
			var box:Sprite;
			var i:int;
			if (!isPause) {
				if (key == "c") {
					//清空
					for (i = 0; i < answerBoxArray.length; i++) {
						box = answerBoxArray[i];
						TextField(box.getChildByName("txt")).text = "";
						answerBoxId = 0;
						answerStr = "";
					}
				}else {
					//输入框中
					box = answerBoxArray[answerBoxId];
					if(box){
						var txt:TextField = box.getChildByName("txt") as TextField;
						if(txt) txt.text = key;
						answerBoxId++;
						answerStr = answerStr + key;
					}
				}
				if (answerBoxId == answerBoxArray.length) {
					//判断是否正确
					checkAnswer(Number(answerStr));
				}
			}
		}
		private function onExitButtonOKHandler(event:MouseEvent):void {
			destroy();
			NativeApplication.nativeApplication.exit();
		}
		private function onExitButtonKOHandler(event:MouseEvent):void {
			exitBox.visible = false;
		}
		//==============================显示功能函数==================================
		private function showInfoMc(txt:String, _fun:Function = null, stars:int=-999):void {
			infoMc.visible = true;
			TextField(infoMc.getChildByName("txt")).text = txt;
			var starsMc:MovieClip = infoMc.getChildByName("stars") as MovieClip;
			if (stars != -999) {
				//显示得到的星星
				starsMc.visible = true;
				starsMc.gotoAndStop(stars);
			}else {
				starsMc.visible = false;
			}
			if (_fun != null) fun = _fun;
		}		
		private function showActiveBar(seconds:int):void {
			//显示秒数
			var minute:int = seconds / 60;
			var second:int = seconds % 60;
			var strMinute:String = minute < 10 ? "0" + String(minute) : String(minute)
			var strSecond:String = second < 10 ? "0" + String(second) : String(second);
			
			TextField(activeBar.getChildByName("txt")).text = strMinute + ":" + strSecond;
		}
		private function showQuestion(str:String):void {
			//显示题目
			question = datToSprite(str);
			question.width = scale * question.width;
			question.height = scale * question.height;
			question.x = (screenWidth - question.width) / 2 - jiange * scale;
			question.y = activeBar.height * 5 / 4 + 22 * scale;//设定算题显示位置 (screenHeight - question.height) / 2;
			this.addChild(question);
			//btnNext.visible = true;
		}
		private function deleteAnswerBox():void {
			//删除原有所有的答题框
			var box:Sprite;
			if (answerMc) {
				for (var i:int = 0; i < answerBoxArray.length; i++) {
					box = Sprite(answerMc.getChildByName("answerbox" + i));
					MemoryCleaner.removeMc(answerMc, box);
				}
				MemoryCleaner.removeArray(answerBoxArray);
			}
		}
		private function showAnswerBox(qnty:int):void {
			//显示答题框，qnty为数量
			var i:int;
			var box:Sprite;
			deleteAnswerBox();
			answerBoxId = 0;
			answerStr = "";
			answerMc = new Sprite();
			answerBoxArray = new Array();
			for (i = 0; i < qnty; i++) {
				box = new AnswerMc();
				if (i == 0) box.x = 0;
				else box.x = answerMc.width + 12;//定位输入框位置
				box.y = 0;
				answerMc.addChild(box);
				answerBoxArray.push(box);
				box.name = "answerbox" + i;
			}
			answerMc.width = answerMc.width * scale;
			answerMc.height = answerMc.height * scale;
			answerMc.x = (screenWidth - answerMc.width) / 2;
			answerMc.y = question.y + question.height + 5 * scale;//回答窗口位置
			this.addChild(answerMc);
		}
		//===============================功能函数======================================
		private var isAnswered:Boolean = false;
		private function checkAnswer(dat:Number):void {
			var correct:TextField = TextField(scoreBox.getChildByName("correct"));
			var wrong:TextField = TextField(scoreBox.getChildByName("wrong"));
			if(isAnswered == false){
				if (currentQuestionResult == dat) {
					//正确
					correct.text = String(int(correct.text) + 1);
				}else {
					//错误
					wrong.text = String(int(wrong.text) + 1);
				}
				isAnswered = true;
				next();
			}
		}
		
		private function resetScoreBox():void {
			var correct:TextField = TextField(scoreBox.getChildByName("correct"));
			var wrong:TextField = TextField(scoreBox.getChildByName("wrong"));
			correct.text = "0";
			wrong.text = "0";
		}
		private function issue():void {
			//log.message("issue");
			if (!isPause) {
				isAnswered = false;
				if (id <= totalQuestion) {
					MemoryCleaner.removeMc(this, question);
					var countTextField:TextField = activeBar.getChildByName("count") as TextField;
					countTextField.text = id + "/" + totalQuestion;
					var questionObj:Object = QuestionSeed.getQuestion(questionSequence);
					if (questionObj) {
						currentQuestionResult = questionObj.result;
						var str:String = questionObj.str;
						id++;
						if (Config.isSound) {
							if (sound) {
								if(sound.hasEventListener("PLAY_COMPLETE")) sound.removeEventListener("PLAY_COMPLETE", onSoundPlayCompleteHandler);
								sound.stop();
								sound = null;
							}
							sound = new SoundFactory(str, 0);
							sound.addEventListener("PLAY_COMPLETE", onSoundPlayCompleteHandler);
						}
						
						resetEachQuestionTimer(true);
						showQuestion(str);
						showAnswerBox(String(currentQuestionResult).length);
						keyInput.visible = true;
					}else {
						showInfoMc("配置中尚未选定题目类型，请按右上角蓝色配置按钮。", null);
					}
				}else {
					timer.reset();
					//隐藏answerBox
					deleteAnswerBox();
					//根据秒数和答题正确率打分
					var rightCount:int = int(TextField(scoreBox.getChildByName("correct")).text);
					var rightRate:Number = rightCount / totalQuestion;
					var score:int = getScore(rightRate, ttlSeconds);
					showInfoMc("所有题目答完\n用时: " + ttlSeconds + "秒\n正确：" + rightCount + "道题\n得分：" + String(score), gotoFirstPage, getStars(score));
				}
			}
		}
		private function resetEachQuestionTimer(bl:Boolean):void {
			//重置每题计时器
			if (eachQuestionTimer) {
				//删除原有的
				//trace("关闭EachQuestionTimer");
				eachQuestionTimer.removeEventListener(TimerEvent.TIMER, onEachQuestionTimerHandler);
				eachQuestionTimer.stop();
				eachQuestionTimer = null;
			}
			if (bl) {
				//如果需要从新设置
				//trace("打开EachQuestionTimer");
				eachQuestionTimer = new Timer(showSeconds * 1000);
				eachQuestionTimer.addEventListener(TimerEvent.TIMER, onEachQuestionTimerHandler);
				eachQuestionTimer.start();
			}
		}
		private function datToSprite(strD:String):Sprite {
			var re:Sprite = new Sprite();
			var className:String;
			for (var i:int = 0; i < strD.length; i++) {
				var sub:String = strD.substr(i, 1);
				if (sub == "+") className = "plus";
				else if (sub == "-") className = "minus";
				else if (sub == "*") className = "times";
				else if (sub == "/") className = "divide";
				else if (sub == ".") className = "point";
				else className = "D" + sub;
				var aClass:Class = getDefinitionByName(className) as Class;
				var sprite:Sprite = new aClass();
				sprite.x = re.width + jiange;//50是字符间隙
				re.addChild(sprite);
			}
			return re;
		}
		private function start():void {
			//从新开始
			background.visible = false;
			background2.visible = true;
			loadSharedObject();
			keyInput.visible = true;
			scoreBox.visible = true;
			timer.reset();
			ttlSeconds = 0;
			showActiveBar(0);
			id = 1;
			isPause = false;
			timer.start();
			activeBar.visible = true;
			btnStart.visible = false;
			btnSetup.visible = false;
			issue();
		}
		private function resume():void {
			//暂停后继续
			//log.message("resume");
			keyInput.visible = true;
			scoreBox.visible = true;
			if (question) question.visible = true;
			if(answerMc) answerMc.visible = true;
			isPause = false;
			timer.start();
			btnPause.gotoAndStop(1);
			issue();
		}
		private function pause(ifShowDialogBox:Boolean = false):void {
			//暂停
			keyInput.visible = false;
			scoreBox.visible = false;
			//btnNext.visible = false;
			if (question) question.visible = false;
			if(answerMc) answerMc.visible = false;
			isPause = true;
			timer.stop();
			btnPause.gotoAndStop(2);
			if(ifShowDialogBox) showInfoMc("暂停!\n按确认继续", resume);
		}
		private function gotoFirstPage():void {
			//回到首页
			timer.reset();
			ttlSeconds = 0;
			showActiveBar(0);
			resetScoreBox();
			isPause = true;
			question.visible = false;
			activeBar.visible = false;
			keyInput.visible = false;
			answerMc.visible = false;
			scoreBox.visible = false;
			btnStart.visible = true;
			btnSetup.visible = true;
			background2.visible = false;
		}
		private function next():void {
			//显示下一道题
			resetEachQuestionTimer(false);
			if(question) question.visible = false;
			//btnNext.visible = false;
			isPause = false;
			issue();
		}
		private function getScore(rightRate:Number, seconds:int):int {
			//根据正确率和时间返回积分
			var timeScore:int = 0;
			if (seconds > 160) timeScore = 30;
			else if (seconds > 140 && seconds <= 160) timeScore = 40;
			else if (seconds > 120 && seconds <= 140) timeScore = 50;
			else if (seconds > 100 && seconds <= 120) timeScore = 60;
			else if (seconds > 80 && seconds <= 100) timeScore = 70;
			else if (seconds > 60 && seconds <= 80) timeScore = 80;
			else if (seconds > 40 && seconds <= 60) timeScore = 90;
			else if (seconds <= 40) timeScore = 100;
			return int(timeScore * rightRate);
		}
		private function getStars(score:int):int {
			//根据积分获取星数
			var stars:int = 0;
			if (score >= 90) stars = 5;
			else if (score >= 75 && score < 90) stars = 4;
			else if (score >= 60 && score < 75) stars = 3;
			else if (score >= 45 && score < 60) stars = 2;
			else if (score >= 30 && score < 45) stars = 1;
			else if (score < 30) stars = 0;
			return stars;
		}
		private function destroy():void {
			//删除对象，退出处理
			answerStr = null;
			
			resetEachQuestionTimer(false);
			isPause = true;

			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, onTimerHandler);
			timer = null;
			
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onStageKeyDownHandler);

			btnExit.removeEventListener(MouseEvent.MOUSE_DOWN, onBtnExitClickHandler);
			btnPause.removeEventListener(MouseEvent.MOUSE_DOWN, onBtnPauseClickHandler);
			MemoryCleaner.removeMc(this, activeBar);

			MemoryCleaner.removeMc(this, question);
			MemoryCleaner.removeMc(this, scoreBox);

			MovieClip(infoMc.getChildByName("btnConfirm")).removeEventListener(MouseEvent.MOUSE_DOWN, onBtnConfirmClickHandler);
			MemoryCleaner.removeMc(this, infoMc);
			
			setupMc.removeEventListener("NEW_CONFIGDATA", onSetupFinishedHandler);
			setupMc.removeEventListener("CONTINUE", onSetupCancelHandler);
			MemoryCleaner.removeMc(this, setupMc);
			
			MemoryCleaner.removeMc(this, answerMc);

			var btnOk:MovieClip = exitBox.getChildByName("ok") as MovieClip;
			var btnKo:MovieClip = exitBox.getChildByName("ko") as MovieClip
			btnOk.removeEventListener(MouseEvent.MOUSE_DOWN, onExitButtonOKHandler);
			btnKo.removeEventListener(MouseEvent.MOUSE_DOWN, onExitButtonKOHandler);
			MemoryCleaner.removeMc(this, exitBox);
			
			MemoryCleaner.removeMc(this, log);

			keyInput.removeEventListener(myEvent.KEY_DOWN, onKeyPressHandler);
			MemoryCleaner.removeMc(this, keyInput);

			btnStart.removeEventListener(MouseEvent.CLICK, onStartButtonClickHandler);
			MemoryCleaner.removeMc(this, btnStart);
			
			btnSetup.removeEventListener(MouseEvent.CLICK, onBtnConfigClickHandler);
			MemoryCleaner.removeMc(this, btnSetup);
			
			//MemoryCleaner.removeMc(this, background);
			//MemoryCleaner.removeMc(this, background2);
			//MemoryCleaner.removeMc(this, btnNext);
			
			if(sound) sound.removeEventListener("PLAY_COMPLETE", onSoundPlayCompleteHandler);
			sound = null;
			
			if(questionSequence) MemoryCleaner.removeArray(questionSequence);
			if(answerBoxArray) MemoryCleaner.removeArray(answerBoxArray);
			
			MemoryCleaner.clean();
		}

		//等级管理
		private function setGrade(gradeArray:Array):void {
			//设置等级
			//一共八个等级，等待时间分别从8秒到1秒
			//用数组表示，每个元素分别代表不同题目类型，从type1开始到type8
			var so:SharedObject = SharedObject.getLocal("suansu"); 
			so.data.grade = gradeArray.join(",");
			so.flush();
		}
		private function getGrade():Array {
			//从磁盘获取用户等级
			var gradeArray:Array;
			var so:SharedObject = SharedObject.getLocal("suansu");
			if (so.data.grade) {
				gradeArray = String(so.data.grade).split(",");
			}else {
				//如果先前没有保存过
				var gradeStr:String = "1,1,1,1,1,1,1,1";//默认全部为第一级，每级用户实际答题时间为9-1秒
				gradeArray = gradeStr.split(",");
			}
			return gradeArray;
		}
		
		
	}

}