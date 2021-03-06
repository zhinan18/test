﻿package {
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.Timer;
	import flash.geom.Point;

	public class Snake1 extends MovieClip {
		
		// constants
		private const gridSize:int = 20;
		private const startSpeed:int = 200;
		private const startPoint:Point = new Point(260,180);
		
		// game state
		private var gameSprite:Sprite;
		private var gameTimer:Timer;
		private var snakeParts:Array;
		
		// snake velocity
		private var snakeMoveX:Number = 1;
		private var snakeMoveY:Number = 0;
				
		public function Snake1() {
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
			print("ddsd");
			
			// set up listener and timer
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownFunction);
			gameTimer = new Timer(startSpeed);
			gameTimer.addEventListener(TimerEvent.TIMER,moveSnake);
			gameTimer.start();
		}
		
		// register key presses
		public function keyDownFunction(event:KeyboardEvent) {
			if (event.keyCode == 37) {
				snakeMoveX = -1;
				snakeMoveY = 0;
			} else if (event.keyCode == 39) {
				snakeMoveX = 1;
				snakeMoveY = 0;
			} else if (event.keyCode == 38) {
				snakeMoveY = -1;
				snakeMoveX = 0;
			} else if (event.keyCode == 40) {
				snakeMoveY = 1;
				snakeMoveX = 0;
			}
		}
			
		// move snake one space in proper direction
		public function moveSnake(event:TimerEvent) {			
			snakeParts[0].x += snakeMoveX*gridSize;
			snakeParts[0].y += snakeMoveY*gridSize;
		}
	}
}