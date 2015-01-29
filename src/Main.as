package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * The main function that starts it all...
	 * @author Minttu Mäkinen
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Engine {
		
		public function Main():void {
			//when the bar is added, will be 800x600
			super(800, 600, 35, false);
		}
		
		override public function init():void {
			FP.world = new MainMenu();
			//FP.console.enable();
		}
	}
	
}