package  
{
	import EnemyBullet;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.World;
	import flash.geom.Point;
    import net.flashpunk.Entity;
	import flash.display.DisplayObject;
	import net.flashpunk.Sfx;
	import net.flashpunk.FP;

	
	/**
	 * ...
	 * @author Minttu Mäkinen
	 */
	public class GameWorld extends World
	{
		[Embed(source = '../sounds/Waves.mp3')]
		private const BGM1:Class;
		public var bgm1:Sfx = new Sfx(BGM1);
		private var _bg:Background;
		
		private var _playerShip:PlayerShip;
		private var _enemy:Enemy;
		private var _puzzle:Puzzle;
		
		private var _enemyBulletList:Vector.<EnemyBullet>;
		
		public var playerPool:BulletPool;
		
		public function GameWorld() 
		{
			// Loading graphics
			new GraphicAssets();
			
			FP.screen.color = 0x151733;
			_bg = new Background(0, 0);
			
			// Initializing rest...
			_puzzle = new Puzzle(4, 3, 3);
			playerPool = new BulletPool(PlayerBullet, 20);
			_playerShip = new PlayerShip(_puzzle);
			_enemy = new Enemy(0, this);
			
			// Adding the entities in the correct order
			add(_bg);
			for each (var a:PuzzleNode in _puzzle.nodes) {
				add(a);
			}
			add(_playerShip);
			bgm1.loop();
		}
		
		override public function update():void
		{
			super.update();
			
			if (_enemy)
				_enemy.update();
			
				
			if (_playerShip.bul_onscreen.length > 0) {
				for (var a:int = 0; a < _playerShip.bul_onscreen.length; a++) {
					var bul:Bullet = _playerShip.bul_onscreen[a];
					if (bul.collideWith(_enemy, bul.x, bul.y) || bul.y < 0) {
						if (bul.y >= 0)
							_enemy.decreaseLives(bul.DAMAGE);
						remove(bul);
						_playerShip.bul_onscreen.splice(a, 1);
						playerPool.deactivate(bul);
					}
				}
			}
			/*
			for each (var bullet:PlayerBullet in _bulletList) {
				if (bullet.collideWith(_enemy, bullet.x, bullet.y)) {
					_enemy.decreaseLives(bullet.DAMAGE);
					remove(bullet);
					bullet.destroy();
				}
			}*/
				
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
			//trace(_playerShip);
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