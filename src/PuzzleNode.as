package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Minttu Mäkinen
	 */
	public class PuzzleNode extends Entity
	{
		[Embed(source = "../graphics/pnb.png")]
		private const BLUE:Class;
		[Embed(source = "../graphics/pnr.png")]
		private const RED:Class;
		[Embed(source = "../graphics/png.png")]
		private const GREEN:Class;
		private var _pathToFollow:Vector.<Point>;
		
		public function PuzzleNode(color:uint, nx:uint, ny:uint) 
		{
			if (color == 0) {
				graphic = new Image(BLUE);
			}
			
			if (color == 1) {
				graphic = new Image(RED);
			}
			
			if (color == 2) {
				graphic = new Image(GREEN);
			}
			
			graphic.x = -37.5;
			graphic.y = -37.5;
			
			_pathToFollow = new Vector.<Point>();
			
			x = nx;
			y = ny;
		}
		
		public function rotate(nx:uint, ny:uint):void
		{
			var vec:Vector.<Point> = new Vector.<Point>();
			var xdir:Number;
			var ydir:Number;
			
			if (nx < x) {
				xdir = 37.5;
			} else {
				xdir = -37.5;
			}
			
			if (ny < y) {
				ydir = 37.5;
			} else {
				ydir = -37.5;
			}
			
			for (var i:Number = Math.PI*2; i >= 0; i = i - 0.05)
			{
				vec.push(new Point( (nx + xdir + 37.5 * Math.cos(i)) , (ny + ydir + 37.5 * Math.sin(i)) ));
			}
			trace(nx);
			trace(ny);
			
			_pathToFollow = vec;
		}
		
		override public function update():void
		{
			if (_pathToFollow.length > 0) {
				var tmp:Point = _pathToFollow.pop();
				x = tmp.x;
				y = tmp.y;
			}
		}
		
	}

}