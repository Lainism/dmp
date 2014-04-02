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
		
		private var currentCharacter:String;
		private var currentOpponent:String;
		
		public function CharacterSelect() 
		{
			addGraphic(new Image(BG));
			
			emoButton = new Button(selectCharacter, "emo", 270, 250);
			meganeButton = new Button(selectCharacter, "megane", 270, 300);
			iloButton = new Button(selectCharacter, "ilo", 270, 350);
			tsunButton = new Button(selectCharacter, "tsun", 270, 400);
			bossButton = new Button(selectCharacter, "boss", 270, 450);
			
			emoButton2 = new Button(selectOpponent, "emo", 470, 250);
			meganeButton2 = new Button(selectOpponent, "megane", 470, 300);
			iloButton2 = new Button(selectOpponent, "ilo", 470, 350);
			tsunButton2 = new Button(selectOpponent, "tsun", 470, 400);
			bossButton2 = new Button(selectOpponent, "boss", 470, 450);
			
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
			
			currentCharacter = "";
			currentOpponent = "";
		}
		
		public function startGame():void
		{
			if (currentCharacter == "" || currentOpponent == "")
				return;
			
			FP.world = new GameWorld();
     
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
		}
		
		public function selectOpponent(name:String):void
		{
			currentOpponent = name;
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