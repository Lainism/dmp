package  
{
	import flash.geom.Point;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author A.V.
	 */
	public class Pattern5 extends BossPattern
	{
		
		private static var angle:Number = 0.0;
		
		public function Pattern5(enemy:Enemy, player:PlayerShip, world:World) 
		{
			super(enemy, player, world);
			generateEnemyPath(enemy);
			for each (var bul:EnemyBullet in pool_arr) 
			{
				bul.init_bul(GraphicAssets.Ebullet_graph5, GraphicAssets.Enemy_bullet5, -8.5, -8.5, _world);
			}
		}
		
		override public function run(timer:Number):uint
		{
			var bullet:Bullet;
			var r:Number = 150.0;
		
			if (timer < 150) {
				bullet = pool.activate();
				bullet.xPos = bullet.x = 250 + r * Math.cos(4 * angle) * Math.sin(angle);
				bullet.yPos = bullet.y = 150 + r * Math.cos(3 * angle) * Math.cos(angle);
				bullet._pathToFollow = generateHomingBulletPath(2, 75);
				_world.add(bullet);
				onScreen.push(bullet);
				angle += 0.1;
				return 5;
			} else if (timer > 200 && timer < 350) {
				bullet = pool.activate();
				bullet.xPos = bullet.x = _enemy.x + r * Math.cos(3 * angle) * Math.sin(angle);
				bullet.yPos = bullet.y = _enemy.y + r * Math.cos(2 * angle) * Math.cos(angle);
				bullet._pathToFollow = generateBulletPath(2, randomRange(0,1000), 50);
				_world.add(bullet);
				onScreen.push(bullet);
				angle += 0.1;
				return 2;
			} else if (timer > 400 && timer < 650) {
				bullet = pool.activate();
				bullet.xPos = bullet.x = _enemy.x - 95;
				bullet.yPos = bullet.y = _enemy.y;
				bullet._pathToFollow = generateBulletPathWithRotation(3, randomRange(0,1000));
				_world.add(bullet);
				onScreen.push(bullet);
				return 2;
			} else { angle = 0.0; }
			
			return 100;
		}
		
		private function generateEnemyPath(enemy:Enemy):void
		{
			var i:Number;
			var vec:Vector.<Point> = new Vector.<Point>();
			 
			for (i = 0; i < 2*FULLANGLE; i += 0.004)
			{
				vec.push(new Point(150 * Math.sin(2 * i) * Math.sin(3.5 * i) + 250, 150 * Math.cos(0.5 * i) * Math.cos(3 * i + 1) + 185));
			}
		 
			enemy._pathToFollow = vec;
		}
		
	}

}