package  
{
	import flash.geom.Point;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author A.V.
	 */
	public class Pattern1 extends BossPattern
	{
		
		public function Pattern1(enemy:Enemy, player:PlayerShip, world:World) 
		{
			super(enemy, player, world);
			generateEnemyPath(enemy);
			for each (var bul:EnemyBullet in pool_arr) 
			{
				bul.init_bul(GraphicAssets.Ebullet_graph1, GraphicAssets.Enemy_bullet1, -8.5, -8.5, _world);
			}
			
		}
		
		override public function run(timer:Number):uint
		{
			var bullet:Bullet;
			var i:Number = 0.0;
			var r:Number = 20.0;
			var dir:Number = 0.0;
			
			if (timer < 150) {
				for (i = 0.0; i <= FULLANGLE; i = i + 0.15) {
					bullet = pool.activate();
					bullet.xPos = bullet.x = _enemy.x + (r * Math.cos(i));
					bullet.yPos = bullet.y = _enemy.y + (r * Math.sin(i));
					bullet._pathToFollow = generateBulletPath(3, i, 0);
					_world.add(bullet);
					onScreen.push(bullet);
				}
				return 75;
			} else if (timer > 200 && timer < 350) {
				for (i= 0.0; i <= FULLANGLE; i = i + 0.05) {
					bullet = pool.activate();
					bullet.xPos = bullet.x = _enemy.x + 15 * Math.sqrt(i) * Math.cos(i);
					bullet.yPos = bullet.y = _enemy.y + 15 * Math.sqrt(i) * Math.sin(i);
					bullet._pathToFollow = generateBulletPath(3, randomRange(0, 1000), 0);
					_world.add(bullet);
					onScreen.push(bullet);
				
				}
			} else if (timer > 400 && timer < 650) {
				for (i = 0; i < 12; i += 0.1) {
					bullet = pool.activate();
					bullet.xPos = bullet.x = _enemy.x + 150 * Math.cos(5 * i) * Math.sin(i);
					bullet.yPos = bullet.y = _enemy.y + 150 * Math.cos(5 * i) * Math.cos(i);
					bullet._pathToFollow = generateBulletPath(2, dir, 0);
					_world.add(bullet);
					onScreen.push(bullet);
					dir += 0.15;
				}
			}
			
			return 100;
		}
		
		private function generateEnemyPath(enemy:Enemy):void
		{
			var i:Number;
			var vec:Vector.<Point> = new Vector.<Point>();
			 
			for (i = 0; i < FULLANGLE; i += 0.008)
			{
				vec.push(new Point(150 * Math.cos(2 * i) * Math.sin(i) + 250, 150 * Math.cos(2 * i) * Math.cos(i) + 135));
			}
		 
			enemy._pathToFollow = vec;
		}
         
		
	}

}