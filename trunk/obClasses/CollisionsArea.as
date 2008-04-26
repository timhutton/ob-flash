package obClasses
{

import mx.core.Application;
import mx.containers.Canvas;
import mx.controls.Text;
import flash.events.Event;
import obClasses.*;

/** a visual space containing an experiment with moving atoms */
public class CollisionsArea extends Canvas
{
	protected var _timesteps_per_frame:uint = 1;

	/** we can run at a faster speed by processing more timesteps each frame */
	public function get timesteps_per_frame():uint { return _timesteps_per_frame; }

	/** we can run at a faster speed by processing more timesteps each frame */
	public function set timesteps_per_frame(n:uint):void { _timesteps_per_frame=n; }

	protected var iteration_count_label:Text = new Text();

	protected var currentExperiment:Experiment;

	public function get areaX():uint { return currentExperiment.sizeX; }
	public function get areaY():uint { return currentExperiment.sizeY; }
	public function newExperiment():void
	{
		scaleX = scaleY = 1.0;
		removeChild(currentExperiment);
		currentExperiment = new LatticeAtomsExperiment();
		addChild(currentExperiment);
		iteration_count_label.text = String(currentExperiment.iterations);
		width = currentExperiment.sizeX;
		height = currentExperiment.sizeY;
		invalidateDisplayList(); // width and height doesn't seem to get through, even with this?
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
		iteration_count_label.x=iteration_count_label.y=10;
		iteration_count_label.text = String(currentExperiment.iterations);
		parent.addChild(iteration_count_label);

		var experiment_label:Text = new Text();
		experiment_label.x = 60;
		experiment_label.y = 20;
		experiment_label.text = Application.application.parameters.experiment; // retrieve query string var "experiment"
		parent.addChild(experiment_label);
	}

	public function doTimeStep(event:Event):void
	{
		var i:uint;
		for(i=0;i<timesteps_per_frame;i++)
			currentExperiment.timeStep();
		iteration_count_label.text = String(currentExperiment.iterations);
	}
}

}
