package  
{
	import EnemyBullet;
	import net.flashpunk.World;
	import flash.geom.Point;
    import net.flashpunk.Entity;
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Minttu Mäkinen
	 */
	public class GameWorld extends World
	{
		private var _playerShip:PlayerShip;
		private var _enemy:Enemy;
		private var _puzzle:Puzzle;
		
		private var _enemyBulletList:Vector.<EnemyBullet>;
		
		public var playerPool:BulletPool;
		
		public function GameWorld() 
		{
			// Loading bullet graphics
			new GraphicAssets();
			
			// Initializing rest...
			_puzzle = new Puzzle(4, 3, 3);
			_playerShip = new PlayerShip(_puzzle);
			_enemy = new Enemy(0, this);
			playerPool = new BulletPool(PlayerBullet, 50);
			
			// Adding the sprites for puzzle nodes
			for each (var a:PuzzleNode in _puzzle.nodes) {
				add(a);
			}
			add(_playerShip);
		}
		
		override public function update():void
		{
			super.update();
			
			if (_enemy)
				_enemy.update();
			
			if (_playerShip.bul_onscreen.length > 0) {
				for (var a:int = 0; a < _playerShip.bul_onscreen.length; a++) {
					var bul:PlayerBullet = _playerShip.bul_onscreen[a];
					if (bul.collideWith(_enemy, bul.x, bul.y) || bul.y < 0) {
						_enemy.takeDamage();
						remove(bul);
						_playerShip.bul_onscreen.splice(a, 1);
						playerPool.deactivate(bul);
						trace("Bullet deactivated");
					}
				}
			}
				
			_enemyBulletList = new Vector.<EnemyBullet>();
			getType("EnemyBullet", _enemyBulletList);
			
			for each (var Ebullet:EnemyBullet in _enemyBulletList) {
				if (Ebullet.collideWith(_playerShip, Ebullet.x, Ebullet.y)) {
					remove(Ebullet);
					Ebullet.destroy();
				}
			}
		}
		
		override public function remove(e:Entity):Entity
		{
			if (e is Enemy)
			{
				_enemy = new Enemy(0, this);
			}
			 
			return super.remove(e);
		}
		
		public function generatePlayerBulletPath(distanceBetweenPoints:Number):Vector.<Point>
		{
			var i:Number;
			 
			var vec:Vector.<Point> = new Vector.<Point>();
			
			var edge_dist:Number = -_playerShip.y - 20;
			 
			for (i = 0; i > edge_dist; i -= distanceBetweenPoints)
			{
				vec.push(new Point(0, i));
			}
			 
			return vec;
		}
			
		public function generateEnemyBulletPath(distanceBetweenPoints:Number):Vector.<Point>
		{
			var i:Number;
			
			var vec:Vector.<Point> = new Vector.<Point>();
			
			for (i = 0; i < 490; i += distanceBetweenPoints)
			{
				vec.push(new Point(0, i));
			}
			
			return vec;
		}
	}

}