package obClasses
{

import mx.containers.Canvas;
import flash.geom.Point;

/**
 *    Experiment: base class for different experiment types
 */
public class Experiment extends Canvas
{
	/** the atoms that are present in the world */
	protected var atoms:Array = new Array();

	/** the horizontal size of the world */
	protected var _sizeX:uint;
	
	/** the vertical size of the world */
	protected var _sizeY:uint;

	/** perform one timestep computation (to be overridden) */
	public function timeStep():void { _iterations++; }

	/** return the horizontal size of the world */
	public function get sizeX():uint { return _sizeX; }

	/** return the vertical size of the world */
	public function get sizeY():uint { return _sizeY; }

	protected var _iterations:uint = 0;

	public function get iterations():uint { return _iterations; }
}

}
