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
		
		override public function run(timer:Number):void
		{
			var bullet:Bullet;
			var i:Number = 0.0;
			var r:Number = 20.0;
			var dir:Number = 0.0;
			
			if (timer < 150) {
				for (i = 0; i <= 5; i++) {
					for (var j:int = 0; j < 3; j++) {
						bullet = pool.activate();
						bullet.xPos = bullet.x = _enemy.x + (r * Math.cos((i/5)*FULLANGLE))
						bullet.yPos = bullet.y = _enemy.y + (r * Math.sin((i/5)*FULLANGLE));
						bullet._pathToFollow = generateBulletPath(3, (j / 3) * FULLANGLE);
						_world.add(bullet);
						onScreen.push(bullet);
					}
				}
			}
		}
	}

}