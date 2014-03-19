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
		private var currentColor:String;
		private var _pathToFollow:Vector.<Point>;
		
		public function PuzzleNode(color:uint, nx:uint, ny:uint) 
		{
			if (color == 0) {
				graphic = new Image(BLUE);
				currentColor = "Blue";
			}
			
			if (color == 1) {
				graphic = new Image(RED);
				currentColor = "Red";
			}
			
			if (color == 2) {
				graphic = new Image(GREEN);
				currentColor = "Green";
			}
			
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
			trace(x);
			trace(y);
			trace("~");
			*/
			for (var i:Number = j - Math.PI / 2; i <= j; i = i + 0.05)
			{
				vec.push(new Point( nx - (r * Math.cos(i)) , ny + (r * Math.sin(i)) ));
			}
			
			_pathToFollow = vec;
		}
		
		override public function update():void
		{
			if (_pathToFollow.length > 0) {
				var tmp:Point = _pathToFollow.pop();
				x = int(tmp.x);
				y = int(tmp.y);
				//trace(tmp.x);
			}
		}
		
	}

}