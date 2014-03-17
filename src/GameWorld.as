package  
{
	import net.flashpunk.World;
	import flash.geom.Point;
    import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author Minttu Mäkinen
	 */
	public class GameWorld extends World
	{
		private var _playerShip:PlayerShip;
		private var _enemy:Enemy;
		
		public function GameWorld() 
		{
			_playerShip = new PlayerShip();
			
			add(_playerShip);
			
			_enemy = new Enemy(0, this);
		}
		
		override public function update():void
		{
			super.update();
			
			if (_enemy)
				_enemy.update();
		}
		
		override public function remove(e:Entity):Entity
		{
			if (e is Enemy)
			{
				_enemy = new Enemy(0, this);
			}
			 
			return super.remove(e);
		}
		
		public function generateBulletPath(distanceBetweenPoints:Number):Vector.<Point>
		{
			var i:Number;
			 
			var vec:Vector.<Point> = new Vector.<Point>();
			 
			for (i = 0; i > -500; i -= distanceBetweenPoints)
			{
				vec.push(new Point(0, i));
			}
			 
			return vec;
		}
			
		}

}