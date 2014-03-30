package  
{
	import flash.events.Event;
	import flash.geom.Point;
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	/**
	 * A generic class for different types of bullets
	 * @author ...
	 */
	public class Bullet extends Entity
	{
		public var _pathToFollow:Vector.<Point>;
         
        public var xPos:Number;
        public var yPos:Number;
		
		public var DAMAGE:int;
		public var pause:Boolean;
		
		public function Bullet() 
		{
			super();
			pause = false;
		}
		
		/*override public function update():void
        {
			if (pause)
				return;

            if (_pathToFollow.length > 0) {
				x = xPos + _pathToFollow[0].x;
				y = yPos + _pathToFollow[0].y;
				 
				_pathToFollow.shift();
			} 
            
        }*/
		
		public function destroy():void
        {
            _pathToFollow = null;
             
            graphic = null;
        }
		
	}

}