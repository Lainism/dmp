package  
{
	import EnemyBullet;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import flash.geom.Point;
    import net.flashpunk.Entity;
	import flash.display.DisplayObject;
	import net.flashpunk.Sfx;
	import net.flashpunk.FP;
	import flash.system.fscommand;
	
	/**
	 * ...
	 * @author Minttu Mäkinen
	 */
	public class GameWorld extends World
	{
		[Embed(source = '../sounds/Waves.mp3')]
		private const BGM1:Class;
		[Embed(source = '../sounds/orchestra4.mp3')]
		private const BGM2:Class;
		[Embed(source = '../sounds/NovusInitium.mp3')]
		private const BGM3:Class;
		[Embed(source = '../sounds/Abyssal.mp3')]
		private const BGM4:Class;
		[Embed(source = '../sounds/anotherpiece.mp3')]
		private const BGM5:Class;
		private var bgm:Sfx;
		
		[Embed(source = '../graphics/menu/gameover.png')]
		private const GAMEOVER:Class;
		[Embed(source = '../graphics/menu/gamewon.png')]
		private const GAMEWON:Class;
		[Embed(source = '../graphics/menu/menu.png')]
		private const MENU:Class;
		[Embed(source = '../graphics/menu/quit.png')]
		private const QUIT:Class;
		private var menuButton:Button;
		private var quitButton:Button;
		private var gameOverScreen:Image;
		private var gameWonScreen:Image;
		
		private var _bg:Background;
		public var _sidebar:Sidebar;
		public var _combo:ComboGraphic;
		
		
		private var _playerShip:PlayerShip;
		private var _enemy:Enemy;
		private var _puzzle:Puzzle;
		private var _pattern:BossPattern;
		private var pause:Boolean;
		private var ended:Boolean;
		
		public var playerPool:BulletPool;
		
		public function GameWorld(playerName:String, opponentName:String) 
		{
			// Loading graphics
			new GraphicAssets();
			
			_bg = new Background(0, 0);
			
			// Initializing rest...
			_puzzle = new Puzzle(4, 3, 3);
			playerPool = new BulletPool(PlayerBullet, 20);
			_playerShip = new PlayerShip(playerName, _puzzle, this);
			
			menuButton = new Button(goMenu, null, 150, 350);
			menuButton.setSpritemap(MENU, 250, 36);
			gameOverScreen = new Image(GAMEOVER);
			gameWonScreen = new Image(GAMEWON);

			_enemy = new Enemy(opponentName, 5, 10, this);
			if (opponentName == "emo") {
				_pattern = new Pattern1(_enemy, _playerShip, this);
				bgm = new Sfx(BGM1);
			} else if (opponentName == "megane") {
				_pattern = new Pattern2(_enemy, _playerShip, this);
				bgm = new Sfx(BGM2);
			} else if (opponentName == "ilo") {
				_pattern = new Pattern3(_enemy, _playerShip, this);
				bgm = new Sfx(BGM3);
			} else if (opponentName == "tsun") {
				_pattern = new Pattern4(_enemy, _playerShip, this);
				bgm = new Sfx(BGM4);
			} else if (opponentName == "boss") {
				_pattern = new Pattern5(_enemy, _playerShip, this);
				bgm = new Sfx(BGM5);
			}
			
			_enemy.add_pattern(_pattern);
			pause = false;
			ended = false;
			
			_sidebar = new Sidebar(_playerShip.getLives());
			
			
			// Adding the entities in the correct order
			add(_bg);
			for each (var a:PuzzleNode in _puzzle.nodes) {
				add(a);
			}
			add(_playerShip);
			bgm.loop();
			add(_sidebar);
			add(_combo);
			this.bringToFront(_sidebar);
		}
		
		override public function update():void
		{	
			bringToFront(_sidebar);
			
			bringToFront(_combo);
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
							_enemy.decreaseLives(bul.damage);
							_sidebar.addScore(_playerShip.getSolved());
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
							_playerShip.decreaseLives(ebul.damage);
						}
						remove(ebul);
						_pattern.onScreen.splice(c, 1);
						_pattern.pool.deactivate(ebul);
					}
				}
			}
			
			if (_enemy.getLives() < 0) {
				pauseGame();
				ended = true;
				addGraphic(gameWonScreen);
				add(menuButton);
				return;
			} else if (_playerShip.getLives() < 0) {
				pauseGame();
				ended = true;
				addGraphic(gameOverScreen);
				add(menuButton);
				return;
			}
			
		}
		
		override public function remove(e:Entity):Entity
		{
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
			_sidebar.pause = true;
			_playerShip.pauseGame();
			_pattern.pauseGame();
		}
		
		public function continueGame():void
		{
			pause = false;
			_enemy.pause = false;
			_bg.pause = false;
			_sidebar.pause = false;
			_playerShip.continueGame();
			_pattern.continueGame();
		}
		
		public function quit():void
		{
			if (!ended)
				return;
			
			fscommand("quit");
		}
		
		public function goMenu():void
		{
			if (!ended)
				return;
			
			FP.world = new MainMenu();
			
			destroy();
		}
		
		public function destroy():void
		{
			removeAll();
			
			bgm.stop();
			quitButton = null;
			menuButton = null;
		}
			
	}

}