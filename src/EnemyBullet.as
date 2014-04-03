package  
{
	import flash.geom.Point;
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.World;
	/**
	 * A common class for different kinds of enemy bullets
	 * @author A.V.
	 */
	public class EnemyBullet extends Bullet
	{
		
		public function EnemyBullet(damage:int = 1) {
			
			super(damage);
		}
			
		public function init_bul(img:Image, source:Class, mask_x:Number, mask_y:Number, w:World):void
		{
			graphic = img;
			mask = new Pixelmask(source, mask_x, mask_y);
		}
		
		override public function update():void
        {
			if (super.pause)
				return;
			
            if (_pathToFollow.length > 0)
			{
				x = xPos + _pathToFollow[0].x;
				y = yPos + _pathToFollow[0].y;
				
				_pathToFollow.shift();
            }
            
             
        }
		
		
	}

}