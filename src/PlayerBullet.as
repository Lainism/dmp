package  
{
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
         
        private var _xPos:Number;
        private var _yPos:Number;
		
		public var DAMAGE:int = 1;
         
        public function PlayerBullet(pathToFollow:Vector.<Point>, xPos:Number, yPos:Number)
        {
            graphic = new Image(IMAGE);
             
            graphic.x = graphic.y = -8.5;
             
			mask = new Pixelmask(IMAGE, -8.5, -8.5);
			
            _pathToFollow = pathToFollow;
             
            _xPos = xPos;
            _yPos = yPos;
			
			type = "PlayerBullet";
        }
         
        override public function update():void
        {
            x = _xPos + _pathToFollow[0].x;
            y = _yPos + _pathToFollow[0].y;
             
            _pathToFollow.shift();
             
            if (_pathToFollow.length == 0)
            {
                world.remove(this);
                 
                destroy();
            }
        }
         
        public function destroy():void
        {
            _pathToFollow = null;
             
            graphic = null;
        }
         
    }
 
}