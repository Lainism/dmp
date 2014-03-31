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
		private var bgm1:Sfx = new Sfx(BGM1);
		private var _bg:Background;
		public var _sidebar:Sidebar;
		public var _combo:ComboGraphic;
		
		
		private var _playerShip:PlayerShip;
		private var _enemy:Enemy;
		private var _puzzle:Puzzle;
		private var _pattern:BossPattern;
		private var pause:Boolean;
		
		public var playerPool:BulletPool;
		
		public function GameWorld() 
		{
			// Loading graphics
			new GraphicAssets();
			
			_bg = new Background(0, 0);
			
			// Initializing rest...
			_puzzle = new Puzzle(4, 3, 3);
			playerPool = new BulletPool(PlayerBullet, 20);
			_playerShip = new PlayerShip(_puzzle, this);
			
			//Change this according to which character the player is using!
			_combo = new ComboGraphic("emo");
			
			_enemy = new Enemy(5, 10, this);
			_pattern = new BossPattern(_enemy, this);
			_enemy.add_pattern(_pattern);
			pause = false;
			
			_sidebar = new Sidebar(_playerShip.getLives());
			
			
			// Adding the entities in the correct order
			add(_bg);
			for each (var a:PuzzleNode in _puzzle.nodes) {
				add(a);
			}
			add(_playerShip);
			bgm1.loop();
			add(_sidebar);
			add(_combo);
			this.bringToFront(_sidebar);
		}
		
		override public function update():void
		{	
			this.bringToFront(_sidebar);
			super.update();
			
			if (pause)
				return;
			
			if (_enemy)
				_enemy.update();
			
			if (_playerShip.bul_onscreen.length > 0) {
				for (var a:int = 0; a < _playerShip.bul_onscreen.length; a++) {
					var bul:Bullet = _playerShip.bul_onscreen[a];
					if (bul.collideWith(_enemy, bul.x, bul.y) || bul.y < 0) {
						if (bul.y >= 0) {
							_enemy.decreaseLives(bul.DAMAGE);
							_sidebar.addScore();
						}
						remove(bul);
						_playerShip.bul_onscreen.splice(a, 1);
						playerPool.deactivate(bul);
					}
				}
			}
				
			if (_pattern.onScreen.length > 0) {
				for (var c:int = 0; c < _pattern.onScreen.length; c++) {
					var ebul:Bullet = _pattern.onScreen[c];
					if (ebul.collideWith(_playerShip, ebul.x, ebul.y) || !(ebul.x > -30 && ebul.x < 530 && ebul.y > -30 && ebul.y < 630))
					{
						if (ebul.collideWith(_playerShip, ebul.x, ebul.y))
						{
							_playerShip.decreaseLives(ebul.DAMAGE);
						}
						remove(ebul);
						_pattern.onScreen.splice(c, 1);
						_pattern.pool.deactivate(ebul);
					}
				}
			}
		}
		
		override public function remove(e:Entity):Entity
		{
			if (e is Enemy)
			{
				_enemy = new Enemy(0, 10, this);
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
		
		public function pauseGame():void
		{
			pause = true;
			_enemy.pause = true;
			_bg.pause = true;
			_playerShip.pauseGame();
			_pattern.pauseGame();
		}
		
		public function continueGame():void
		{
			pause = false;
			_enemy.pause = false;
			_bg.pause = false;
			_playerShip.continueGame();
			_pattern.continueGame();
		}
			
	}

}