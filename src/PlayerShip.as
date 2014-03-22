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
		//private var _playerWorld:World;
		
		public var bul_onscreen:Vector.<Bullet>;
		private var lives:int;
		
		public function PlayerShip(puzzle:Puzzle) 
		{
			this._puzzle = puzzle;
			graphic = new Image(IMAGE);
			
			graphic.x = -28.5;
			graphic.y = -31.5;
			
			lives = 5;
			
			mask = new Pixelmask(IMAGE, -28.5, -31.5);
			this.setHitbox(15, 15, 0, 0);
			x = 250;
			y = 500;
			
			_timeElapsed = 0;
			bul_onscreen = new Vector.<Bullet>();
			type = "Player";
		}
		
		override public function update():void
		{
			//Game controls
			if (Input.check(Key.A) || Input.check(Key.LEFT))
			{
				x -= 150 * FP.elapsed;
				if (x < 0) {
					x = 0;
				}
			}
			else if (Input.check(Key.D) || Input.check(Key.RIGHT))
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
			}
		
			if (Input.check(Key.SPACE) && _timeElapsed > 2)
			{
				_timeElapsed = 0;
				var bull:Bullet = GameWorld(world).playerPool.activate();
				bull.xPos = bull.x = this.x;
				bull.yPos = bull.y = this.y;
				bull._pathToFollow = GameWorld(world).generatePlayerBulletPath(3);
				world.add(bull);
				bul_onscreen.push(bull);
				trace("Fired!");
			}
			
			else if (Input.check(Key.S) || Input.check(Key.DOWN))
			{
				y += 150 * FP.elapsed;
				if (y > 600) {
					y = 600;
				}
			}
			
			if (Input.pressed(Key.R))
			{
				_puzzle.reset();
			}
			
			/*
			if (Input.check(Key.SPACE) && _timeElapsed > 1)
			{
				_timeElapsed = 0;
				world.add(new PlayerBullet(GameWorld(world).generatePlayerBulletPath(3), x, y));
			}
			*/
			
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
				_puzzle.compareSolution();
			}
			
			_timeElapsed += 7 * FP.elapsed;
		}
		
		public function decreaseLives(damage:int):void
		{
			lives -= damage;
			if (lives < 0) {
				trace("Game over");
			}
		}
		
	}
	
}