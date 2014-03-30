package 
{
	import EnemyBullet;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Masklist;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Minttu Mäkinen
	 */
	public class PlayerShip extends Entity 
	{
		[Embed(source = "../graphics/msb.png")]
		private const IMAGE:Class;
		private var _timeElapsed:Number;
		private var _puzzle:Puzzle;
		private var _playerWorld:GameWorld;
		private var pause:Boolean;
		private var timer:Number;
		
		public var bul_onscreen:Vector.<Bullet>;
		private var lives:int;
		
		public function PlayerShip(puzzle:Puzzle, world:GameWorld) 
		{
			this._puzzle = puzzle;
			this._playerWorld = world;
			graphic = new Image(IMAGE);
			
			graphic.x = -28.5;
			graphic.y = -31.5;
			
			lives = 5;
			
			mask = new Pixelmask(IMAGE, -28.5, -31.5);
			this.setHitbox(15, 15, 0, 0);
			x = 250;
			y = 500;
			
			_timeElapsed = 0;
			timer = -1;
			bul_onscreen = new Vector.<Bullet>();
		}
		
		public function getLives():int {
			return lives;
		}
		
		override public function update():void
		{
			//Check puzzle and pause timers
			if (timer >= 0) {
				timer += 5 * FP.elapsed;
				//trace(timer);
				if (timer >= 20) {
					timer = -1;
					_playerWorld.continueGame();
				} else if (timer >= 6 && !pause) {
					_puzzle.shuffle();
					_puzzle.reset();
					
					//Paused, so we can add some cool graphic here without disturbing the game
					_playerWorld.pauseGame();
				}
			}
			
			if (pause) {
				return;
			}
			
			//Game controls
			if (Input.check(Key.A) || Input.check(Key.LEFT))
			{
				x -= 150 * FP.elapsed;
				if (x < 0) {
					x = 0;
				}
			} else if (Input.check(Key.D) || Input.check(Key.RIGHT))
			{
				x += 150 * FP.elapsed;
				if (x > 500) {
					x = 500;
				}
			}
			 
			if (Input.check(Key.W) || Input.check(Key.UP))
			{
				y -= 150 * FP.elapsed;
				if (y < 0) {
					y = 0;
				}
			} else if (Input.check(Key.S) || Input.check(Key.DOWN))
			{
				y += 150 * FP.elapsed;
				if (y > 600) {
					y = 600;
				}
			}
			
			//Shooting
			if (Input.check(Key.SPACE) && _timeElapsed > 2)
			{
				_timeElapsed = 0;
				var bull:Bullet = GameWorld(world).playerPool.activate();
				bull.xPos = bull.x = this.x;
				bull.yPos = bull.y = this.y;
				bull._pathToFollow = GameWorld(world).generatePlayerBulletPath(3);
				world.add(bull);
				bul_onscreen.push(bull);
			}
			
			//Reseting the puzzle
			if (Input.pressed(Key.R))
			{
				_puzzle.reset();
			}
			
			//Rotating the puzzle
			if (Input.pressed(Key.ENTER))
			{
				if (x > 150 && y > 400 && x <= 225 && y <= 475) {
					_puzzle.rotate(0);
				} else if (x > 225 && y > 400 && x <= 300 && y <= 475) {
					_puzzle.rotate(1);
				} else if (x > 300 && y > 400 && x <= 375 && y <= 475) {
					_puzzle.rotate(2);
				} else if (x > 150 && y > 475 && x <= 225 && y <= 550) {
					_puzzle.rotate(3);
				} else if (x > 225 && y > 475 && x <= 300 && y <= 550) {
					_puzzle.rotate(4);
				} else if (x > 300 && y > 475 && x <= 375 && y <= 550) {
					_puzzle.rotate(5);
				}
				if (_puzzle.compareSolution()) {
					timer = 0;
				}
			}
			
			//Advance auto-shoot timer
			_timeElapsed += 7 * FP.elapsed;
		}
		
		public function pauseGame():void
		{
			for each (var b:Bullet in bul_onscreen)
			{
				b.pause = true;
			}
			pause = true;
		}
		
		public function continueGame():void
		{
			for each (var b:Bullet in bul_onscreen)
			{
				b.pause = false;
			}
			pause = false;
		}
		
		public function decreaseLives(damage:int):void
		{
			lives -= damage;
			_playerWorld._sidebar.changeLives(lives);
			/*if (lives < 0) {
				trace("Game over");
			}*/
		}
		
	}
	
}