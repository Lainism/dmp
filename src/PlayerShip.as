package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Minttu Mäkinen
	 */
	public class PlayerShip extends Entity 
	{
		[Embed(source = '../graphics/msb.png')]
		private const IMAGE:Class;
		
		public function PlayerShip(); 
		{
			//graphic = new Image(IMAGE);
			
			//graphic.x = -27.5;
			//graphic.y = -30;
			
			//x = 500;
			//y = 600;
		}
		
	}
	
}