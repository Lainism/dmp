package  
{
	import flash.geom.Point;
	import net.flashpunk.tweens.misc.AngleTween;
	import net.flashpunk.World;
	
	/**
	 * A bullet pattern for the main boss.
	 * @author A.V.
	 */
	public class BossPattern 
	{
		public var pool:BulletPool;
		public var pool_arr:Array;
		
		public var _enemy:Enemy;
		public var _world:World;
		public var _player:PlayerShip;
		
		public var onScreen:Vector.<EnemyBullet>;
		
		public var FULLANGLE:Number = 2 * Math.PI;
		
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
		
		public function run(timer:Number):void 
		{
			return;
		}
		
		public function generateBulletPath(distanceBetweenPoints:Number, dir:Number):Vector.<Point>
		{
			var i:Number;
			
			var vec:Vector.<Point> = new Vector.<Point>();
			
			for (i = 0; i < 700; i += distanceBetweenPoints)
			{
				vec.push(new Point(i*Math.cos(dir), i*Math.sin(dir)));
			}
			
			return vec;
		}
		
		public function generateBulletPathWithRotation(distanceBetweenPoints:Number, dir:Number):Vector.<Point>
		{
			var i:Number;
			var angle:Number = 0;
			
			var vec:Vector.<Point> = new Vector.<Point>();
			
			for (i = 0; i < 700; i += distanceBetweenPoints)
			{
				vec.push(new Point(i * Math.cos(dir) + Math.cos(angle) * 50, i * Math.sin(dir) + Math.sin(angle) * i * 100));
				angle += 0.4;
			}
			
			return vec;
		}
		
		
		public function generateWaveBulletPath(distanceBetweenPoints:Number, dir:Number):Vector.<Point>
		{
			var i:Number;
			
			var vec:Vector.<Point> = new Vector.<Point>();
			
			for (i = 0; i < 700; i += distanceBetweenPoints)
			{
				vec.push(new Point(Math.cos(dir/100)*50, Math.sin(dir)*i + 100));
				dir += 0.1;
			}
			
			return vec;
		}
		
		public function generateHomingBulletPath(distanceBetweenPoints:Number):Vector.<Point> 
		{
			
			var i:Number;
			var vec:Vector.<Point> = new Vector.<Point>();
			var deltaX:Number = _player.x - _enemy.x;
			var deltaY:Number = _player.y - _enemy.y;
			
			for (i = 0; i < 600; i += distanceBetweenPoints) {
				vec.push(new Point(i*(deltaX/200), i*(deltaY/200))); 
			}
			
			return vec;
		}
		
		private function FermatSpiral(distanceBetweenPoints:Number, dir:Number):Vector.<Point>
		{
			var i:Number;
			
			var vec:Vector.<Point> = new Vector.<Point>();
			
			for (i = 0; i < 700; i += 0.2)
			{
				vec.push(new Point(distanceBetweenPoints * 15 * Math.sqrt(i) * Math.cos(i), distanceBetweenPoints * 15 * Math.sqrt(i) * Math.sin(i)));
				//trace(Math.sin((dir) * 25));
				
			}
			
			return vec;
		}
		
		public function polarRose(distanceBetweenPoints:Number, dir:Number):Vector.<Point>
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