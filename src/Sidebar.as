package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
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
		public var combobar:Image;
		private var scorec:Text;
		private var score:Number = 0;
		private var livesc:Text;
		private var bullet:Text;
		public var decrease:Boolean;
		
		public function Sidebar(lives:int) 
		{
			//sidebar background
			barbg = new Backdrop(BAR, false, false);
			
			//combobar
			combobar = new Image(COMBO);
			combobar.visible = false;
			decrease = false;
			
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
			
			//bullet damage
			bullet = new Text("Bullet damage: 1");
			bullet.size = 30;
			bullet.x = 30
			bullet.y = 550;
			
			sidebar = new Graphiclist(barbg, scorec, livesc, bullet, combobar);
			graphic = sidebar;
			
			x = 500;
			y = 0;
		}
		
		public function showCombobar():void
		{
			combobar.y = 0;
			combobar.visible = true;
			decrease = false;
		}
		
		public function changeLives(lives:int):void
		{
			livesc.text = "Lives: " +  lives;
		}
		
		public function addScore(amount:int = 0):void
		{
			score += 10 + amount * 20;
			scorec.text = "Score: " + score;
		}
		
		public function changeBulletDamage(amount:Number):void
		{
			bullet.text = "Bullet damage: " + amount;
		}
		
		override public function update():void
		{
			if (decrease && combobar.visible)
			{
				//Height of the screen is 600 pix
				//In PlayerShip timer is 5 * FP.elapsed
				//600 / combotime * 5 * FP.elapsed
				combobar.y += 600 / 30 * 5 * FP.elapsed;
			}
		}
	}

}