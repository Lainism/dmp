package  
{
	import flash.geom.Point;
	import flash.net.drm.VoucherAccessInfo;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * An invidual colored circle in a puzzle
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
		private var currentColor:int;
		private var _pathToFollow:Vector.<Point>;
		
		public function PuzzleNode(color:uint, nx:uint, ny:uint) {
			/* Initializes an invidual puzzle node */
			
			// Selecting the color
			if (color == 0) {
				graphic = new Image(BLUE);
			} else if (color == 1) {
				graphic = new Image(RED);
			} else if (color == 2) {
				graphic = new Image(GREEN);
			}
			currentColor = color;
			
			graphic.x = -37.5;
			graphic.y = -37.5;
			
			_pathToFollow = new Vector.<Point>();
			
			x = nx;
			y = ny;
		}
		
		public function rotate(nx:uint, ny:uint, j:Number):void {
			/* Rotating the puzzle nodes around each other */
			
			var vec:Vector.<Point> = new Vector.<Point>();
			var r:Number = 53.0330085;
			
			for (var i:Number = j; i <= j + Math.PI / 2; i = i + 0.05) {
				//trace(ny - (r * Math.sin(i)));
				vec.push(new Point( nx + (r * Math.cos(i)) , ny - (r * Math.sin(i)) ));
			}
			_pathToFollow = vec;
		}
		
		override public function update():void {
			/* Updating the state of the node each turn (changing the location) */
			
			if (_pathToFollow.length > 0) {
				var tmp:Point = _pathToFollow.pop();
				x = int(tmp.x);
				y = int(tmp.y);
				//trace(currentColor);
				//trace(tmp.y);
			}
		}
		
		public function change_color(color:int):void {
			/* Makes the node change color */
			
			if (color == 0) {
				graphic = new Image(BLUE);
			} else if (color == 1) {
				graphic = new Image(RED);
			} else if (color == 2) {
				graphic = new Image(GREEN);
			}
			
			graphic.x = -37.5;
			graphic.y = -37.5;
			
			currentColor = color;
		}
		
		public function return_color():int {
			/* Returns the color of the node */
			return currentColor;
		}
	}

}