package  
{
	import flash.geom.Point;
	/**
	 * The puzzle that consists of sevaral nodes
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
		
		public function Puzzle(width:uint, height:uint, moves:uint) {
			/* Initializing the puzzle */
			
			this.width = width;
			this.height = height;
			this.moves = moves;
			this.solved = new Array(0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2);
			this.shuffle();
			this.nodes = new Array();
			
			// Placing the puzzle nodes on the world
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
		
		public function shuffle():void {
			// Shuffling a new random computer generated puzzle
			this.solution = new Array();
			var size:Number = (width - 1) * (height - 1);
			for (var i:Number = 0; i < moves; i++) {
				this.solution.push(this.randomRange(0, size - 1));
			}
		}
		
		public function rotate(rotation:Number):void {
			/* Rotating the puzzle nodes around each other */
			
			var nx:uint = 187.5 + 75 * (rotation % (width - 1));
			var ny:uint = 437.5 + 75 * int(rotation / (width - 1));
			var j:Number = Math.PI / 4;
			
			var topleft:int = int(rotation + rotation / (width - 1));
			var topright:int = int(rotation + rotation / (width - 1) + 1);
			var bottomleft:int = int(width + (rotation + rotation / (width - 1)));
			var bottomright:int = int(width + (rotation + rotation / (width - 1) + 1));
			
			// Starting the animation for the rotation
			nodes[topleft].rotate(nx, ny, 3*j);
			nodes[topright].rotate(nx, ny, j);
			nodes[bottomleft].rotate(nx, ny, 5*j);
			nodes[bottomright].rotate(nx, ny, 7*j);
			
			// Switctching the colors in the nodelist
			var tmp_color:int = nodes[topright].return_color();
			nodes[topright].change_color(nodes[topleft].return_color());
			nodes[topleft].change_color(nodes[bottomleft].return_color());
			nodes[bottomleft].change_color(nodes[bottomright].return_color());
			nodes[bottomright].change_color(tmp_color);
			
			counter++;
			
		}
		
		public function compareSolution():Boolean {
			/* Finding out if the solution is correct */
			
			// Comparing the order of the nodes to the solution
			for (var i:uint = 0; i < nodes.length; i++) {
				if (nodes[i].return_color() != solved[i]) {
					if (counter >= 3)
						reset();
					return false;
				}
			}
			
			trace("puzzle completed!");
			return true;
		}
		
		public function reset():void {
			/* Resets the puzzle to the previous shuffle */
			trace("reset");
			this.counter = 0;
			
			// Initialize all nodes to default places
			for (var i:int = 0; i < nodes.length; i++) {
				if (i < width) {
					nodes[i].change_color(0);
				} else if (i < 2 * width) {
					nodes[i].change_color(1);
				} else {
					nodes[i].change_color(2);
				}
			}
			
			// Rotate nodes without animation
			var rotation:int, topleft:int, topright:int, bottomleft:int, bottomright:int, tmp_color:int;
			
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
		
		private function randomRange(minNum:Number, maxNum:Number):Number {
			/* A helper function to give a random within the given range */
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
	}

}