package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Minttu Mäkinen
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Engine 
	{
		private var _gameWorld:GameWorld;
		
		public function Main():void 
		{
			super(500, 600, 30, false);
			
			_gameWorld = new GameWorld();
		}
		
		override public function init():void
		{
			FP.world = _gameWorld;
		}
	}
	
}