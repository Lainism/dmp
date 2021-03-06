package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	/**
	 * The graphic that shows up when you solve a puzzle
	 * @author Minttu Mäkinen
	 */
	public class ComboGraphic extends Entity
	{
		[Embed(source = '../graphics/esc.png')]
		private const EMO:Class;
		[Embed(source = '../graphics/msc.png')]
		private const MEGANE:Class;
		[Embed(source = '../graphics/iloc.png')]
		private const ILO:Class;
		[Embed(source = '../graphics/tsunc.png')]
		private const TSUN:Class;
		[Embed(source = '../graphics/bsc.png')]
		private const BOSS:Class;
		private var currentImage:Image;
		private var msg1:Text;
		private var msg2:Text;
		private var msg3:Text;
		
		private var sprites:Graphiclist;
		
		private var path:Vector.<Point>;
		private var exiting:Boolean;
		
		public function ComboGraphic(name:String) {
			/* Initializing the elements*/
			
			// Selecting the correct character
			if (name == "emo") {
				currentImage = new Image(EMO);
			} else if (name == "megane") {
				currentImage = new Image(MEGANE);
			} else if (name == "ilo") {
				currentImage = new Image(ILO);
			} else if (name == "tsun") {
				currentImage = new Image(TSUN);
			} else if (name == "boss") {
				currentImage = new Image(BOSS);
			}
			
			currentImage.x = -215;
			currentImage.y = -190;
			
			msg1 = new Text("CORRECT");
			msg1.size = 50;
			msg1.x = -150;
			msg1.y = 100;
			
			msg2 = new Text("Power up!");
			msg2.size = 40;
			msg2.x = -100;
			msg2.y = 150;
			
			msg3 = new Text("1 hit(s)!");
			msg3.size = 40;
			msg3.x = -100;
			msg3.y = 200;
			
			sprites = new Graphiclist(currentImage, msg1, msg2, msg3);
			sprites.visible = false;
			exiting = false;
			graphic = sprites;
			
			path = new Vector.<Point>();
		}
		
		public function entryAnimation(distanceBetweenPoints:Number):void {
			/* Shows an animation of the image sliding on-screen */
			
			var i:Number;
			var vec:Vector.<Point> = new Vector.<Point>();
			var yPos:Number = 200;
			 
			for (i = -Math.PI; i*0.01 < Math.PI / 2; i += distanceBetweenPoints)
			{
				vec.push(new Point((Math.cos(i * 0.01 + Math.PI / 2) + 1) * 200 + 50, yPos));
				//trace((Math.cos(i * 0.01 + Math.PI / 2) + 1) * 200 + 50);
			}
		 
			path = vec;
			sprites.visible = true;
		}
		
		public function exitAnimation(distanceBetweenPoints:Number):void {
			/* Shows an animation of the character sliding off-screen */
			
			var i:Number;
			var vec:Vector.<Point> = new Vector.<Point>();
			var yPos:Number = 200;
			 
			for (i = -Math.PI; i*0.01 < Math.PI / 2; i += distanceBetweenPoints)
			{
				vec.push(new Point((Math.cos(i * 0.01 + Math.PI / 2) + 1) * 200 + 250, yPos));
			}
		 
			path = vec;
			exiting = true;
		}
		
		override public function update():void {
			/* Updates the position of the graphic */
			
			if (path.length > 0)
			{
				if (path.length == 1 && exiting) {
					sprites.visible = false;
					exiting = false;
				}
				var tmp:Point = path.pop();
				x = tmp.x;
				y = tmp.y;
			}
		}
		
		public function comboAmount(amount:Number):void {
			/* Changes the text counter of the graphic */
			msg3.text = amount + " hit(s)!";
		}
	}

}