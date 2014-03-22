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
		private var _puzzle:Puzzle;
		
		private var _bulletList:Vector.<PlayerBullet>;
		private var _enemyBulletList:Vector.<EnemyBullet>;
		
		public function GameWorld() 
		{
			//initializing...
			_puzzle = new Puzzle(4, 3, 3);
			_playerShip = new PlayerShip(_puzzle);
			_enemy = new Enemy(0, this);
			
			//adding the sprites
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
				
			_bulletList = new Vector.<PlayerBullet>();
			getType("PlayerBullet", _bulletList);
			
			for each (var bullet:PlayerBullet in _bulletList) {
				if (bullet.collideWith(_enemy, bullet.x, bullet.y)) {
					_enemy.decreaseLives(bullet.DAMAGE);
					remove(bullet);
					bullet.destroy();
				}
			}
			
			_enemyBulletList = new Vector.<EnemyBullet>();
			getType("EnemyBullet", _enemyBulletList);
			
			for each (var Ebullet:EnemyBullet in _enemyBulletList) {
				if (Ebullet.collideWith(_playerShip, Ebullet.x, Ebullet.y)) {
					_playerShip.decreaseLives(Ebullet.DAMAGE);
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