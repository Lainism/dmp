package  
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.Entity;
	
	/**
	 * The scrolling background behind the characters
	 * @author Minttu Mäkinen
	 */
	public class Background extends Entity
	{
		
	[Embed(source = '../graphics/stars2.png')]
	private const STARS:Class;
    private var backdrop:Backdrop;
	public var pause:Boolean;
	
		public function Background(x:int = 0, y:int = 0) {
			/* Initializing */
			backdrop = new Backdrop(STARS, false, true);
			graphic = backdrop;

			super(x, y, graphic);	
			pause = false;
		}
		
		override public function update():void {
			/* Performing the scrolling */
			if (pause)
				return;
			y += 50 * FP.elapsed;
		}
		
	}

}