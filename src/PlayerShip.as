package 
{
	import EnemyBullet;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Masklist;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * The ship the player is controlling
	 * @author Minttu Mäkinen
	 */
	public class PlayerShip extends Entity 
	{
		[Embed(source = '../graphics/esb.png')]
		private const EMO:Class;
		[Embed(source = '../graphics/msb.png')]
		private const MEGANE:Class;
		[Embed(source = '../graphics/ilob.png')]
		private const ILO:Class;
		[Embed(source = '../graphics/tsunb.png')]
		private const TSUN:Class;
		[Embed(source = '../graphics/bsb.png')]
		private const BOSS:Class;
		[Embed(source = "../graphics/circle.png")]
		private const CIRCLE:Class;
		[Embed(source = '../sounds/shoot2.mp3')]
		private const SHOOT1:Class;
		[Embed(source = '../sounds/bells2.mp3')]
		private const BELLS:Class;
		private var shoot:Sfx;
		private var puzzleChime:Sfx;
		private var playerSprite:Image;
		private var modeSprite:Image;
		private var sprites:Graphiclist;
		
		private var _timeElapsed:Number;
		private var _puzzle:Puzzle;
		private var _playerWorld:GameWorld;
		private var pause:Boolean;
		private var invincible:Boolean;
		private var timer:Number;
		
		public var bul_onscreen:Vector.<Bullet>;
		private var lives:int;
		private var bulletDamage:int;
		private var solvedPuzzles:int;
		private var comboPuzzles:int;
		private var solved:Boolean;
		private var timeLimit:int;
		
		public function PlayerShip(name:String, puzzle:Puzzle, world:GameWorld) {
			/* This function initializes the player character information */
			
			this._puzzle = puzzle;
			this._playerWorld = world;
			lives = 100;
			shoot = new Sfx(SHOOT1);
			puzzleChime = new Sfx(BELLS);
			
			// Selecting which sprite to use
			var sprite:Class;
			if (name == "emo") {
				sprite = EMO;
				world._combo = new ComboGraphic("emo");
			} else if (name == "megane") {
				sprite = MEGANE;
				world._combo = new ComboGraphic("megane");
			} else if (name == "ilo") {
				sprite = ILO;
				world._combo = new ComboGraphic("ilo");
			} else if (name == "tsun") {
				sprite = TSUN;
				world._combo = new ComboGraphic("tsun");
			} else if (name == "boss") {
				sprite = BOSS;
				world._combo = new ComboGraphic("boss");
			}
			
			// Location of the player and the location of the sprite
			playerSprite = new Image(sprite);
			playerSprite.x = -28.5;
			playerSprite.y = -31.5;
			
			modeSprite = new Image(CIRCLE);
			modeSprite.x = -60;
			modeSprite.y = -60;
			modeSprite.visible = false;
			
			sprites = new Graphiclist(playerSprite, modeSprite);
			graphic = sprites;
			
			// Setting the hitbox
			mask = new Pixelmask(sprite, -28.5, -31.5);
			this.setHitbox(10, 10, 0, 0);
			x = 250;
			y = 500;
			
			// Statistics
			invincible = false;
			_timeElapsed = 0;
			timer = -1;
			timeLimit = 50;
			
			bulletDamage = 1;
			solvedPuzzles = 0;
			comboPuzzles = 0;
			solved = false;
			
			bul_onscreen = new Vector.<Bullet>();
		}
		
		public function getLives():int {
			/* Returns the amount of lives left */
			return lives;
		}
		
		public function getSolved():int {
			/* Returns the amount of solved puzzles */
			return solvedPuzzles;
		}
		
		public function getLimit():int {
			/* Returns the current time limit */
			return timeLimit;
		}
		
		override public function update():void {
			/* This function updates the state of the player each turn */
			
			// Check puzzle and pause timers
			if (timer >= 0) {
				timer += 5 * FP.elapsed;
				//trace(timer);
				if (timer >= 5 && !pause && solved) {
					// If puzzle is solved reset the puzzle and add invincibility
					_puzzle.shuffle();
					_puzzle.reset();
					invincible = true;
					modeSprite.visible = true;
					timer = 5;
					solvedPuzzles++;
					comboPuzzles++;
					bulletDamage += comboPuzzles * comboPuzzles;
					_playerWorld._combo.comboAmount(comboPuzzles);
					_playerWorld._sidebar.changeBulletDamage(bulletDamage, timeLimit);
					_playerWorld._sidebar.showCombobar();
					
					timeLimit -= 5;
					if (timeLimit < 30) {
						timeLimit = 30;
					}
					trace(timeLimit);
					
					// Paused, so we can add some cool graphic here without disturbing the game
					_playerWorld.pauseGame();
					_playerWorld._combo.entryAnimation(5);
					puzzleChime.play(1.5);
					
					solved = false;
				} else if (timer >= timeLimit) {
					// End invincibility
					timer = -1;
					timeLimit = 50;
					invincible = false;
					comboPuzzles = 0;
					modeSprite.visible = false;
					_playerWorld._sidebar.combobar.visible = false;
				} else if (timer >= 20) {
					// When the puzzle solving graphic is over...
					_playerWorld.continueGame();
					_playerWorld._sidebar.decrease = true;
				} else if (timer >= 10) {
					// Start sliding the graphic off-screen
					_playerWorld._combo.exitAnimation(5);
					//_playerWorld._sidebar.startCountdown();
				}
			}
			
			if (pause) {
				return;
			}
			
			//Game controls
			if (Input.check(Key.A) || Input.check(Key.LEFT)) {
				x -= 150 * FP.elapsed;
				if (x < 0) {
					x = 0;
				}
			} else if (Input.check(Key.D) || Input.check(Key.RIGHT)) {
				x += 150 * FP.elapsed;
				if (x > 500) {
					x = 500;
				}
			}
			 
			if (Input.check(Key.W) || Input.check(Key.UP)) {
				y -= 150 * FP.elapsed;
				if (y < 0) {
					y = 0;
				}
			} else if (Input.check(Key.S) || Input.check(Key.DOWN)) {
				y += 150 * FP.elapsed;
				if (y > 600) {
					y = 600;
				}
			}
			
			// Shooting
			if (Input.check(Key.SPACE) && _timeElapsed > 2) {
				_timeElapsed = 0;
				shoot.play(0.6);
				
				var bull:Bullet = GameWorld(world).playerPool.activate();
				bull.damage = bulletDamage;
				bull.xPos = bull.x = this.x;
				bull.yPos = bull.y = this.y;
				bull._pathToFollow = GameWorld(world).generatePlayerBulletPath(3);
				world.add(bull);
				bul_onscreen.push(bull);
			}
			
			// Reseting the puzzle
			if (Input.pressed(Key.R))
				_puzzle.reset();
			
			if (Input.pressed(Key.N))
			{
				_puzzle.shuffle();
				_puzzle.reset();
			}
			
			
			// Rotating the puzzle
			if (Input.pressed(Key.ENTER))
			{
				if (x > 150 && y > 400 && x <= 225 && y <= 475) {
					_puzzle.rotate(0);
				} else if (x > 225 && y > 400 && x <= 300 && y <= 475) {
					_puzzle.rotate(1);
				} else if (x > 300 && y > 400 && x <= 375 && y <= 475) {
					_puzzle.rotate(2);
				} else if (x > 150 && y > 475 && x <= 225 && y <= 550) {
					_puzzle.rotate(3);
				} else if (x > 225 && y > 475 && x <= 300 && y <= 550) {
					_puzzle.rotate(4);
				} else if (x > 300 && y > 475 && x <= 375 && y <= 550) {
					_puzzle.rotate(5);
				}
				if (_puzzle.compareSolution()) {
					timer = 0;
					solved = true;
				}
			}
			
			// Advance auto-shoot timer
			_timeElapsed += 7 * FP.elapsed;
		}
		
		public function pauseGame():void {
			/* Sets the game in a pause mode */
			
			for each (var b:Bullet in bul_onscreen)
			{
				b.pause = true;
			}
			pause = true;
		}
		
		public function continueGame():void {
			/* Starts the game again after a pause */
			
			for each (var b:Bullet in bul_onscreen)
			{
				b.pause = false;
			}
			pause = false;
		}
		
		public function decreaseLives(damage:int):void {
			/* Decreases lives when the player is not invincible */
			
			if (invincible)
				return;
				
			lives -= damage;
			_playerWorld._sidebar.changeLives(lives);
		}
		
	}
	
}