package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	/**
	 * ...
	 * @author Minttu Mäkinen
	 */
	public class GameOver extends World
	{
		
		[Embed(source = '../graphics/menu/instructionsfull.png')]
		private const GAMEOVER:Class;
		[Embed(source = '../graphics/menu/instructionsfull.png')]
		private const GAMEWON:Class;
		[Embed(source = '../graphics/menu/menu.png')]
		private const MENU:Class;
		private var menuButton:Button;
		private var gameOverScreen:Image;
		
		public function GameOver(won:Boolean) {
			/* Displays the game over box over the game */
			
			menuButton = new Button(goMenu, null, 270, 450);
			menuButton.setSpritemap(MENU, 250, 36);
			if (won) {
				gameOverScreen = new Image(GAMEWON);
			} else {
				gameOverScreen = new Image(GAMEOVER);
			}
			
			add(menuButton);
			addGraphic(gameOverScreen);
		}
		
		public function goMenu():void {
			/* Creates a new main menu */
			
			if (!ended) {
				return;
			}
			
			FP.world = new MainMenu();
			destroy();
		}
		
		public function destroy():void {
			/* Destroys all the game over elements and buttons */
			
			removeAll();
			menuButton = null;
		}
	}

}