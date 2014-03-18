package  
{
	/**
	 * ...
	 * @author Minttu Mäkinen
	 */
	public class Puzzle 
	{
		private var width:uint;
		private var height:uint;
		private var moves:uint;
		private var solution:Array;
		private var answer:Array;
		public var nodes:Array;
		
		public function Puzzle(width:uint, height:uint, moves:uint) 
		{
			this.width = width;
			this.height = height;
			this.moves = moves;
			this.answer = new Array();
			this.shuffle();
			this.nodes = new Array();
			for (var i:uint = 0; i < width * height; i++) {
				if (i < width) {
					nodes.push(new PuzzleNode(0, 150+(i%width)*75, 400));
				} else if (i < width * 2) {
					nodes.push(new PuzzleNode(1, 150+(i%width)*75, 475));
				} else {
					nodes.push(new PuzzleNode(2, 150+(i%width)*75, 550));
				}
			}
		}
		
		public function shuffle():void
		{
			this.solution = new Array();
			var size:Number = (width - 1) * (height - 1);
			for (var i:Number = 0; i < moves; i++) {
				this.solution.push(this.randomRange(1, size));
			}
		}
		
		public function rotate(rotation:Number):void
		{
			if (answer.length == moves) {
				this.reset();
			}
			
			var nx:uint = 187.5 + 75 * (rotation % (width - 1));
			var ny:uint = 400 + 75 * (rotation / (width - 1));
			trace(nx);
			trace(ny);
			trace("---");
			
			nodes[int(rotation + rotation / (width - 1))].rotate(nx, ny);
			nodes[int(rotation + rotation / (width - 1) + 1)].rotate(nx, ny);
			nodes[int(width + (rotation + rotation / (width - 1)))].rotate(nx, ny);
			nodes[int(width + (rotation + rotation / (width - 1) + 1))].rotate(nx, ny);
			
			answer.push(rotation);
		}
		
		public function compareSolution():Boolean
		{
			if (answer.length != solution.length) {
				return false;
			}
			
			for (var i:Number = 0; i < moves; i++) {
				if (answer[i] != solution[moves - i]) {
					return false;
				}
			}
			
			return true;
		}
		
		public function reset():void
		{
			this.answer = new Array();
		}
		
		private function randomRange(minNum:Number, maxNum:Number):Number
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
	}

}