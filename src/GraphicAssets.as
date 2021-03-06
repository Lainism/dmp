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
		[Embed(source = '/../graphics/ebull1.png')]	
		public static var Enemy_bullet1:Class;
		public static var Ebullet_graph1:Image;
		
		[Embed(source = '/../graphics/ebull2.png')]	
		public static var Enemy_bullet2:Class;
		public static var Ebullet_graph2:Image;
		
		[Embed(source = '/../graphics/ebull3.png')]	
		public static var Enemy_bullet3:Class;
		public static var Ebullet_graph3:Image;
		
		[Embed(source = '/../graphics/ebull4.png')]	
		public static var Enemy_bullet4:Class;
		public static var Ebullet_graph4:Image;
		
		[Embed(source = '/../graphics/ebull5.png')]	
		public static var Enemy_bullet5:Class;
		public static var Ebullet_graph5:Image;
		
		public function GraphicAssets() 
		{
			// Player bullets
			Pbullet_graph1 = new Image(Player_bullet1);
			Pbullet_graph1.x = Pbullet_graph1.y = -8.5;
			
			// Enemy bullets
			Ebullet_graph1 = new Image(Enemy_bullet1);
			Ebullet_graph1.x = Ebullet_graph1.y = -8.5;
			
			Ebullet_graph2 = new Image(Enemy_bullet2);
			Ebullet_graph2.x = Ebullet_graph2.y = -8.5;
			
			Ebullet_graph3 = new Image(Enemy_bullet3);
			Ebullet_graph3.x = Ebullet_graph3.y = -8.5;
			
			Ebullet_graph4 = new Image(Enemy_bullet4);
			Ebullet_graph4.x = Ebullet_graph4.y = -8.5;
			
			Ebullet_graph5 = new Image(Enemy_bullet5);
			Ebullet_graph5.x = Ebullet_graph5.y = -8.5;
			
		}
		
	}

}