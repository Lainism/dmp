package  
{
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
					bullet._pathToFollow = generateBulletPath(3, Math.PI / 2);
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
			} else if (timer > 200 && timer < 350) {
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
			} else if (timer > 400 && timer < 650) {
				for (i = 0; i < 12; i += 0.1) {
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
	}

}