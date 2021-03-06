﻿package {
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.Timer;
	import flash.geom.Point;

	public class Snake2 extends MovieClip {
		
		// constants
		private const gridSize:int = 20;
		private const leftWall:int = 0;
		private const rightWall:int = 520;
		private const topWall:int = 0;
		private const bottomWall:int = 380;
		private const startSpeed:int = 200;
		private const startPoint:Point = new Point(260,180);
		
		// game state
		private var gameSprite:Sprite;
		private var food:Food = new Food();
		private var gameTimer:Timer;
		private var snakeParts:Array;
		
		// snake velocity
		private var snakeMoveX:Number = 0;
		private var snakeMoveY:Number = 0;
		private var nextMoveX:Number = 1;
		private var nextMoveY:Number = 0;
		
		
		public function Snake2() {
			// create game sprite
			gameSprite = new Sprite();
			addChild(gameSprite);
			
			// create first part of snake
			snakeParts = new Array();
			var firstSnakePart = new SnakePart();
			firstSnakePart.x = startPoint.x;
			firstSnakePart.y = startPoint.y;
			snakeParts.push(firstSnakePart);
			gameSprite.addChild(firstSnakePart);
			
			// create first food
			gameSprite.addChild(food);
			placeFood();
			
			// set up listener and timer
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownFunction);
			gameTimer = new Timer(startSpeed);
			gameTimer.addEventListener(TimerEvent.TIMER,moveSnake);
			gameTimer.start();
		}
		
		// register key presses
		public function keyDownFunction(event:KeyboardEvent) {
			trace("add");
			if (event.keyCode == 37) {
				if (snakeMoveX != 1) {
					nextMoveX = -1;
					nextMoveY = 0;
				}
			} else if (event.keyCode == 39) {
				if (snakeMoveX != -1) {
					nextMoveX = 1;
					nextMoveY = 0;
				}
			} else if (event.keyCode == 38) {
				if (snakeMoveY != 1) {
					nextMoveY = -1;
					nextMoveX = 0;
				}
			} else if (event.keyCode == 40) {
				if (snakeMoveY != -1) {
					nextMoveY = 1;
					nextMoveX = 0;
				}
			}
		}
			
		// move snake one space in proper direction
		public function moveSnake(event:TimerEvent) {			
			snakeMoveX = nextMoveX;
			snakeMoveY = nextMoveY;
			var newX:Number = snakeParts[0].x + snakeMoveX*gridSize;
			var newY:Number = snakeParts[0].y + snakeMoveY*gridSize;
			
			// check for collision
			if ((newX > rightWall) || (newX < leftWall) || (newY > bottomWall) || (newY < topWall)) {
				gameOver();
			} else if (hitTail()) {
				gameOver();
			} else {
				
				// check for food
				if ((newX == food.x) && (newY == food.y)) {
					placeFood();
					newSnakePart();
					gameTimer.delay -= 2;
				}
				placeTail();
				snakeParts[0].x = newX;
				snakeParts[0].y = newY;
			}
		}
		
		// randomly place the food
		public function placeFood() {
			var foodX:int = Math.floor(Math.random()*(rightWall-leftWall)/gridSize)*gridSize;
			var foodY:int = Math.floor(Math.random()*(bottomWall-topWall)/gridSize)*gridSize;
			food.x = foodX;
			food.y = foodY;
		}
		
		// add one sprite to snake
		public function newSnakePart() {
			var newPart:SnakePart = new SnakePart();
			gameSprite.addChild(newPart);
			snakeParts.push(newPart);
		}
		
		// place all parts of snake
		public function placeTail() {
			for(var i:int=snakeParts.length-1;i>0;i--) {
				snakeParts[i].x = snakeParts[i-1].x;
				snakeParts[i].y = snakeParts[i-1].y;
			}
		}
		
		// see if the head hit any part of the tail
		public function hitTail() {
			for(var i:int=1;i<snakeParts.length;i++) {
				if ((snakeParts[0].x == snakeParts[i].x) && (snakeParts[0].y == snakeParts[i].y)) {
					return true;
				}
			}
			return false;
		}

		// stop game
		public function gameOver() {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDownFunction);
			gameTimer.stop();
		}
	}
}