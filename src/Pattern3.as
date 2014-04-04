package  
{
	import flash.geom.Point;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author A.V.
	 */
	public class Pattern3 extends BossPattern
	{
		private static var angle:Number = 0.0;
		private static var dir:Number = 0.1;
		
		
		public function Pattern3(enemy:Enemy, player:PlayerShip, world:World) 
		{
			super(enemy, player, world);
			generateEnemyPath(enemy);
			for each (var bul:EnemyBullet in pool_arr) 
			{
				bul.init_bul(GraphicAssets.Ebullet_graph3, GraphicAssets.Enemy_bullet3, -8.5, -8.5, _world);
			}
		}
		
		override public function run(timer:Number):uint
		{
			var bullet:Bullet;
			var i:Number = 0.0;
			var r:Number = 50.0;
			var p:Number = 20.0;
			
			if (timer > 5 && timer < 125) {
				for (i= 0.0; i <= FULLANGLE; i = i + 0.5) {
					bullet = pool.activate();
					bullet.xPos = bullet.x = 250;
					bullet.yPos = bullet.y = 290;
					bullet._pathToFollow = generateWaveBulletPath(0.025, i);
					_world.add(bullet);
					onScreen.push(bullet);
				}
			} else if (timer > 225 && timer < 375) {
				bullet = pool.activate();
				bullet.xPos = bullet.x = _enemy.x + (r * Math.cos(angle));
				bullet.yPos = bullet.y = _enemy.y + (r * Math.sin(angle));
				bullet._pathToFollow = generateBulletPath(3, randomRange(0,200), 0);
				_world.add(bullet);
				onScreen.push(bullet);
				angle += dir;
				if (angle > FULLANGLE || angle < -FULLANGLE)
					dir *= -1;
				return 2;
			} else if (timer > 400 && timer < 670) {
				bullet = pool.activate();
				bullet.xPos = bullet.x = _enemy.x + (p * angle * Math.cos(angle));
				bullet.yPos = bullet.y = _enemy.y + (p * angle * Math.sin(angle));
				bullet._pathToFollow = generateBulletPath(3, angle, 0);
				_world.add(bullet);
				onScreen.push(bullet);
				angle += dir;
				if (angle > FULLANGLE || angle < -FULLANGLE)
					dir *= -1;
				return 3;
			} else { angle = 0.0; }
			
			return 100;
		}
		
		private function generateEnemyPath(enemy:Enemy):void
		{
			var i:Number;
			var vec:Vector.<Point> = new Vector.<Point>();
			 
			for (i = 0; i < 2 * FULLANGLE; i += 0.004)
			{
				vec.push(new Point(150 * Math.cos(2 * i) * Math.sin(3 * i) + 250, 150 * Math.cos(4 * i) + 175));
			}
		 
			enemy._pathToFollow = vec;
		}
	}

}