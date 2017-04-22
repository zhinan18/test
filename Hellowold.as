package  {
	
	import flash.display.MovieClip
	import flash.events.Event;
	
	
	public class Hellowold extends MovieClip {
		
		private var hello:String = "helloWorld";
		private var legs:int = 3.1415;
		private var hasLeg:Boolean = false;
		var sArr1:Array = ["spring", "summer", "autumn", "winter"];
		
		
		
		public function Hellowold() {
			trace(legs);
			trace(hello);
			legs = legs + 2;
			trace(legs);
			hasLeg = true;
			trace(hasLeg);
			//testIf();
			testFor(1);
			for(var count:int = 1;count<101;count++){
				//trace(count);
			}
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
		
		public function testFor(num:int):Boolean{			
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
			
	}
}
