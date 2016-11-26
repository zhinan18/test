
/*
-------------------------------------------------------------------------------------------------
All contents (including text, graphics, actionscript code, fla source files and all other original 
works), on MakeFlashGames.com website is licensed under a Creative Commons License.

Copyright: Joseph Tan
Location: Singapore
Website: http://www.makeflashgames.com
Email: joseph@makeflashgames.com
Licensing: http://creativecommons.org/licenses/by-nc/2.0/

None of the tutorials/codes/graphics here should be distributed or used for any commercial purposes 
without first seeking prior permission from the author.
Any use of the materials here must carry an acknowledgment of the original author as the sole 
owner to the rights of this document.

Kindly contact joseph@makeflashgames.com if you would like to use these materials for commercial
or educational purposes.
-------------------------------------------------------------------------------------------------
*/
package {
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	
	public class Snake extends MovieClip
	{
		private var score, life, framesElapsed:Number;
		private var p1speedX, p1speedY:Number;
		private var spacePressed, readyToMove, gotoWin, gotoLose:Boolean;
		private var left,right,up,down:Boolean;
		private var snakes:Array;
		private var mcFood:Food;
		
		public function Snake()
		{
			
		}
		
		//All Start Functions
		public function startMenu()
		{
			stop();
			btnStartGame.addEventListener(MouseEvent.CLICK, gotoStartGame);
			btnHowToPlay.addEventListener(MouseEvent.CLICK, gotoHowToPlay);
		}
		
		public function startHowToPlay()
		{
			btnBack.addEventListener(MouseEvent.CLICK, gotoMenu);
		}
		
		public function startWin()
		{
			btnBack.addEventListener(MouseEvent.CLICK, gotoMenu);
		}
		
		public function startLose()
		{
			btnBack.addEventListener(MouseEvent.CLICK, gotoMenu);
		}
		
		public function startGame()
		{			
			score = 0;
			life = 1 ;
			framesElapsed = 0;
			p1speedX = 1; //snakek starts moving right
			p1speedY = 0;
			up = false;
			down = false;
			left = false;
			right = false;
			spacePressed = false;
			readyToMove = false;
			gotoWin = false;
			gotoLose = false;
			snakes = new Array();
			
			//Create 1st body part of snake and push it into the array
			var snakeHead = new SnakePart();
			snakeHead.x = 400;
			snakeHead.y = 300;
			snakes.push(snakeHead);
			addChild(snakeHead);
			
			addEventListener(Event.ENTER_FRAME,update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUpHandler);
			
			stage.focus = this;
		}
		
		//All Goto Functions
		private function gotoStartGame(evt:MouseEvent)
		{
			btnStartGame.removeEventListener(MouseEvent.CLICK, gotoStartGame);
			btnHowToPlay.removeEventListener(MouseEvent.CLICK, gotoHowToPlay);
			gotoAndStop("game");
		}
		
		private function gotoHowToPlay(evt:MouseEvent)
		{
			btnStartGame.removeEventListener(MouseEvent.CLICK, gotoStartGame);
			btnHowToPlay.removeEventListener(MouseEvent.CLICK, gotoHowToPlay);
			gotoAndStop("howtoplay");
		}
		
		private function gotoMenu(evt:MouseEvent)
		{
			btnBack.removeEventListener(MouseEvent.CLICK, gotoMenu);
			gotoAndStop("menu");
		}
		
		private function keyDownHandler(evt:KeyboardEvent)
		{
			if (evt.keyCode == Keyboard.A) 
			{
				//1st Player Left Key
				left = true;
			}
			else if (evt.keyCode == Keyboard.D)
			{
				//1st Player Right Key
				right = true;
			}
			
			if (evt.keyCode == Keyboard.W) 
			{
				//1st Player Up Key
				up = true;
			}
			else if (evt.keyCode == Keyboard.S)
			{
				//1st Player Down Key
				down = true;
			}
			
			if (evt.keyCode == Keyboard.SPACE) 
			{
				spacePressed = true;
			}
		}
		
		private function keyUpHandler(evt:KeyboardEvent)
		{
			if (evt.keyCode == Keyboard.A)
			{
				left = false;
			}
			else if (evt.keyCode == Keyboard.D)
			{
				right = false;
			}
			else if (evt.keyCode == Keyboard.W)
			{
				up = false;
			}
			else if (evt.keyCode == Keyboard.S)
			{
				down = false;
			}
			
			if (evt.keyCode == Keyboard.SPACE) 
			{
				spacePressed = false;
			}
		}
		
		public function update(evt:Event)
		{
			handleUserInput();
			handleGameLogic();
			handleDraw();
			
			if (gotoWin)
				triggerGoToWin();
			else if (gotoLose)
				triggerGoToLose();
		}
		
		private function handleUserInput()
		{
			//Handle player 1 position
			
			//if player wants to move left but snake is not
			//already moving right
			if (left && (p1speedX != 1)) 
			{
				p1speedX = -1;
				p1speedY = 0;
			}
			//if player wants to move right but snake is not
			//already moving left
			else if (right && (p1speedX != -1 ))
			{
				p1speedX = 1;
				p1speedY = 0;
			}
			//if player wants to move up but snake is not
			//already moving down
			else if (up && (p1speedY != 1))
			{
				p1speedY = -1;
				p1speedX = 0;
			}
			else if (down && (p1speedY != -1))
			{
				p1speedY = 1;
				p1speedX = 0;
			}
			
			if (spacePressed)
				readyToMove = true;
		}
		
		private function handleGameLogic()
		{
			if (!readyToMove)
				return;
			
			framesElapsed++;
			
			//Update the new position of the snake's head
			if (framesElapsed % 2 == 0)
			{
				//Update motion of the snake's body
				for (var i = snakes.length - 1; i >= 1; i--)
				{
					snakes[i].x = snakes[i-1].x;
					snakes[i].y = snakes[i-1].y;
				}
			
				if (p1speedX > 0)
				{
					snakes[0].x += 20;
				}
				else if (p1speedX < 0)
				{
					snakes[0].x -= 20;
				}
				else if (p1speedY > 0)
				{
					snakes[0].y += 20;
				}
				else if (p1speedY < 0)
				{
					snakes[0].y -= 20;
				}
				
				//Check for collisions between the snake and its own body
				for (var i = snakes.length - 1; i >= 1; i--)
				{
					if ((snakes[0].x == snakes[i].x) &&
						(snakes[0].y == snakes[i].y))
					{
						collided();
						break;
					}
				}
			}
			
			//Check for collisions between the snake and the walls
			if (snakes[0].y < 0)
			{
				collided();
			}
			else if (snakes[0].x > 800)
			{
				collided();
			}
			else if (snakes[0].x < 0)
			{
				collided();
			}
			else if (snakes[0].y > 600)
			{
				collided();
			}
			
			//Add new food items
			if (mcFood == null)
			{
				//Create a new food item
				mcFood = new Food();
				mcFood.x = Math.random() * 700 + 50;
				mcFood.y = Math.random() * 500 + 50;
				addChild(mcFood);
			}
			
			//Check for collisions between food item and Snake
			if (mcFood != null)
			{
				if (snakes[0].hitTestObject(mcFood))
				{
					//Add score
					score += 100;
					if (score >= 5000)
						gotoWin = true;
					
					removeChild(mcFood);
					mcFood = null;
					
					//Add a body
					var newPart = new SnakePart();
					newPart.x = snakes[snakes.length-1].x;
					newPart.y = snakes[snakes.length-1].y;
					snakes.push(newPart);
					addChild(newPart);
				}
			}
		}
		
		private function handleDraw()
		{
			//Handle display
			if (!readyToMove)
				txtHitSpaceBar.visible = true;
			else
				txtHitSpaceBar.visible = false;
				
			txtScoreP1.text = String(score);
			txtLife.text = String(life);
		}
		
		private function triggerGoToWin()
		{
			clearGame();
			removeEventListener(Event.ENTER_FRAME, update);
			gotoAndStop("win");
		}
		
		private function triggerGoToLose()
		{
			clearGame();
			removeEventListener(Event.ENTER_FRAME, update);
			gotoAndStop("lose");
		}
		
		//Misc Functions
		private function resetGame()
		{
			//remove all food
			removeChild(mcFood);
			mcFood = null;
			
			//remove all of snake body except first
			for (var i = snakes.length - 1; i >= 1; i--)
			{
				removeChild(snakes[i]);
				snakes.splice(i,1);
			}
			
			//Center the snake's head
			snakes[0].x = 400;
			snakes[0].y = 300;
			
			readyToMove = false;
		}
		
		private function clearGame()
		{
			//remove all food
			if (mcFood != null)
			{
				removeChild(mcFood);
				mcFood = null;
			}
			
			//remove all of snake body
			for (var i = snakes.length - 1; i >= 0; i--)
			{
				removeChild(snakes[i]);
				snakes.splice(i,1);
			}
		}
		
		private function collided()
		{
			life -= 1;
			
			if (life > 0)
				resetGame();
			else
				gotoLose = true;
		}
		
	}//end class	
}//end package