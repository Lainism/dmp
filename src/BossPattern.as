package  
{
	import flash.geom.Point;
	import net.flashpunk.tweens.misc.AngleTween;
	import net.flashpunk.World;
	
	/**
	 * An overclass for bullet patterns
	 * @author A.V.
	 */
	public class BossPattern 
	{
		public var pool:BulletPool;
		protected var pool_arr:Array;
		
		protected var _enemy:Enemy;
		protected var _world:World;
		protected var _player:PlayerShip;
		
		public var onScreen:Vector.<EnemyBullet>;
		
		protected const FULLANGLE:Number = 2 * Math.PI;
		//protected const QUARTERANGLE:Number = Math.PI / 2;
		
		public function BossPattern(enemy:Enemy, player:PlayerShip, world:World) 
		{
			_enemy = enemy;
			_player = player;
			_world = world;
			onScreen = new Vector.<EnemyBullet>();
			pool = new BulletPool(EnemyBullet, 1000);
			pool_arr = pool.get_pool();
			
			for each (var bul:EnemyBullet in pool_arr) 
			{
				bul.init_bul(GraphicAssets.Ebullet_graph1, GraphicAssets.Enemy_bullet1, -12.5, -12.5, _world);
			}
		}
		
		public function run(timer:Number):uint 
		{
			// An overclass dummy, actual patterns are implemented in the subclasses
			return 1;
		}
		
		protected function generateBulletPath(distanceBetweenPoints:Number, dir:Number, stall:int):Vector.<Point>
		{
			var i:Number;
			var j:int;
			var vec:Vector.<Point> = new Vector.<Point>();
			
			for (j = 0; j < stall; j++) 
			{
				vec.push(new Point(0, 0));
			}
			
			for (i = 0; i < 750; i += distanceBetweenPoints)
			{
				vec.push(new Point(i*Math.cos(dir), i*Math.sin(dir)));
			}
			
			return vec;
		}
		
		protected function generateBulletPathWithRotation(distanceBetweenPoints:Number, dir:Number):Vector.<Point>
		{
			var i:Number;
			var angle:Number = 0;
			
			var vec:Vector.<Point> = new Vector.<Point>();
			
			for (i = 0; i < 700; i += distanceBetweenPoints)
			{
				vec.push(new Point( Math.cos(angle) * 100 + i * Math.cos(dir),  Math.sin(angle) * 100 + i * Math.sin(dir)));
				angle += 0.02;
			}
			
			return vec;
		}
		
		
		protected function generateWaveBulletPath(distanceBetweenPoints:Number, dir:Number):Vector.<Point>
		{
			var i:Number;
			
			var vec:Vector.<Point> = new Vector.<Point>();
			
			for (i = 0; i < 25; i += distanceBetweenPoints)
			{
				vec.push(new Point(Math.cos(i)*150 + 20*i*Math.cos(dir), Math.sin(i)*175 + 20*i*Math.sin(dir)));
				dir += 0.025;
			}
			
			return vec;
		}
		
		protected function generateHomingBulletPath(distanceBetweenPoints:Number, stall:int):Vector.<Point> 
		{
			
			var i:Number;
			var j:int;
			var vec:Vector.<Point> = new Vector.<Point>();
			var deltaX:Number = _player.x - _enemy.x;
			var deltaY:Number = _player.y - _enemy.y;
			
			for (j = 0; j < stall; j++) {
				vec.push(new Point(0, 0));
			}
			
			for (i = 0; i < 700; i += distanceBetweenPoints) {
				vec.push(new Point(i*(deltaX/200), i*(deltaY/200))); 
			}
			
			return vec;
		}
	
		public function pauseGame():void
		{
			for each (var b:Bullet in onScreen)
			{
				b.pause = true;
			}
		}
		
		public function continueGame():void
		{
			for each (var b:Bullet in onScreen)
			{
				b.pause = false;
			}
		}
		
		public function randomRange(minNum:Number, maxNum:Number):Number
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
	}

}