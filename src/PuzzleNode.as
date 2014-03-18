package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Minttu Mäkinen
	 */
	public class PuzzleNode extends Entity
	{
		[Embed(source = "../graphics/pnb.png")]
		private const BLUE:Class;
		[Embed(source = "../graphics/pnr.png")]
		private const RED:Class;
		[Embed(source = "../graphics/png.png")]
		private const GREEN:Class;
		
		public function PuzzleNode(color:uint, nx:uint, ny:uint) 
		{
			if (color == 0) {
				graphic = new Image(BLUE);
			}
			
			if (color == 1) {
				graphic = new Image(RED);
			}
			
			if (color == 2) {
				graphic = new Image(GREEN);
			}
			
			graphic.x = -37.5;
			graphic.y = -37.5;
			
			x = nx;
			y = ny;
		}
		
		override public function update():void
		{}
		
	}

}