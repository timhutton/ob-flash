package obClasses
{

import flash.events.Event;

public class ExperimentUpdateEvent extends Event
{
	protected var _new_it_count:uint = 1;

	public function get new_it_count():uint { return _new_it_count; }

	public static const UPDATE:String = "ExperimentUpdateEvent";

	public function ExperimentUpdateEvent(ic:uint,type:String)
	{
		super(type);
		_new_it_count = ic;
	}

	/** must override the inherited clone function */
	override public function clone():Event 
	{
	      return new ExperimentUpdateEvent(_new_it_count,UPDATE);
      	}
}
	
}
