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
			var j:Number
			
			if (nx < x && ny < y) {
				xdir = 37.5;
				ydir = 37.5;
				j = - Math.PI / 4;
			} else if (nx >= x && ny < y) {
				xdir = -37.5;
				ydir = 37.5;
				j = - 3* Math.PI / 4;
			} else if (nx > x && ny > y) {
				xdir = -37.5;
				ydir = -37.5;
				j = 3* Math.PI / 4;
			} else {
				xdir = 37.5;
				ydir = -37.5;
				j = Math.PI / 4;
			}
			
			for (var i:Number = j; i >= j - 2 * Math.PI; i = i - 0.05)
			{
				//trace(xdir);
				//vec.push(new Point( (nx + xdir + 37.5 * Math.cos(i)) , (ny + ydir + 37.5 * Math.sin(i)) ));
				vec.push(rot(nx, ny, i));
			}
			//trace(nx);
			//trace(ny);
			
			_pathToFollow = vec;
		}
		
		private function rot(rx:Number,ry:Number,P:Number):Point
		{	
			//var toDeg:Number = 180/Math.PI;
			var dx:Number = x-rx;
			var dy:Number = y-ry;
			var cos:Number = Math.cos(P);
			var sin:Number = Math.sin(P);

			//m.rotation += P*toDeg;
			//m.x = rx+dx*cos-dy*sin;
			//m.y = ry + dy * cos + dx * sin;
			
			return new Point(rx+dx*cos-dy*sin, ry + dy * cos + dx * sin);
		}
		
		override public function update():void
		{
			if (_pathToFollow.length > 0) {
				var tmp:Point = _pathToFollow.pop();
				x = tmp.x;
				y = tmp.y;
				//trace(tmp.x);
			}
		}
		
	}

}