package  
{
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
		}
		
		override public function run(timer:Number):uint
		{
			var bullet:Bullet;
			var i:Number = 0.0;
			var r:Number = 50.0;
			var p:Number = 20.0;
			
			if (timer < 150) {
				for (i= 0.0; i <= FULLANGLE; i = i + 0.35) {
					bullet = pool.activate();
					bullet.xPos = bullet.x = _enemy.x + 15 * Math.sqrt(i) * Math.cos(i);
					bullet.yPos = bullet.y = _enemy.y + 15 * Math.sqrt(i) * Math.sin(i);
					bullet._pathToFollow = generateWaveBulletPath(0.5, randomRange(0, 500));
					_world.add(bullet);
					onScreen.push(bullet);
				}
			} else if (timer > 200 && timer < 350) {
				bullet = pool.activate();
				bullet.xPos = bullet.x = _enemy.x + (r * Math.cos(angle));
				bullet.yPos = bullet.y = _enemy.y + (r * Math.sin(angle));
				bullet._pathToFollow = generateBulletPath(3, randomRange(0,200));
				_world.add(bullet);
				onScreen.push(bullet);
				angle += dir;
				if (angle > FULLANGLE || angle < -FULLANGLE)
					dir *= -1;
				return 2;
			} else if (timer > 400 && timer < 650) {
				bullet = pool.activate();
				bullet.xPos = bullet.x = _enemy.x + (p * angle * Math.cos(angle));
				bullet.yPos = bullet.y = _enemy.y + (p * angle * Math.sin(angle));
				bullet._pathToFollow = generateBulletPath(3, angle);
				_world.add(bullet);
				onScreen.push(bullet);
				angle += dir;
				if (angle > FULLANGLE || angle < -FULLANGLE)
					dir *= -1;
				return 3;
			} else { angle = 0.0; }
			
			return 100;
		}
		
	}

}