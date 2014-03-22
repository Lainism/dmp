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
		private var currentColor:int;
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
			currentColor = color;
			
			graphic.x = -37.5;
			graphic.y = -37.5;
			
			_pathToFollow = new Vector.<Point>();
			
			x = nx;
			y = ny;
		}
		
		public function rotate(nx:uint, ny:uint, j:Number):void
		{
			var vec:Vector.<Point> = new Vector.<Point>();
			//var j:Number
			var r:Number = 53.0330085;  
			/*
			if (nx < x && ny < y) {
				j = Math.PI / 4;
			} else if (nx >= x && ny < y) {
				j = 3* Math.PI / 4;
			} else if (nx > x && ny > y) {
				j = - 3* Math.PI / 4;
			} else {
				j = - Math.PI / 4;
			}
			/
			trace(j);
			trace("~");
			trace(x);
			trace(y);
			*/
			
			for (var i:Number = j; i <= j + Math.PI / 2; i = i + 0.05)
			{
				//trace(ny - (r * Math.sin(i)));
				vec.push(new Point( nx + (r * Math.cos(i)) , ny - (r * Math.sin(i)) ));
			}
			_pathToFollow = vec;
		}
		
		override public function update():void
		{
			if (_pathToFollow.length > 0) {
				var tmp:Point = _pathToFollow.pop();
				x = int(tmp.x);
				y = int(tmp.y);
				//trace(currentColor);
				//trace(tmp.y);
			}
		}
		
		public function change_color(color:int):void {
			
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
			
			currentColor = color;
		}
		
		public function return_color():int {
			
			return currentColor;
		}
	}

}