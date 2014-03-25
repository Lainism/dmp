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
		
		public function Bullet() 
		{
			super();
		}
		
		/*public function init():void 
		{
			graphic = GraphicAssets.Pbullet_graph1;
			mask = new Pixelmask(GraphicAssets.Pbullet_graph1, -8.5, -8.5);
			_pathToFollow = GameWorld(world).generatePlayerBulletPath(3);
			
		}*/
		
		override public function update():void
        {

            if (_pathToFollow.length > 0) {
				x = xPos + _pathToFollow[0].x;
				y = yPos + _pathToFollow[0].y;
				 
				_pathToFollow.shift();
			} 
            
        }
		
		public function destroy():void
        {
            _pathToFollow = null;
             
            graphic = null;
        }
		
	}

}