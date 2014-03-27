package  
{
	import flash.geom.Point;
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.tweens.misc.AngleTween;
	import net.flashpunk.World;
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
		public var angleTween:AngleTween;
		private var timmy:int;
		
		public function EnemyBullet() {
			
			super();
			timmy = 0;
			this.DAMAGE = 1;
			angleTween = new AngleTween();
			angleTween.tween(0, 3600, 30); //fromAngle, toAngle, duration, ease = null
			
		}
			
		public function init_bul(img:Image, source:Class, mask_x:Number, mask_y:Number, w:World):void
		{
			graphic = img;
			mask = new Pixelmask(source, mask_x, mask_y);
			w.addTween(angleTween, true);
		}
		
		override public function update():void
        {
			timmy++;
            if (_pathToFollow.length > 0) 
			{
				x = xPos + _pathToFollow[0].x;
				y = yPos + _pathToFollow[0].y;
            }
			
			
			
			GraphicAssets.Ebullet_graph1.angle = angleTween.angle;
			this.graphic = GraphicAssets.Ebullet_graph1;
 
            _pathToFollow.shift();
             
        }
		
		
	}

}