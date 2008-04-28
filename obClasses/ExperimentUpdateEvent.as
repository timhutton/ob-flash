package obClasses
{

import flash.events.Event;

/** Broadcast when the experiment makes an update. */
public class ExperimentUpdateEvent extends Event
{
	protected var _new_it_count:uint = 1;

	/** the new iteration count being announced by the event. */
	public function get new_it_count():uint { return _new_it_count; }

	/** Used for when the experiment has updated. */
	public static const UPDATE:String = "ExperimentUpdateEvent";

	public function ExperimentUpdateEvent(ic:uint,type:String)
	{
		super(type,true,true);
		_new_it_count = ic;
	}

	/** must override the inherited clone function */
	override public function clone():Event 
	{
	      return new ExperimentUpdateEvent(_new_it_count,UPDATE);
      	}
}
	
}
