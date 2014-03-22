package  
{
	import flash.display.DisplayObject;
	import net.flashpunk.Entity;
	/**
	 * An object pool that handles the numerous enemy and player bullets that are simultaneously on screen
	 * @author A.V.
	 */
	public class BulletPool 
	{
		private var pool:Array;				// Pool itself
		private var iterator:int;			// Size of the pool
		
		public function BulletPool(type:Class, size:int) 
		{
			pool = new Array();
			iterator = size;
			
			var i:int = size;
			while (--i > -1)
				pool[i] = new type();
			
		}
		
		public function activate():Bullet
		{
			if (iterator > 0) {
				return pool[--iterator];
			}
			else
				throw new Error("Pool has run out of objects!");
		}
		
		public function deactivate(o:Bullet):void
		{
			pool[iterator++] = o;
		}
		
	}

}