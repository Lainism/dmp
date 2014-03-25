package  
{
	import flash.geom.Point;
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Pixelmask;
	/**
	 * A common class for different kinds of enemy bullets
	 * @author A.V.
	 */
	public class EnemyBullet extends Bullet
	{
		
		//private var _pathToFollow:Vector.<Point>;
		
		//private var _xPos:Number;
        //private var _yPos:Number;
		
		private var speed:Number;
		private var accel:Number;
		
		public function EnemyBullet() {
			
			super();
			this.DAMAGE = 1;
			
		}
			
		public function init_bul(img:Image, source:Class, mask_x:Number, mask_y:Number):void
		{
			graphic = img;
			mask = new Pixelmask(source, mask_x, mask_y);
		}
		
		override public function update():void
        {
            if (_pathToFollow.length > 0) 
			{
				x = xPos + _pathToFollow[0].x;
				y = yPos + _pathToFollow[0].y;
            }
				
            _pathToFollow.shift();
             
        }
		
		
	}

}