package  
{
	import flash.geom.Point;
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Minttu Mäkinen
	 */
	public class Enemy extends Entity 
	{
		[Embed(source = '../graphics/msf.png')]
        private const IMAGE:Class;
         
        private var _timeToAct:uint;
        private var _pathToFollow:Vector.<Point>;
         
        private var _currentPoint:uint;
         
        private var _myWorld:World;
        private var _added:Boolean;
		
		public function Enemy(timeToAct:uint, pathToFollow:Vector.<Point>, worldToBeAdded:World) 
		{
			graphic = new Image(IMAGE);
             
			graphic.x = -28.5;
			graphic.y = -31.5;
             
            _timeToAct = timeToAct;
             
            _pathToFollow = pathToFollow;
             
            _currentPoint = 0;
             
            _myWorld = worldToBeAdded;
            _added = false;
		}
		
		override public function update():void
        {
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
                    _myWorld.remove(this);
                     
                    _added = false;
                     
                    destroy();
                }
            }
        }
         
        public function destroy():void
        {
            graphic = null;
        }
	}

}