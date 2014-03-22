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
public class PlayerBullet extends Bullet
    {
        [Embed(source = '../graphics/br1.png')]
        private const IMAGE:Class;
         
        //public var _pathToFollow:Vector.<Point>;
         
        //public var xPos:Number;
        //public var yPos:Number;
		
		//public var DAMAGE:int = 1;
         
        public function PlayerBullet()
        {
			super()
            graphic = GraphicAssets.Pbullet_graph1;
			mask = new Pixelmask(GraphicAssets.Player_bullet1, -8.5, -8.5);
			
			/*
            graphic.x = graphic.y = -8.5;
             
			mask = new Pixelmask(IMAGE, -8.5, -8.5);
			
            _pathToFollow = pathToFollow;
            
			*/
        }
		
			
		
         
        override public function update():void
        {
			if (_pathToFollow.length > 0) {
				x = xPos + _pathToFollow[0].x;
				y = yPos + _pathToFollow[0].y;
				 
				_pathToFollow.shift();
			}
			/* 
            if (_pathToFollow.length == 0)
            {
                world.remove(this);
                 
                destroy();
            }
			*/
        }
         
    }
 
}