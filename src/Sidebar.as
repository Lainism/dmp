package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Backdrop;
	
	/**
	 * ...
	 * @author Minttu Mäkinen
	 */
	public class Sidebar extends Entity
	{
		[Embed(source = '../graphics/sidebar.png')]
		private const BAR:Class;
		private var sidebar:Graphiclist;
		private var barbg:Backdrop;
		private var scorec:Text;
		private var score:Number = 0;
		private var livesc:Text;
		
		public function Sidebar(lives:int) 
		{
			//sidebar background
			barbg = new Backdrop(BAR, false, false);
			
			//score
			scorec = new Text("Score: 0");
			scorec.size = 40;
			scorec.x = 40;
			scorec.y = 10;
			
			//lives
			livesc = new Text("Lives: " + lives);
			livesc.size = 40;
			livesc.x = 40;
			livesc.y = 60;
			
			sidebar = new Graphiclist(barbg, scorec, livesc);
			graphic = sidebar;
			
			x = 500;
			y = 0;
		}
		
		public function changeLives(lives:int):void
		{
			livesc.text = "Lives: " +  lives;
		}
		
		public function addScore(amount:Number = 10):void
		{
			score += amount;
			scorec.text = "Score: " + score;
		}
	}

}