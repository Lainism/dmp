package  
{
	import net.flashpunk.World;
	/**
	 * ...
	 * @author A.V.
	 */
	public class Pattern3 extends BossPattern
	{
		
		public function Pattern3(enemy:Enemy, player:PlayerShip, world:World) 
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
				
			} else if (timer > 200 && timer < 350) {
				
			} else if (timer > 400 && timer < 650) {
				
			}
			
			return 100;
		}
		
	}

}