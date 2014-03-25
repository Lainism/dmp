package  
{
	import flash.events.Event;
	import flash.geom.Point;
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	/**
	 * Bullets shot by player
	 * @author Minttu Mäkinen
	 */
public class PlayerBullet extends Bullet
    {
		 
        public function PlayerBullet()
        {
			super()
            graphic = GraphicAssets.Pbullet_graph1;
			mask = new Pixelmask(GraphicAssets.Player_bullet1, -8.5, -8.5);
			this.DAMAGE = 1;
        }
		
         
        override public function update():void
        {
			if (_pathToFollow.length > 0)
			{
				x = xPos + _pathToFollow[0].x;
				y = yPos + _pathToFollow[0].y;
				 
				_pathToFollow.shift();
			}
        }
         
    }
 
}