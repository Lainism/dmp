package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	
	/**
	 * The sidebar on the right
	 * @author Minttu Mäkinen
	 */
	public class Sidebar extends Entity
	{
		[Embed(source = '../graphics/sidebar.png')]
		private const BAR:Class;
		[Embed(source = '../graphics/combobar.png')]
		private const COMBO:Class;
		private var sidebar:Graphiclist;
		private var barbg:Backdrop;
		private var limit:int;
		private var power:Number;
		public var combobar:Image;
		private var scorec:Text;
		private var score:Number = 0;
		private var livesc:Text;
		private var bullet:Text;
		public var decrease:Boolean;
		public var pause:Boolean;
		
		public function Sidebar(lives:int, timeLimit:int) {
			/* Initializing the sidebar */
			
			// Sidebar background
			barbg = new Backdrop(BAR, false, false);
			
			// The depleting combobar
			combobar = new Image(COMBO);
			combobar.visible = false;
			decrease = false;
			
			// Score
			scorec = new Text("Score: 0");
			scorec.size = 40;
			scorec.x = 40;
			scorec.y = 10;
			
			// Lives
			livesc = new Text("Lives: " + lives);
			livesc.size = 40;
			livesc.x = 40;
			livesc.y = 60;
			
			// Bullet damage
			bullet = new Text("Power: 1");
			bullet.size = 30;
			bullet.x = 30
			bullet.y = 550;
			power = 1;
			
			sidebar = new Graphiclist(barbg, scorec, livesc, bullet, combobar);
			graphic = sidebar;
			limit = timeLimit;
			
			x = 500;
			y = 0;
			
			pause = false;
		}
		
		public function showCombobar():void {
			/* Showing the green bar during combos */
			combobar.y = 0;
			combobar.visible = true;
			decrease = false;
		}
		
		public function changeLives(lives:int):void {
			/* Change the text for lives */
			livesc.text = "Lives: " +  lives;
		}
		
		public function addScore(amount:int = 0):void {
			/* Increasing the score and changing its text */
			score += 9 + power + amount;
			scorec.text = "Score: " + score;
		}
		
		public function changeBulletDamage(amount:Number, newLimit:int):void {
			/* Changing the text for bullet damage and time limit */
			power = amount;
			bullet.text = "Power: " + amount;
			limit = newLimit;
		}
		
		override public function update():void {
			/* Keeping the sidebar up to date */
			
			if (pause)
				return;
				
			if (decrease && combobar.visible) {
				// Height of the screen is 600 pix
				// In PlayerShip timer is 5 * FP.elapsed
				// 600 / combotime * 5 * FP.elapsed
				trace(limit);
				combobar.y += 600 / (limit - 20) * 5 * FP.elapsed;
			}
		}
	}

}