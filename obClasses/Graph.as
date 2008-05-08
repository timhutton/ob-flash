package obClasses
{

import obClasses.*;
import mx.containers.Canvas;
import mx.controls.Label;

/** Listens for reaction events and other events and plots them in various ways. */
public class Graph extends Canvas
{	
	/** Constructor. */
	public function Graph()
	{
		super();
	}

	override protected function createChildren():void
	{
		super.createChildren();

		// prepare for drawing
		graphics.lineStyle(2, 0x990000, .75);

		// OK, ready to listen for certain events
		stage.addEventListener(ReactionEvent.REACTION,onReactionEvent);
	}

	protected function onReactionEvent(event:ReactionEvent):void
	{
		// accumulate the graph (just a dummy one for now)
		var xp:Number = (event.timestamp-_start_timestep)*3;
		if(xp>width)
		{
			graphics.clear();
			graphics.lineStyle(2, 0x990000, .75); // seems like we need to call this again after clear()
			_start_timestep = event.timestamp;		
			xp = 0;	
		}
		graphics.moveTo(xp,0);
		graphics.lineTo(xp,Math.random()*200);
	}

	protected var _start_timestep:uint = 0;
}

}
