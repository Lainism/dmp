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
	 * ...
	 * @author Minttu Mäkinen
	 */
	public class Enemy extends Entity 
	{
		[Embed(source = '../graphics/esf.png')]
        private const IMAGE:Class;
         
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
		
		public function Enemy(timeToAct:uint, startPattern:uint, worldToBeAdded:World) 
		{
			graphic = new Image(IMAGE);
             
			graphic.x = -28.5;
			graphic.y = -31.5;
            
			mask = new Pixelmask(IMAGE, -28.5, -31.5);
			
            _timeToAct = timeToAct;
             
			_patternStart = startPattern;
             
            _currentPoint = 0;
             
            _myWorld = worldToBeAdded;
            _added = false;
			lives = 10;
			
			_timeElapsed = 0;
			pause = false;
		}
		
		override public function update():void
        {
			if (pause)
				return;
			
			if (_patternStart > 0)
			{
				_patternStart--;
			}
			
            if (_timeToAct > 0)
            {
                _timeToAct--;
            }
            else
            {
                if (!_added)
                {
                    _myWorld.add(this);
                     
                    _added = true;
                }
				
                x = _pathToFollow[_currentPoint].x;
                y = _pathToFollow[_currentPoint].y;
                 
                _currentPoint++;
                 
                if (_currentPoint == _pathToFollow.length)
                {
					_currentPoint = 0;
                }
				
				if (_patternStart == 0)
				{
					_patternStart = _pattern.run(_timeElapsed);
					if (_timeElapsed > 675)
						_timeElapsed = 0;
				}
            }
			_timeElapsed += 7 * FP.elapsed;
        }
		
        public function destroy():void
        {
            graphic = null;
        }
		
		public function getLives():int {
			return lives;
		}
		
		public function decreaseLives(damage:int):void
		{
			lives -= damage;
			if (lives < 0) {
				trace("This enemy is dead.");
			}
		}
		
		public function add_pattern(pattern:BossPattern):void
		{	
			_pattern = pattern;
		}
	}

}