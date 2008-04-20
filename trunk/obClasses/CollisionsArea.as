package obClasses
{

import mx.containers.Canvas;
import flash.events.Event;
import obClasses.*;

public class CollisionsArea extends Canvas
{
	public var running_delay:int = 4;
	protected var frame_delay_remaining:int = running_delay;

	protected var currentExperiment:Experiment;

	public function get areaX():uint { return currentExperiment.sizeX; }
	public function get areaY():uint { return currentExperiment.sizeY; }

	public function newExperiment():void
	{
		// this doesn't work properly : get bad size afterwards
		scaleX = scaleY = 1.0;
		removeChild(currentExperiment);
		currentExperiment = new LatticeAtomsExperiment();
		width = currentExperiment.sizeX;
		height = currentExperiment.sizeY;
		addChild(currentExperiment);
	}

	public function CollisionsArea()
	{
		super();
		currentExperiment = new CircularAtomsExperiment();
		width = currentExperiment.sizeX;
		height = currentExperiment.sizeY;
	}

	override protected function createChildren():void
	{
		super.createChildren();
		addChild(currentExperiment);
	}

	public function doTimeStep(event:Event):void
	{
		// running_delay tells us whether to update on the current frame tick, or wait for a later one
		if(this.frame_delay_remaining-->0) return;
		else this.frame_delay_remaining=running_delay;

		currentExperiment.timeStep();	
	}
}

}