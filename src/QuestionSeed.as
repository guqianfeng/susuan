package src 
{
	/**
	 * 用于根据不同的要求生成题目
	 * @author JackyGu
	 */
	public class QuestionSeed extends Object{
		
		public static function getQuestion(typeSequence:Array):Object {
			//返回算式
			//格式：{str:String, result:Number}
			var result:Number;
			var suanshi:String;
			var a:Number;
			var b:Number;
			var c:Number
			var fuhao:Number
			var aRangeFrom:int;
			var aRangeTo:int;
			var bRangeFrom:int;
			var bRangeTo:int;
			var suanshiArray:Array = new Array();//各种情况等级的算式数组，然后最后在数组中随机选择一个
			
			if (typeSequence[0]) {
				//20以内加法
				aRangeFrom = 1;
				aRangeTo = 20;
				bRangeFrom = 1;
				bRangeTo = 20;
				a = int(Math.random() * (aRangeTo - aRangeFrom) + aRangeFrom);
				b = int(Math.random() * (bRangeTo - bRangeFrom) + bRangeFrom);
				if (a > b) {
					c = a - b;//a为和，c和b为加数
					result = a;
					suanshi = b + "+" + c;
				}else {
					c = b - a;
					result = b;//b为和
					suanshi = a + "+" + c;
				}
				suanshiArray.push( { str:suanshi, result:result } );
			}
			if (typeSequence[1]) {
				//20以内减法
				aRangeFrom = 1;
				aRangeTo = 20;
				bRangeFrom = 1;
				bRangeTo = 20;
				a = int(Math.random() * (aRangeTo - aRangeFrom) + aRangeFrom);
				b = int(Math.random() * (bRangeTo - bRangeFrom) + bRangeFrom);
				if (a < b) {
					//交换以免出现结果为负数
					c = a;
					a = b;
					b = c;
				}
				result = a - b;
				suanshi = a + "-" + b;
				suanshiArray.push( { str:suanshi, result:result } );
			}
			if (typeSequence[2]) {
				//100以内加减法
				fuhao = Math.random();
				aRangeFrom = 1;
				aRangeTo = 100;
				bRangeFrom = 1;
				bRangeTo = 100;
				a = int(Math.random() * (aRangeTo - aRangeFrom) + aRangeFrom);
				b = int(Math.random() * (bRangeTo - bRangeFrom) + bRangeFrom);
				if (fuhao <= 0.5) {
					//加法
					if (a > b) {
						c = a - b;//a为和，c和b为加数
						result = a;
						suanshi = b + "+" + c;
					}else {
						c = b - a;
						result = b;//b为和
						suanshi = a + "+" + c;
					}
				}else {
					//减法
					if (a < b) {//交换以免出现结果为负数
						c = a;
						a = b;
						b = c;
					}
					result = a - b;
					suanshi = a + "-" + b;
				}
				suanshiArray.push( { str:suanshi, result:result } );
			}
			if (typeSequence[3]) {
				//个位数乘法
				aRangeFrom = 1;
				aRangeTo = 9;
				bRangeFrom = 1;
				bRangeTo = 9;
				a = int(Math.random() * (aRangeTo - aRangeFrom) + aRangeFrom);
				b = int(Math.random() * (bRangeTo - bRangeFrom) + bRangeFrom);
				result = a * b;
				suanshi = a + "*" + b;
				suanshiArray.push( { str:suanshi, result:result } );
			}
			if (typeSequence[4]) {
				//二位数乘以个位数，有进位的乘法
				aRangeFrom = 10;
				aRangeTo = 99;
				bRangeFrom = 1;
				bRangeTo = 9;
				a = int(Math.random() * (aRangeTo - aRangeFrom) + aRangeFrom);
				b = int(Math.random() * (bRangeTo - bRangeFrom) + bRangeFrom);
				result = a * b;
				suanshi = a + "*" + b;
				suanshiArray.push( { str:suanshi, result:result } );
			}
			if (typeSequence[5]) {
				//二位数除以个位数
				aRangeFrom = 2;
				aRangeTo = 10;
				bRangeFrom = 2;
				bRangeTo = 10;
				a = int(Math.random() * (aRangeTo - aRangeFrom) + aRangeFrom);
				b = int(Math.random() * (bRangeTo - bRangeFrom) + bRangeFrom);
				c = a * b;
				result = a;
				suanshi = c + "/" + b;
				suanshiArray.push( { str:suanshi, result:result } );
			}
			if (typeSequence[6]) {
				//三位数加减法
				fuhao = Math.random();
				aRangeFrom = 100;
				aRangeTo = 1000;
				bRangeFrom = 10;
				bRangeTo = 1000;
				a = int(Math.random() * (aRangeTo - aRangeFrom) + aRangeFrom);
				b = int(Math.random() * (bRangeTo - bRangeFrom) + bRangeFrom);
				if (fuhao <= 0.5) {
					//加法
					if (a > b) {
						c = a - b;//a为和，c和b为加数
						result = a;
						suanshi = b + "+" + c;
					}else {
						c = b - a;
						result = b;//b为和
						suanshi = a + "+" + c;
					}
				}else {
					//减法
					if (a < b) {//交换以免出现结果为负数
						c = a;
						a = b;
						b = c;
					}
					result = a - b;
					suanshi = a + "-" + b;
				}
				suanshiArray.push( { str:suanshi, result:result } );
			}
			if (typeSequence[7]) {
				//混合运算
				
			}
			//从suanshiArray中随机选择一个，返回
			trace("算式长度: " + suanshiArray.length);
			return suanshiArray[int(Math.random() * suanshiArray.length)];
		}
	}

}