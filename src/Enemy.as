package  
{
	import flash.geom.Point;
	import EnemyBullet;
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
    import net.flashpunk.World;
	
	/**
	 * The boss character that shoots at you
	 * @author Minttu Mäkinen
	 */
	public class Enemy extends Entity 
	{
		[Embed(source = '../graphics/esf.png')]
		private const EMO:Class;
		[Embed(source = '../graphics/msf.png')]
		private const MEGANE:Class;
		[Embed(source = '../graphics/ilof.png')]
		private const ILO:Class;
		[Embed(source = '../graphics/tsunf.png')]
		private const TSUN:Class;
		[Embed(source = '../graphics/bsf.png')]
		private const BOSS:Class;
         
        private var _timeToAct:uint;
        public var _pathToFollow:Vector.<Point>;
         
        private var _currentPoint:uint;
         
        private var _myWorld:World;	
        private var _added:Boolean;
		private var lives:int;
		private var _pattern:BossPattern;
		private var _patternStart:uint;
		private var _timeElapsed:Number;
		public var pause:Boolean;
		
		public function Enemy(name:String, timeToAct:uint, startPattern:uint, worldToBeAdded:World) {
			/* This function initializes the enemy information */
			
			// Selecting the correct sprite
			var sprite:Class;
			if (name == "emo") {
				sprite = EMO;
			} else if (name == "megane") {
				sprite = MEGANE;
			} else if (name == "ilo") {
				sprite = ILO;
			} else if (name == "tsun") {
				sprite = TSUN;
			} else if (name == "boss") {
				sprite = BOSS;
			}
			
			graphic = new Image(sprite);
             
			// Sprite location
			graphic.x = -28.5;
			graphic.y = -31.5;
			mask = new Pixelmask(sprite, -28.5, -31.5);
			
			// Other variables
            _timeToAct = timeToAct;
			_patternStart = startPattern;
            _currentPoint = 0;
            _myWorld = worldToBeAdded;
            _added = false;
			_timeElapsed = 0;
			
			lives = 1000;
			pause = false;
		}
		
		override public function update():void {
			/* This function updates the state of the player each turn */
			
			if (pause)
				return;
			
			if (_patternStart > 0) {
				_patternStart--;
			}
			
            if (_timeToAct > 0) {
                _timeToAct--;
            } else {
				
                if (!_added) {
                    _myWorld.add(this);
                    _added = true;
                }
				
				// Enemy moving
                x = _pathToFollow[_currentPoint].x;
                y = _pathToFollow[_currentPoint].y;
                 
                _currentPoint++;
                 
                if (_currentPoint == _pathToFollow.length){
					_currentPoint = 0;
                }
				
				// Enemy shooting a pattern
				if (_patternStart == 0) {
					_patternStart = _pattern.run(_timeElapsed);
					if (_timeElapsed > 675)
						_timeElapsed = 0;
				}
            }
			_timeElapsed += 7 * FP.elapsed;
        }
		
        public function destroy():void {
			/* Taking the enemy off-screen */
            graphic = null;
        }
		
		public function getLives():int {
			/* Return the remaining enemy lives */
			return lives;
		}
		
		public function decreaseLives(damage:int):void {
			/* Decreases the enemy lives */
			lives -= damage;
			if (lives < 0) {
				trace("This enemy is dead.");
			}
		}
		
		public function add_pattern(pattern:BossPattern):void {	
			/* Inserting the bullet pattern */
			_pattern = pattern;
		}
	}

}