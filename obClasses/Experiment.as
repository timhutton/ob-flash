package obClasses
{

import mx.containers.Canvas;

/**
 *    Experiment: base class for different experiment types
 */
public class Experiment extends Canvas
{
	public function timeStep():void {}
	public function get sizeX():uint { return NaN; }
	public function get sizeY():uint { return NaN; }
}

}