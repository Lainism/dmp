package  
{
	import flash.geom.Point;
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
		private var solved:Array;
		public var nodes:Array;
		private var counter:int;
		
		public function Puzzle(width:uint, height:uint, moves:uint) 
		{
			this.width = width;
			this.height = height;
			this.moves = moves;
			this.solved = new Array(0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2);
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
			this.reset();
		}
		
		public function shuffle():void
		{
			this.solution = new Array();
			var size:Number = (width - 1) * (height - 1);
			for (var i:Number = 0; i < moves; i++) {
				this.solution.push(this.randomRange(0, size - 1));
			}
		}
		
		public function rotate(rotation:Number):void
		{
			//trace("---");
			
			var nx:uint = 187.5 + 75 * (rotation % (width - 1));
			var ny:uint = 437.5 + 75 * int(rotation / (width - 1));
			var j:Number = Math.PI / 4;
			
			var topleft:int = int(rotation + rotation / (width - 1));
			var topright:int = int(rotation + rotation / (width - 1) + 1);
			var bottomleft:int = int(width + (rotation + rotation / (width - 1)));
			var bottomright:int = int(width + (rotation + rotation / (width - 1) + 1));
			/*
			trace(topleft);
			trace(topright);
			trace(bottomleft);
			trace(bottomright);
			
			trace(nodes[topleft].currentColor); 		
			trace(nodes[topright].currentColor);
			trace(nodes[bottomleft].currentColor);
			trace(nodes[bottomright].currentColor);
			*/
			
			nodes[topleft].rotate(nx, ny, 3*j);
			nodes[topright].rotate(nx, ny, j);
			nodes[bottomleft].rotate(nx, ny, 5*j);
			nodes[bottomright].rotate(nx, ny, 7*j);
			
			var tmp_color:int = nodes[topright].return_color();
			nodes[topright].change_color(nodes[topleft].return_color());
			nodes[topleft].change_color(nodes[bottomleft].return_color());
			nodes[bottomleft].change_color(nodes[bottomright].return_color());
			nodes[bottomright].change_color(tmp_color);
			
			/*
			var tmp1:PuzzleNode = nodes[topleft];
			var tmp2:PuzzleNode = nodes[topright];
			var tmp3:PuzzleNode = nodes[bottomleft];
			var tmp4:PuzzleNode = nodes[bottomright];

			/*trace("!!!")
			trace(nodes[topleft].x);
			trace(nodes[topleft].y);
			trace(nodes[topright].x);
			trace(nodes[topright].y);
			trace(nodes[bottomright].x);
			trace(nodes[bottomright].y);
			trace(nodes[bottomleft].x);
			trace(nodes[bottomleft].y);
			
			/*
			nodes[topleft] = 		tmp3;
			nodes[topright] = 		tmp1;
			nodes[bottomleft] = 	tmp4;
			nodes[bottomright] = 	tmp2;
			/
			
			trace("!!!")
			trace(nodes[topleft].x);
			trace(nodes[topleft].y);
			trace(nodes[topright].x);
			trace(nodes[topright].y);
			trace(nodes[bottomright].x);
			trace(nodes[bottomright].y);
			trace(nodes[bottomleft].x);
			trace(nodes[bottomleft].y);
			*/
			
			counter++;
			
		}
		
		public function compareSolution():Boolean
		{
			if (counter != solution.length) {
				return false;
			}
			
			/*for (var i:Number = 0; i < moves; i++) {
				if (answer[i] != solution[moves - i]) {
					return false;
				}
			}*/
			for (var i:uint = 0; i < nodes.length; i++) {
				if (nodes[i].return_color() != solved[i])
				{
					reset();
					return false;
				}
			}
			
			trace("puzzle completed!");
			shuffle();
			reset();
			return true;
		}
		
		public function reset():void
		{
			trace("reset");
			this.counter = 0;
			
			//initialize all nodes to default places
			for (var i:int = 0; i < nodes.length; i++) {
				if (i < width) {
					nodes[i].change_color(0);
				} else if (i < 2 * width) {
					nodes[i].change_color(1);
				} else {
					nodes[i].change_color(2);
				}
			}
			
			var rotation:int, topleft:int, topright:int, bottomleft:int, bottomright:int, tmp_color:int;
			
			//rotate nodes without animation
			for (var j:int = 0; j < solution.length; j++) {
				rotation = solution[j];
				topleft = int(rotation + rotation / (width - 1));
				topright = int(rotation + rotation / (width - 1) + 1);
				bottomleft = int(width + (rotation + rotation / (width - 1)));
				bottomright = int(width + (rotation + rotation / (width - 1) + 1));
				
				tmp_color = nodes[topright].return_color();
				nodes[topright].change_color(nodes[bottomright].return_color());
				nodes[bottomright].change_color(nodes[bottomleft].return_color());
				nodes[bottomleft].change_color(nodes[topleft].return_color());
				nodes[topleft].change_color(tmp_color);
			}
		}
		
		private function randomRange(minNum:Number, maxNum:Number):Number
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
	}

}