package obClasses
{

import mx.containers.Canvas;
import flash.geom.Point;

/** Base class for different experiment types. */
public class Experiment extends Canvas
{
	/** Perform one timestep computation. */
	public function timeStep():void {}

	/** The horizontal size of the world. */
	public function get sizeX():uint { return _sizeX; }

	/** The vertical size of the world. */
	public function get sizeY():uint { return _sizeY; }

	// protected things

	protected var atoms:Array = new Array();
	protected var _sizeX:uint;
	protected var _sizeY:uint;
}

}
