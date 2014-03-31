package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author Minttu Mäkinen
	 */
	public class ComboGraphic extends Entity
	{
		[Embed(source = '../graphics/esc.png')]
		private const EMO:Class;
		private var currentImage:Image;
		private var msg1:Text;
		private var msg2:Text;
		private var msg3:Text;
		
		private var sprites:Graphiclist;
		
		private var path:Vector.<Point>;
		
		public function ComboGraphic(playerCharacter:String)
		{
			if (playerCharacter == "emo")
				 currentImage = new Image(EMO);
			
			currentImage.x = -215;
			currentImage.y = -190;
			
			msg1 = new Text("CORRECT");
			msg1.size = 50;
			msg1.x = -250;
			msg1.y = 0;
			
			msg2 = new Text("Bullet damage increased!");
			msg2.size = 40;
			msg2.x = -250;
			msg2.y = 50;
			
			msg3 = new Text("1 hit!");
			msg3.size = 20;
			msg3.x = -250;
			msg3.y = 100;
			
			sprites = new Graphiclist(currentImage, msg1, msg2, msg3);
			sprites.visible = false;
			graphic = sprites;
			
			path = new Vector.<Point>();
		}
		
		public function entryAnimation(distanceBetweenPoints:Number):void
		{
			var i:Number;
			 
			var vec:Vector.<Point> = new Vector.<Point>();
			 
			var yPos:Number = 200;
			 
			for (i = -Math.PI; i*0.01 < Math.PI / 2; i += distanceBetweenPoints)
			{
				vec.push(new Point((Math.cos(i*0.01 + Math.PI / 2)+1)*200+50, yPos));
			}
		 
			path = vec;
			sprites.visible = true;
		}
		
		public function exitAnimation(distanceBetweenPoints:Number):void
		{
			var i:Number;
			 
			var vec:Vector.<Point> = new Vector.<Point>();
			 
			var yPos:Number = 400;
			 
			for (i = -Math.PI / 2; i*0.01 < Math.PI; i += distanceBetweenPoints)
			{
				vec.push(new Point((Math.sin(i*0.01 + Math.PI / 2)+1)*200+50, yPos));
			}
		 
			path = vec;
			sprites.visible = false;
		}
		
		override public function update():void
		{
			if (path.length > 0)
			{
				var tmp:Point = path.pop();
				//trace(tmp.x);
				x = tmp.x;
				y = tmp.y;
				//currentImage.x = tmp.x;
				//currentImage.y = tmp.y;
			}
		}
	}

}