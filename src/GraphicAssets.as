package  
{
	import flash.display.Bitmap;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	/**
	 * A class for optimizing performance by loading different bullet graphics only once
	 * Got idea from this tutorial http://www.gotoandlearn.com/play.php?id=160
	 * @author A.V.
	 */
	public class GraphicAssets 
	{
		
		// Graphics and variables for player bullets
		[Embed(source = '../graphics/br1.png')]
		public static var Player_bullet1:Class;
		public static var Pbullet_graph1:Image;
		
		
		// Graphics and variables for enemy bullets
		[Embed(source = '/../graphics/Dummy_ammus.png')]	
		public static var Enemy_bullet1:Class;
		public static var Ebullet_graph1:Image;
		
		public function GraphicAssets() 
		{
			//Player bullets
			Pbullet_graph1 = new Image(Player_bullet1);
			Pbullet_graph1.x = Pbullet_graph1.y = -8.5;
			
			//Enemy bullets
			Ebullet_graph1 = new Image(Enemy_bullet1);
			Ebullet_graph1.x = Ebullet_graph1.y = -12.5;
			
		}
		
	}

}