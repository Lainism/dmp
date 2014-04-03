package  
{
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
					bullet._pathToFollow = generateBulletPath(3, i);
					_world.add(bullet);
					onScreen.push(bullet);
				}
			} else if (timer > 200 && timer < 350) {
				for (i= 0.0; i <= FULLANGLE; i = i + 0.05) {
					bullet = pool.activate();
					bullet.xPos = bullet.x = _enemy.x + 15 * Math.sqrt(i) * Math.cos(i);
					bullet.yPos = bullet.y = _enemy.y + 15 * Math.sqrt(i) * Math.sin(i);
					bullet._pathToFollow = generateBulletPath(3, randomRange(0, 1000));
					_world.add(bullet);
					onScreen.push(bullet);
				
				}
			} else if (timer > 400 && timer < 650) {
				for (i = 0; i < 12; i += 0.1) {
					bullet = pool.activate();
					bullet.xPos = bullet.x = _enemy.x + 150 * Math.cos(5 * i) * Math.sin(i);
					bullet.yPos = bullet.y = _enemy.y + 150 * Math.cos(5 * i) * Math.cos(i);
					bullet._pathToFollow = generateBulletPath(2, dir);
					_world.add(bullet);
					onScreen.push(bullet);
					dir += 0.15;
				}
			}
			
			return 100;
		}
		
	}

}