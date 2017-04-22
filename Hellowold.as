package  {
	
	import flash.display.MovieClip
	import flash.events.Event;
	
	
	public class Hellowold extends MovieClip {
		
		private var hello:String = "helloWorld";
		private var legs:int = 3.1415;
		private var hasLeg:Boolean = false;
		var sArr1:Array = ["spring", "summer", "autumn", "winter"];
		var sNumber:Array=[11,9,12,7,8,6,4,5,3,0,2,10,1];
		
		
		
		public function Hellowold() {
			//trace(legs);
			trace(sNumber);
			var temp:int = 0;
			var count:int=0;
			for(var i:int=0;i<sNumber.length;i++){
				for(var j:int=0;j<sNumber.length-i;j++){
					if(sNumber[j] > sNumber[j + 1]){
						temp = sNumber[j+1];
						sNumber[j+1]=sNumber[j];
						sNumber[j] =temp;
						count++;
					}
				}
			}
			trace(sNumber);
			trace(count);
			//trace(hello);
			//legs = legs + 2;
			//trace(legs);
			//hasLeg = true;
			//trace(hasLeg);
			//testIf();
			//testFor(1);
			//for(var count:int = 1;count<101;count++){
				//trace(count);
			//}
		}
		
		public function testIf(){
			if(hasLeg){
				trace("hasLeg");
			}else{
				trace("hasLeg = false");
			}
			if(hasLeg){
				trace("hasLeg");
			}else if(!hasLeg){
				trace("hasLeg = false");
			}else {
				
			}
			trace(legs);
			switch(legs){
				case 1:
				trace("1");
				break;
				case 2:
				trace("2");
				break;
			}
		}
		
		public function add(num1:int,num2:int):int{
			return num1+num2;
		}
		
		public function testFor(num:int):Boolean{			
			
			trace(add(37,2));
			switch(num){
				case 1:
					trace("burjfthcvbhvg");
				break;
				case 2:
					trace("11");
					
				break;
			}
				return true;
		}
		
		public function changeNumber(a:int,b:int){
			
		}

			
	}
}
