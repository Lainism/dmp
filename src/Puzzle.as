package  
{
	/**
	 * ...
	 * @author Minttu Mäkinen
	 */
	public class Puzzle 
	{
		private var width;
		private var height;
		private var moves;
		private var solution;
		private var answer;
		
		public function Puzzle(width:Number, height:Number, moves:Number) 
		{
			this.width = width;
			this.height = height;
			this.moves = moves;
			this.answer = new Array();
			this.shuffle();
		}
		
		public function shuffle():void
		{
			this.solution = new Array();
			var size:Number = (width - 1) * (height - 1);
			for (var i:Number = 0; i < moves; i++) {
				this.solution.push(this.randomRange(1, size));
			}
		}
		
		public function rotate(rotation:Number)
		{
			if (answer.length == moves) {
				this.reset();
			}
			
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
		
		public function reset()
		{
			this.answer = new Array();
		}
		
		function randomRange(minNum:Number, maxNum:Number):Number
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
	}

}