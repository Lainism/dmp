package  
{
	import flash.geom.Point;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author A.V.
	 */
	public class Pattern4 extends BossPattern
	{
		
		public function Pattern4(enemy:Enemy, player:PlayerShip, world:World) 
		{
			super(enemy, player, world);
			generateEnemyPath(1, enemy);
		}
		
		override public function run(timer:Number):uint
		{
			var bullet:Bullet;
			var i:Number = 0.0;
			var r:Number = 100.0;
			var dir:Number = 0.0;
			var rand:Number = randomRange(15, 50);
			
			if (timer < 150) {
				for (i = 0; i <= rand; i++)
				{
					if (!randomRange( -3, 3))
						continue;
					bullet = pool.activate();
					bullet.xPos = bullet.x = i * 20;
					bullet.yPos = bullet.y = i * 5;
					bullet._pathToFollow = generateBulletPath(3, randomRange(0,1000), 0);
					_world.add(bullet);
					onScreen.push(bullet);
				}
				for (var j:Number = 0; j <= rand; j++) 
				{
					if (!randomRange( -1, 2))
						continue;
					bullet = pool.activate();
					bullet.xPos = bullet.x = 500 - j * 10;
					bullet.yPos = bullet.y = 600 - j * 20;
					bullet._pathToFollow = generateBulletPath(3, randomRange(0, 1000), 0);
					_world.add(bullet);
					onScreen.push(bullet);
				}
				for (var k:Number = 0; k <= rand; k++) 
				{
					if (!randomRange( -1, 2))
						continue;
					bullet = pool.activate();
					bullet.xPos = bullet.x = k * 5;
					bullet.yPos = bullet.y = k * 25;
					bullet._pathToFollow = generateBulletPath(3, randomRange(0, 1000), 0);
					_world.add(bullet);
					onScreen.push(bullet);
				}
				
			} else if (timer > 200 && timer < 350) {
				for (i = 0; i < FULLANGLE; i += 0.10) 
				{
					bullet = pool.activate();
					bullet.xPos = bullet.x = _enemy.x + (r * ((2/3) * Math.cos(i) + (1/3) * Math.cos(2*i)));
					bullet.yPos = bullet.y = _enemy.y + (r * ((2/3) * Math.sin(i) - (1/3) * Math.sin(2*i)));
					bullet._pathToFollow = generateBulletPath(3, randomRange(0, 555), 0);
					_world.add(bullet);
					onScreen.push(bullet);
				}
				return 75;
			} else if (timer > 400 && timer < 650) {
				for (i = 0; i < FULLANGLE; i += 0.15) 
				{
					bullet = pool.activate();
					bullet.xPos = bullet.x = _enemy.x + (r * ((2/3) * Math.cos(i) + (1/3) * Math.cos(2*i)));
					bullet.yPos = bullet.y = _enemy.y + (r * ((2/3) * Math.sin(i) - (1/3) * Math.sin(2*i)));
					bullet._pathToFollow = generateHomingBulletPath(3, 0);
					_world.add(bullet);
					onScreen.push(bullet);
				}
				return 75;
			}
			
			return 100;
		}
		
		private function generateEnemyPath(distanceBetweenPoints:Number, enemy:Enemy):void
		{
			var i:Number;
			 
			var vec:Vector.<Point> = new Vector.<Point>();
			 
			var yPos:Number = 125;
			 
			for (i = 0; i*0.01 < 2*Math.PI; i += distanceBetweenPoints)
			{
				vec.push(new Point((Math.cos(i*0.01 + Math.PI / 2)+1)*200+50, yPos));
			}
		 
			enemy._pathToFollow = vec;
		}
	}

}