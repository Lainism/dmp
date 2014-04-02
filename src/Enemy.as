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
        private var _pathToFollow:Vector.<Point>;
         
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
			
            _pathToFollow = generateEnemyPath(1);
             
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
				
                x = _pathToFollow[0].x;
                y = _pathToFollow[0].y;
                 
                _currentPoint++;
                 
                if (_currentPoint == _pathToFollow.length)
                {
					_currentPoint = 0;
                }
				
				if (_patternStart == 0)
				{
					_pattern.run(_timeElapsed);
					_patternStart = 5;
				}
            }
			_timeElapsed += 7 * FP.elapsed;
        }
		
		private function generateEnemyPath(distanceBetweenPoints:Number):Vector.<Point>
		{
			var i:Number;
			 
			var vec:Vector.<Point> = new Vector.<Point>();
			 
			var yPos:Number = 125;
			 
			for (i = 0; i*0.01 < 2*Math.PI; i += distanceBetweenPoints)
			{
				vec.push(new Point((Math.cos(i*0.01 + Math.PI / 2)+1)*200+50, yPos));
			}
		 
			return vec;
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