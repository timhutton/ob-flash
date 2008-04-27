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
		//iteration_count_label.text = String(currentExperiment.iterations);
		width = currentExperiment.sizeX * scaleX;
		height = currentExperiment.sizeY * scaleY;
		//invalidateDisplayList(); // width and height doesn't seem to get through, even with this?
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

		// this isn't a good way to do things! (please help)
		/*iteration_count_label.x=iteration_count_label.y=10;
		iteration_count_label.text = String(currentExperiment.iterations);
		parent.addChild(iteration_count_label);*/
	}

	/** Perform a number of timesteps, as determined by timesteps_per_frame. */
	public function Update(event:Event):void
	{
		var i:uint;
		for(i=0;i<timesteps_per_frame;i++)
			currentExperiment.timeStep();
		//iteration_count_label.text = String(currentExperiment.iterations);

		// announce the update
		dispatchEvent(new ExperimentUpdateEvent(currentExperiment.iterations,ExperimentUpdateEvent.UPDATE));
	}

	// protected things

	protected var _timesteps_per_frame:uint = 1;

	//protected var iteration_count_label:Text = new Text();

	protected var currentExperiment:Experiment;

}

}
