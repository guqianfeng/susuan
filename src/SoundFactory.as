package src {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import src.Config;
	/**
	 * ...
	 * @author JackyGu
	 */
	public class SoundFactory extends EventDispatcher
	{
		private var id:int = 0;
		private var serialArray:Array;
		private var language:int = Config.LANGUAGE_CHINESE;
		
		public function SoundFactory(str:String, _language:int = 0):void {
			//播放算式语音
			serialArray = toDataArray2(str);
			language = _language;
			//trace(serialArray);
			playSoundArray();
		}
		private function playSoundArray(event:Event = null):void {
			if (id < serialArray.length - 1) {
				playSingleDigit2();
				id++;
			}else {
				dispatchEvent(new Event("PLAY_COMPLETE"));
			}
		}
		private function toDataArray2(str:String):Array {
			//更新算法
			//将1-100全部自然录音，只有大于100的数才采用程序合成
			//距离：34+332 -> [34, +, 300, 32];
			var datArray:Array = new Array();
			var dat:String = "";
			for (var i:int = 0; i <= str.length; i++) {
				var d:String = str.substr(i, 1);
				if (d == "+" || d == "-" || d == "*" || d == "/" || i == str.length) {
					if (dat.length == 1 || dat.length == 2) {
						//个位数或者十位数
						datArray.push(dat);
					}else if (dat.length == 3) {
						//百位数,305,315,300
						datArray.push(dat.substr(0, 1) + "00");//百位数压入
						if (dat.substr(1, 2) != "00") {//如果是整百则不用压入如何数字
							if (dat.substr(1, 1) == "0") datArray.push("0");//如果十位数为0，则压入
							datArray.push(String(int(dat.substr(1, 2))));//压入十位和个位数，注意，需要将前面的0去掉
						}
					}else if (dat.length == 4) {
						//千位数,2345,2302,2002,2032,2000,2300
						datArray.push(dat.substr(0, 1) + "000");//千位数压入
						if (dat.substr(1, 3) != "000") {
							//如果是整千，则不用再压入
							if (dat.substr(2, 2) == "00") {
								datArray.push(dat.substr(1, 1) + "00");//整百
							}else {
								//非整百
								if (dat.substr(1, 1) == "0") {
									datArray.push("0");//如果百位数为0，则压入
									datArray.push(String(int(dat.substr(2, 2))));//压入十位和个位数，注意，需要将前面的0去掉
								}else {
									datArray.push(dat.substr(1, 1) + "00");// 百位数压入
									datArray.push(dat.substr(2, 2));//压入十位和个位数
								}
							}
						}
					}
					datArray.push(d);
					dat = "";
				}else {
					dat = dat + d;
				}
			}
			return datArray;
		}
		/*
		private function toDataArray(str:String):Array {
			//先以运算符为划分分割到数组
			//十用@代表（后面跟数字），百用#代表，为了达到更好效果，用$代表10（后面不跟数字）
			//举例: 34+332 ->[3,@,4,+,3,#,3,10,2]
			var datArray:Array = new Array();
			var dat:String = "";
			for (var i:int = 0; i <= str.length; i++) {
				var d:String = str.substr(i, 1);
				if (d == "+" || d == "-" || d == "*" || d == "/" || i == str.length) {
					if (dat.length == 1) {
						datArray.push(dat);
					}else if (dat.length == 2) {
						if (dat.substr(0, 1) != "1") {
							datArray.push("d" + dat.substr(0, 1));//这里要做十位数短音优化
						}
						if (dat.substr(1, 1) == "0") datArray.push("$");//重音十
						else datArray.push("@");//轻音十
						if (dat.substr(1, 1) != "0") datArray.push(dat.substr(1, 1));
					}else if (dat.length == 3) {
						datArray.push(dat.substr(0, 1));
						datArray.push("#");
						if (!(dat.substr(1, 1) == "0" && dat.substr(2, 1) == "0")) datArray.push(dat.substr(1, 1));
						if (dat.substr(1, 1) != "0") {
							if (dat.substr(2, 1) == "0") datArray.push("$");//重音十
							else datArray.push("@");//轻音十
						}
						if (dat.substr(2, 1) != "0") datArray.push(dat.substr(2, 1));
					}
					datArray.push(d);
					dat = "";
				} else {
					dat = dat + d;
				}
			}
			return datArray;
		}
		*/
		private function playSingleDigit2():void {
			//读出单一数字升级版
			var aClass:Class;
			var className:String;
			var sound:Sound;
			var str:String = serialArray[id];
			if (str == "+") className = "CPLUS.mp3";
			else if (str == "-") className = "CMINUS.mp3";
			else if (str == "*") className = "CTIMES.mp3";
			else if (str == "/") className = "CDEVIDE.mp3";
			else if (str == ".") className = "CPOINT.mp3";
			else {
				if (language == 0) className = "C" + str + ".mp3";//中文
				else if (language == 1) className = "E" + str + ".mp3";//英文
				else if (language == 2) className = "F" + str + ".mp3";//法文
				else if (language == 3) className = "J" + str + ".mp3";//日文
			}
			
			//trace(className);
			aClass = getDefinitionByName(className) as Class;
			sound = new aClass() as Sound;
			soundChannel = sound.play(0);
			soundChannel.addEventListener(Event.SOUND_COMPLETE, playSoundArray);
		}
		/*
		private function playSingleDigit():void {
			//读出单一的数字
			var aClass:Class;
			var className:String;
			var sound:Sound;
			//var soundChannel:SoundChannel;
			var str:String = serialArray[id];
			if (str == "+") className = "SPLUS";
			else if (str == "-") className = "SMINUS";
			else if (str == "*") className = "STIMES";
			else if (str == "/") className = "SDEVIDE";
			else if (str == "@") className = "S10_";
			else if (str == "$") className = "S10";
			else if (str == "#") className = "S100";
			else if (str.substr(0, 1) == "d") className = "S" + str.substr(1,1) + "_";//数字短音
			else {
				if (language == 0)	className = "C" + str;
				
			}
			
			aClass = getDefinitionByName(className) as Class;
			sound = new aClass() as Sound;
			soundChannel = sound.play(0);
			soundChannel.addEventListener(Event.SOUND_COMPLETE, playSoundArray);
		}
		*/
		private var soundChannel:SoundChannel;
		public function stop():void {
			soundChannel.removeEventListener(Event.SOUND_COMPLETE, playSoundArray);
			soundChannel.stop();
		}
	}
}