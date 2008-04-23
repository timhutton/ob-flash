package obClasses
{

import mx.containers.Canvas;

public class Atom extends Canvas
{
	/** atoms have fixed type a-f, represented as 0-5 */	protected const _type:int = int(Math.random()*1000) % 6;

	/** atoms have a variable state */
	protected var _state:int = 0;

	/** get the type of this atom 0-5 */
	public function get type():int { return this._type; }

	/** get the state of this atom */
	public function get state():int { return this._state; }

	/** set the state of this atom */
	public function set state(s:int):void { this._state=s; }

	/** the atom types, represented as strings */
	protected static var TYPES:Array = ["a","b","c","d","e","f"];

	/** the atom colours */
	protected static var COLORS:Array = [0xcfcf00,0x5f5f5f,0x0753db,0xee10ac,0xef160f,0x00df06];

}
}
