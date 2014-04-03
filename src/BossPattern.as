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
			pool = new BulletPool(EnemyBullet, 2000);
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
		
		protected function generateBulletPath(distanceBetweenPoints:Number, dir:Number):Vector.<Point>
		{
			var i:Number;
			
			var vec:Vector.<Point> = new Vector.<Point>();
			
			for (i = 0; i < 700; i += distanceBetweenPoints)
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
			
			for (i = 0; i < 35; i += distanceBetweenPoints)
			{
				vec.push(new Point( Math.cos(i) * 50,  Math.sin(i) * 50 ));
				angle += 0.05;
			}
			
			return vec;
		}
		
		
		protected function generateWaveBulletPath(distanceBetweenPoints:Number, dir:Number):Vector.<Point>
		{
			var i:Number;
			
			var vec:Vector.<Point> = new Vector.<Point>();
			
			for (i = 0; i < 700; i += distanceBetweenPoints)
			{
				vec.push(new Point(Math.cos(dir/100)*50 + i*Math.cos(dir), Math.sin(dir)*50 + i*Math.sin(dir)));
				dir += 0.1;
			}
			
			return vec;
		}
		
		protected function generateHomingBulletPath(distanceBetweenPoints:Number):Vector.<Point> 
		{
			
			var i:Number;
			var vec:Vector.<Point> = new Vector.<Point>();
			var deltaX:Number = _player.x - _enemy.x;
			var deltaY:Number = _player.y - _enemy.y;
			
			for (i = 0; i < 700; i += distanceBetweenPoints) {
				vec.push(new Point(i*(deltaX/200), i*(deltaY/200))); 
			}
			
			return vec;
		}
		
		protected function ArchimedeanSpiral(distanceBetweenPoints:Number, angle:Number):Vector.<Point>
		{
			var i:Number;
			var a:Number = 10.0;
			var b:Number = 15.0;
			
			var vec:Vector.<Point> = new Vector.<Point>();
			
			for (i = angle; i < 100 + angle; i += 0.15)
			{
				vec.push(new Point(a * Math.cos(i) * Math.pow(i, 2), a * Math.sin(i) * Math.pow(i, 2)));
			}
			
			return vec;
		}
		
		protected function polarRose(distanceBetweenPoints:Number, dir:Number):Vector.<Point>
		{
			var i:Number;
			
			var vec:Vector.<Point> = new Vector.<Point>();
			
			for (i = 0; i < 700; i += distanceBetweenPoints)
			{
				vec.push(new Point(150 * Math.cos(5 * i) * Math.sin(i), 150 * Math.cos(5*i)*Math.cos(i)));
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