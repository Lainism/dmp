package  
{
	import flash.events.Event;
	import flash.geom.Point;
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	/**
	 * ...
	 * @author Minttu Mäkinen
	 */
public class PlayerBullet extends Entity
    {
        [Embed(source = '../graphics/br1.png')]
        private const IMAGE:Class;
         
        private var _pathToFollow:Vector.<Point>;
         
<<<<<<< HEAD
        public var xPos:Number;
        public var yPos:Number;
=======
        private var _xPos:Number;
        private var _yPos:Number;
		
		public var DAMAGE:int = 1;
>>>>>>> 040a99ca292698604548dd7a3ca97785060c983f
         
        public function PlayerBullet()
        {
			super()
            
			/*
            graphic.x = graphic.y = -8.5;
             
			mask = new Pixelmask(IMAGE, -8.5, -8.5);
			
            _pathToFollow = pathToFollow;
            
			*/
        }
		
		private function init(event:Event):void 
		{
			graphic = GraphicAssets.Pbullet_graph1;
			mask = new Pixelmask(GraphicAssets.Pbullet_graph1, -8.5, -8.5);
			_pathToFollow = GameWorld(world).generatePlayerBulletPath(3);
			
		}
         
        override public function update():void
        {
            x = xPos + _pathToFollow[0].x;
            y = yPos + _pathToFollow[0].y;
             
            _pathToFollow.shift();
            
			/* 
            if (_pathToFollow.length == 0)
            {
                world.remove(this);
                 
                destroy();
            }
			*/
        }
         
        public function destroy():void
        {
            _pathToFollow = null;
             
            graphic = null;
        }
         
    }
 
}