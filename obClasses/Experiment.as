package obClasses
{

import mx.containers.Canvas;
import flash.geom.Point;
//import obClasses.Reaction;

/** Base class for different experiment types. */
public class Experiment extends Canvas
{
	/** Perform one timestep computation. */
	public function timeStep():void { _iterations++; }

	/** The horizontal size of the world. */
	public function get sizeX():uint { return _sizeX; }

	/** The vertical size of the world. */
	public function get sizeY():uint { return _sizeY; }

	/** The number of timesteps (iterations) elapsed since the start of the experiment. */
	public function get iterations():uint { return _iterations; }

	/** Redraw the experiment after changes. */
	public function redraw():void {}

	// protected things

	protected var atoms:Array = new Array();
	protected var bond_pairs:Array = new Array();
	protected var global_reactions:Array = new Array();

	protected var _sizeX:uint;
	protected var _sizeY:uint;
	protected var _iterations:uint = 0;
}

}
