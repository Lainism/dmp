package  
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Minttu Mäkinen
	 */
	public class CharacterSelect extends World
	{
		[Embed(source = '../graphics/menu/mainmenu.png')]
		private const BG:Class;
		[Embed(source = '../graphics/esf.png')]
		private const EMO:Class;
		[Embed(source = '../graphics/msf.png')]
		private const MEGANE:Class;
		[Embed(source = '../graphics/ilof.png')]
		private const ILO:Class;
		[Embed(source = '../graphics/tsunf.png')]
		private const TSUN:Class;
		[Embed(source = '../graphics/bsf.png')]
		private const BOSS:Class;
		[Embed(source = '../graphics/menu/start.png')]
		private const START:Class;
		[Embed(source = '../graphics/menu/back.png')]
		private const BACK:Class;
		[Embed(source = '../graphics/menu/selection.png')]
		private const SQUARE:Class;
		[Embed(source = '../graphics/menu/yourcharacter.png')]
		private const CHARACTER:Class;
		[Embed(source = '../graphics/menu/youropponent.png')]
		private const OPPONENT:Class;
		
		private var yourCharacter:Image;
		private var yourOpponent:Image;
		
		private var emoButton:Button;
		private var meganeButton:Button;
		private var iloButton:Button;
		private var tsunButton:Button;
		private var bossButton:Button;
		
		private var emoButton2:Button;
		private var meganeButton2:Button;
		private var iloButton2:Button;
		private var tsunButton2:Button;
		private var bossButton2:Button;
		
		private var startButton:Button;
		private var backButton:Button;
		
		private var selection:Image;
		private var selection2:Image;
		private var currentCharacter:String;
		private var currentOpponent:String;
		
		public function CharacterSelect() 
		{
			addGraphic(new Image(BG));
			
			selection = new Image(SQUARE);
			selection.x = -100;
			selection.y = -100;
			
			selection2 = new Image(SQUARE);
			selection2.x = -100;
			selection2.y = -100;
			
			yourCharacter = new Image(CHARACTER);
			yourCharacter.x = 90;
			yourCharacter.y = 250;
			
			yourOpponent = new Image(OPPONENT);
			yourOpponent.x = 490;
			yourOpponent.y = 250;
			
			emoButton = new Button(selectCharacter, "emo", 70, 320);
			meganeButton = new Button(selectCharacter, "megane", 270, 320);
			iloButton = new Button(selectCharacter, "ilo", 120, 420);
			tsunButton = new Button(selectCharacter, "tsun", 220, 420);
			bossButton = new Button(selectCharacter, "boss", 170, 320);
			
			emoButton2 = new Button(selectOpponent, "emo", 470, 320);
			meganeButton2 = new Button(selectOpponent, "megane", 670, 320);
			iloButton2 = new Button(selectOpponent, "ilo", 520, 400);
			tsunButton2 = new Button(selectOpponent, "tsun", 620, 420);
			bossButton2 = new Button(selectOpponent, "boss", 570, 320);
			
			startButton = new Button(startGame, null, 650, 550);
			backButton = new Button(returnMenu, null, 50, 550);
     
			emoButton.setSpritemap(EMO, 65, 64);
			meganeButton.setSpritemap(MEGANE, 65, 64);
			iloButton.setSpritemap(ILO, 65, 64);
			tsunButton.setSpritemap(TSUN, 65, 64);
			bossButton.setSpritemap(BOSS, 65, 64);
			
			emoButton2.setSpritemap(EMO, 65, 64);
			meganeButton2.setSpritemap(MEGANE, 65, 64);
			iloButton2.setSpritemap(ILO, 65, 64);
			tsunButton2.setSpritemap(TSUN, 65, 64);
			bossButton2.setSpritemap(BOSS, 65, 64);
			
			startButton.setSpritemap(START, 250, 36);
			backButton.setSpritemap(BACK, 250, 36);
     
			add(emoButton);
			add(meganeButton);
			add(iloButton);
			add(tsunButton);
			add(bossButton);
			
			add(emoButton2);
			add(meganeButton2);
			add(iloButton2);
			add(tsunButton2);
			add(bossButton2);
			
			add(startButton);
			add(backButton);
			
			addGraphic(selection);
			addGraphic(selection2);
			addGraphic(yourCharacter);
			addGraphic(yourOpponent);
			
			currentCharacter = "";
			currentOpponent = "";
		}
		
		public function startGame():void
		{
			if (currentCharacter == "" || currentOpponent == "")
				return;
			
			FP.world = new GameWorld(currentCharacter, currentOpponent);
     
			destroy();
		}
		
		public function returnMenu():void
		{
			FP.world = new MainMenu();
     
			destroy();
		}
		
		public function selectCharacter(name:String):void
		{
			currentCharacter = name;
			
			if (name == "emo") {
				selection.x = 68;
				selection.y = 318;
			} else if (name == "megane") {
				selection.x = 268;
				selection.y = 218;
			} else if (name == "ilo") {
				selection.x = 118;
				selection.y = 418;
			} else if (name == "tsun") {
				selection.x = 218;
				selection.y = 418;
			} else if (name == "boss") {
				selection.x = 168;
				selection.y = 318;
			}
		}
		
		public function selectOpponent(name:String):void
		{
			currentOpponent = name;
			
			if (name == "emo") {
				selection2.x = 468;
				selection2.y = 298;
			} else if (name == "megane") {
				selection2.x = 668;
				selection2.y = 298;
			} else if (name == "ilo") {
				selection2.x = 518;
				selection2.y = 398;
			} else if (name == "tsun") {
				selection2.x = 618;
				selection2.y = 398;
			} else if (name == "boss") {
				selection2.x = 568;
				selection2.y = 298;
			}
		}
		
		public function destroy():void
		{
			removeAll();
			
			emoButton = null;
			meganeButton = null;
			iloButton = null;
			tsunButton = null;
			bossButton = null;
			
			emoButton2 = null;
			meganeButton2 = null;
			iloButton2 = null;
			tsunButton2 = null;
			bossButton2 = null;
			
			startButton = null;
			backButton = null;
		}
	}

}