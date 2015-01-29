package  
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import flash.system.fscommand;
	
	/**
	 * The menu the game first opens at
	 * @author Minttu Mäkinen
	 */
	public class MainMenu extends World
	{
		[Embed(source = '../graphics/menu/mainmenu.png')]
		private const BG:Class;
		[Embed(source = '../graphics/menu/characterselect.png')]
		private const CHARACTER:Class;
		[Embed(source = '../graphics/menu/instructions.png')]
		private const INSTRUCTIONS:Class;
		[Embed(source = '../graphics/menu/instructionsfull.png')]
		private const FULLINSTRUCTIONS:Class;
		[Embed(source = '../graphics/menu/credits.png')]
		private const CREDITS:Class;
		[Embed(source = '../graphics/menu/creditsfull.png')]
		private const FULLCREDITS:Class;
		[Embed(source = '../graphics/menu/quit.png')]
		private const QUIT:Class;
		[Embed(source = '../graphics/menu/back.png')]
		private const BACK:Class;
		
		private var characterButton:Button;
		private var instructionsButton:Button;
		private var creditsButton:Button;
		private var quitButton:Button;
		private var backButton:Button;
		
		private var fullInstructions:Image;
		private var fullCredits:Image;
		
		public function MainMenu() {
			/* Initializing the buttons and the graphics */
			
			fullInstructions = new Image(FULLINSTRUCTIONS);
			fullInstructions.visible = false;
			
			fullCredits = new Image(FULLCREDITS);
			fullCredits.visible = false;
			
			addGraphic(new Image(BG));
			
			characterButton = new Button(selectCharacters, null, 270, 300);
			instructionsButton = new Button(showInstructions, null, 270, 350);
			creditsButton = new Button(showCredits, null, 270, 400);
			quitButton = new Button(quit, null, 270, 450);
			backButton = new Button(goBack, null, 640, 500);
     
			characterButton.setSpritemap(CHARACTER, 250, 36);
			instructionsButton.setSpritemap(INSTRUCTIONS, 250, 36);
			creditsButton.setSpritemap(CREDITS, 250, 36);
			quitButton.setSpritemap(QUIT, 250, 36);
			backButton.setSpritemap(BACK, 250, 36);
			backButton.visible = false;
     
			add(characterButton);
			add(instructionsButton);
			add(creditsButton);
			
			//No need for this when the game is embedded.
			//add(quitButton);
			
			addGraphic(fullInstructions);
			addGraphic(fullCredits);
			add(backButton);
		}
		
		public function selectCharacters():void {
			/* Moving on to the character selection screen */
			
			if (backButton.visible)
				return;
				
			FP.world = new CharacterSelect();
			destroy();
		}
		
		public function showInstructions():void {
			/* Showing the instructions */
			
			if (backButton.visible)
				return;
				
			fullInstructions.visible = true;
			backButton.visible = true;
		}
		
		public function showCredits():void {
			/* Showing the credits */
			
			if (backButton.visible)
				return;
			
			fullCredits.visible = true;
			backButton.visible = true;
		}
		
		public function goBack():void {
			/* Hiding the extra screens */
			
			fullInstructions.visible = false;
			fullCredits.visible = false;
			backButton.visible = false;
		}
		
		public function quit():void {
			/* Quits the game */
			
			if (backButton.visible)
				return;
				
			fscommand("quit");
		}
		
		public function destroy():void {
			/* Destroys all the main menu elements and buttons */
			
			removeAll();
			characterButton = null;
			instructionsButton = null;
			creditsButton = null;
			quitButton = null;
		}
	}

}