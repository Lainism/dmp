package  
{
	import flash.geom.Point;
	import net.flashpunk.World;
	
	/**
	 * A bullet pattern for the main boss.
	 * @author A.V.
	 */
	public class BossPattern 
	{
		private var pool:BulletPool;
		private var _enemy:Enemy;
		private var _world:World;
		
		public function BossPattern(enemy:Enemy, world:World) 
		{
			_enemy = enemy;
			_world = world;
			pool = new BulletPool(EnemyBullet, 500);
			var pool_arr:Array = pool.get_pool();
			for each (var bul:EnemyBullet in pool_arr) 
			{
				bul.init_bul(GraphicAssets.Ebullet_graph1, GraphicAssets.Enemy_bullet1, -12.5, -12.5);
			}
		}
		
		public function run():void 
		{
			var r:Number = 20.0;
			for (var i:Number = 0.0; i <= 2 * Math.PI; i = i + 0.15) {
				var bullet:Bullet = pool.activate();
				bullet.xPos = bullet.x = _enemy.x + (r * Math.cos(i));
				bullet.yPos = bullet.y = _enemy.y + (r * Math.sin(i));
				bullet._pathToFollow = generateBulletPath(3, i);
				_world.add(bullet);
			}
		}
		
		private function generateBulletPath(distanceBetweenPoints:Number, dir:Number):Vector.<Point>
		{
			var i:Number;
			
			var vec:Vector.<Point> = new Vector.<Point>();
			
			for (i = 0; i < 490; i += distanceBetweenPoints)
			{
				vec.push(new Point(i*Math.cos(dir), i*Math.sin(dir)));
			}
			
			return vec;
		}
		
	}

}