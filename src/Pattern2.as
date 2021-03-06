package  
{
	import flash.geom.Point;
	import net.flashpunk.World;
	/**
	 * 
	 * @author A.V.
	 */
	public class Pattern2 extends BossPattern
	{
		
		public function Pattern2(enemy:Enemy, player:PlayerShip, world:World) 
		{
			super(enemy, player, world);
			generateEnemyPath(enemy);
			for each (var bul:EnemyBullet in pool_arr) 
			{
				bul.init_bul(GraphicAssets.Ebullet_graph2, GraphicAssets.Enemy_bullet2, -8.5, -8.5, _world);
			}
		}
		
		override public function run(timer:Number):uint
		{
			var bullet:Bullet;
			var i:Number = 0.0;
			var r:Number = 10.0;
			var angle:Number = 0.0;
			var rand:Number = randomRange(5, 35);
			
			if (timer < 150) {
				for (i = 0; i <= rand; i++)
				{
					if (!randomRange( -3, 3))
						continue;
					bullet = pool.activate();
					bullet.xPos = bullet.x = i * 20;
					bullet.yPos = bullet.y = 0;
					bullet._pathToFollow = generateBulletPath(3, Math.PI / 2, 0);
					_world.add(bullet);
					onScreen.push(bullet);
				}
				for (var j:Number = 0; j <= rand - 5; j++) 
				{
					if (!randomRange( -1, 2))
						continue;
					bullet = pool.activate();
					bullet.xPos = bullet.x = 0;
					bullet.yPos = bullet.y = j * 25;
					bullet._pathToFollow = generateBulletPath(3, 0, 0);
					_world.add(bullet);
					onScreen.push(bullet);
				}
			} else if (timer > 200 && timer < 380) {
				for (i = 0; i < FULLANGLE; i += 0.15) 
				{
					bullet = pool.activate();
					bullet.xPos = bullet.x = _enemy.x + (r * (6 * Math.cos(i) - Math.cos(6*i)));
					bullet.yPos = bullet.y = _enemy.y + (r * (6 * Math.sin(i) - Math.sin(6*i)));
					bullet._pathToFollow = generateHomingBulletPath(3, 0);
					_world.add(bullet);
					onScreen.push(bullet);
				}
				return 75;
			} else if (timer > 400 && timer < 630) {
				for (i = 0; i < 12; i += 0.12) {
					bullet = pool.activate();
					bullet.xPos = bullet.x = _enemy.x + 150 * Math.cos(3.5 * i) * Math.sin(i);
					bullet.yPos = bullet.y = _enemy.y + 150 * Math.cos(2 * i) * Math.cos(i);
					bullet._pathToFollow = generateBulletPath(2, angle, 0);
					_world.add(bullet);
					onScreen.push(bullet);
					angle += 0.2;
				}
			}
			
			return 100;
		}
		
		private function generateEnemyPath(enemy:Enemy):void
		{
			var i:Number;
			 
			var vec:Vector.<Point> = new Vector.<Point>();
			
			for (i = 0; i < 2*FULLANGLE; i += 0.008)
			{
				vec.push(new Point(150 * Math.cos(1.5 * i) * Math.sin(i) + 250, 150 * Math.cos(1.5 * i) * Math.cos(i) + 195));
			}
		 
			enemy._pathToFollow = vec;
		}
	}

}