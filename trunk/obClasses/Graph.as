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

		// we listen for certain events
		stage.addEventListener(ReactionEvent.REACTION,onReactionEvent);

		// prepare for drawing
		graphics.lineStyle(2, 0x990000, .75);
	}

	protected function onReactionEvent(event:ReactionEvent):void
	{
		// accumulate the graph (just a dummy one for now)
		var xp:Number = event.timestamp*3;
		graphics.lineTo(xp,Math.random()*200);
		if(xp>width)
			scaleX = width/xp;
	}
}

}
