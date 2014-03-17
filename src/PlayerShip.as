package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Minttu Mäkinen
	 */
	public class PlayerShip extends Entity 
	{
		[Embed(source = "../graphics/msb.png")]
		private const IMAGE:Class;
		private var _timeElapsed:Number;
		
		public function PlayerShip() 
		{
			graphic = new Image(IMAGE);
			
			graphic.x = -28.5;
			graphic.y = -31.5;
			
			x = 250;
			y = 500;
			
			_timeElapsed = 0;
		}
		
		override public function update():void
		{
			    if (Input.check(Key.A) || Input.check(Key.LEFT))
				{
					x -= 150 * FP.elapsed;
					if (x < 0) {
						x = 0;
					}
				}
				else if (Input.check(Key.D) || Input.check(Key.RIGHT))
				{
					x += 150 * FP.elapsed;
					if (x > 500) {
						x = 500;
					}
				}
				 
				if (Input.check(Key.W) || Input.check(Key.UP))
				{
					y -= 150 * FP.elapsed;
					if (y < 0) {
						y = 0;
					}
				}
				else if (Input.check(Key.S) || Input.check(Key.DOWN))
				{
					y += 150 * FP.elapsed;
					if (y > 600) {
						y = 600;
					}
				}
				
				if (Input.check(Key.SPACE) && _timeElapsed > 1)
				{
					_timeElapsed = 0;
					world.add(new PlayerBullet(GameWorld(world).generateBulletPath(3), x, y));
				}
				
				_timeElapsed += 7 * FP.elapsed;
		}
		
	}
	
}