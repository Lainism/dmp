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
		
		private var _enemy:Enemy;
		private var _world:World;
		
		public var onScreen:Vector.<EnemyBullet>;
		
		public function BossPattern(enemy:Enemy, world:World) 
		{
			_enemy = enemy;
			_world = world;
			onScreen = new Vector.<EnemyBullet>();
			pool = new BulletPool(EnemyBullet, 500);
			var pool_arr:Array = pool.get_pool();
			for each (var bul:EnemyBullet in pool_arr) 
			{
				bul.init_bul(GraphicAssets.Ebullet_graph1, GraphicAssets.Enemy_bullet1, -12.5, -12.5, _world);
			}
		}
		
		public function run(timer:Number):void 
		{
			var r:Number = 20.0;
			if (timer < -1) {
				for (var i:Number = 0.0; i <= 2 * Math.PI; i = i + 0.15) {
					var bullet:Bullet = pool.activate();
					bullet.xPos = bullet.x = _enemy.x + (r * Math.cos(i));
					bullet.yPos = bullet.y = _enemy.y + (r * Math.sin(i));
					bullet._pathToFollow = generateBulletPath(3, i);
					_world.add(bullet);
					onScreen.push(bullet);
				}
			} else if (timer > 0 && timer < 200) {
				for (var j:int = 0; j < 8; j++) {
					var bullet:Bullet = pool.activate();
					bullet.xPos = bullet.x = 150;
					bullet.yPos = bullet.y = 150 + j * 50;
					bullet._pathToFollow = generateWaveBulletPath(3, Math.PI/2 + j*0.5);
					_world.add(bullet);
					onScreen.push(bullet);
				}
			}
		}
		
		private function generateBulletPath(distanceBetweenPoints:Number, dir:Number):Vector.<Point>
		{
			var i:Number;
			
			var vec:Vector.<Point> = new Vector.<Point>();
			
			for (i = 0; i < 700; i += distanceBetweenPoints)
			{
				vec.push(new Point(i*Math.cos(dir), i*Math.sin(dir)));
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
		
		private function generateWaveBulletPath(distanceBetweenPoints:Number, dir:Number):Vector.<Point>
		{
			var i:Number;
			
			var vec:Vector.<Point> = new Vector.<Point>();
			
			for (i = 0; i < 700; i += distanceBetweenPoints)
			{
				vec.push(new Point(Math.cos(dir)*50, i));
				//trace(Math.sin((dir) * 25));
				dir += 0.1;
			}
			
			return vec;
		}
	}

}