package obClasses
{

import mx.core.Application;
import mx.containers.Canvas;
import mx.controls.Alert;
import mx.controls.Text;
import flash.events.Event;
import obClasses.*;

/** A visual space containing an experiment with moving atoms. */
public class CollisionsArea extends Canvas
{
	/** The number of timesteps that are taken per frame update. Determines the speed of the application. */
	public function get timesteps_per_frame():uint { return _timesteps_per_frame; }
	public function set timesteps_per_frame(n:uint):void { _timesteps_per_frame=n; }

	/** The number of timesteps (iterations) elapsed since the start of the experiment. */
	public function get iterations():uint { return _iterations; }

	protected function setIterations(ic:uint):void // (but try this with a protected setter function, it doesn't work)
	{ 
		_iterations=ic; 

		// announce the update
		dispatchEvent(new ExperimentUpdateEvent(_iterations,ExperimentUpdateEvent.UPDATE));
	}

	/** The width of the area. */
	public function get areaX():uint { return currentExperiment.sizeX; }
	/** The height of the area. */
	public function get areaY():uint { return currentExperiment.sizeY; }
	/** Replace the current experiment with a new one. */
	public function newExperiment():void
	{
		removeChild(currentExperiment);
		currentExperiment = new LatticeAtomsExperiment();
		addChild(currentExperiment);
		width = currentExperiment.sizeX * scaleX;
		height = currentExperiment.sizeY * scaleY;
		setIterations(0);
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

	/** Perform a number of timesteps, as determined by timesteps_per_frame. */
	public function Update(event:Event):void
	{
		var i:uint;
		for(i=0;i<timesteps_per_frame;i++)
			currentExperiment.timeStep();

		setIterations(iterations + timesteps_per_frame);
	}

	// protected things

	protected var _timesteps_per_frame:uint = 1;

	protected var currentExperiment:Experiment;

	protected var _iterations:uint = 0;

}

}
