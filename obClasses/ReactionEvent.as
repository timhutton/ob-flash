package obClasses
{

import flash.events.Event;

/** Broadcast when a reaction occurs. */
public class ReactionEvent extends Event
{
	protected var _timestamp:uint;
	
	/** Contains the iterations count when the reaction occurred. */
	public function get timestamp():uint { return _timestamp; }

	/** Used for when the experiment has updated. */
	public static const REACTION:String = "ReactionEvent";

	/** Constructor. */
	public function ReactionEvent(ic:uint,type:String)
	{
		super(type,true,true);
		_timestamp = ic;
	}

	/** Override the inherited clone function. */
	override public function clone():Event 
	{
	      return new ReactionEvent(_timestamp,REACTION);
      	}
}
	
}
