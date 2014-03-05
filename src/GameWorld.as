package  
{
	import net.flashpunk.World;
	/**
	 * ...
	 * @author Minttu Mäkinen
	 */
	public class GameWorld extends World
	{
		private var _playerShip:PlayerShip;
		
		public function GameWorld() 
		{
			_playerShip = new PlayerShip();
			
			add(_playerShip);
		}
		
	}

}