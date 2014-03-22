package
{
	import flash.geom.Point;
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	/**
	 * A common class for different kinds of enemy bullets
	 * @author A.V.
	 */
	public class EnemyBullet extends Entity
	{
		[Embed(source = '/../graphics/Dummy_ammus.png')]	
		private const IMAGE:Class;
		
		private var _pathToFollow:Vector.<Point>;
		
		private var _xPos:Number;
        private var _yPos:Number;
		
		public function EnemyBullet() 
		{
			super();
			/*graphic = new Image(IMAGE);
             
            graphic.x = graphic.y = -12.5;
            
			mask = new Pixelmask(IMAGE, -12.5, -12.5);
			
			_pathToFollow = pathToFollow;
			
            _xPos = xPos;
            _yPos = yPos;
			
			type = "EnemyBullet";
			*/
			
		}
		
		override public function update():void
        {
            /*x = _xPos + _pathToFollow[0].x;
            y = _yPos + _pathToFollow[0].y;
             
            _pathToFollow.shift();
             
            if (_pathToFollow.length == 0)
            {
                world.remove(this);
                 
                destroy();
            }*/
        }
		
		public function destroy():void
        {
            /*_pathToFollow = null;
             
            graphic = null;
			*/
        }
		
	}

}