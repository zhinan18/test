package  {
	
	import flash.display.MovieClip
	
	
	public class Hellowold extends MovieClip {
		
		private var hello:String = "helloWorld";
		private var legs:int = 3;
		private var hasLeg:Boolean = false;
		
		public function Hellowold() {
			trace(hello);
			legs = legs + 2;
			trace(legs);
			hasLeg = true;
			trace(hasLeg);
			testIf();
			testFor();
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
		
		public function testFor(){
			for( var i = 1; i< 101;i++){
				trace(i);
				if(i == 47){
					break;
				}
			}
			while(legs>0){
				trace(legs);
				legs--;
				if(legs == 3){
					break;
				}
			}
		}
	}
	
	
	
}
