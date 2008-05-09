package obClasses
{

import mx.containers.Canvas;

/** A base class for all types of atom. */
public class Atom extends Canvas
{
	protected const _type:int = int(Math.random()*1000) % 6;

	/** atoms have fixed type a-f, represented as 0-5 */
	public function get type():int { return this._type; }

	protected var _state:int = int(Math.random()*1000) % 150;
	/** atoms have a variable state */
	public function get state():int { return this._state; }
	public function set state(s:int):void 
	{ 
		this._state=s;
 		this.toolTip = TYPES[type]+String(_state);
	}

	public function Atom()
	{
		super();
		this.toolTip = TYPES[type]+String(_state);
		this.buttonMode = true;
		this.useHandCursor = true;
		this.autoLayout = false;
		this.includeInLayout = false;
		this.cacheAsBitmap = true;
	}

	protected static var TYPES:Array = ["a","b","c","d","e","f"];

	protected static var COLORS:Array = [0xcfcf00,0x5f5f5f,0x0753db,0xee10ac,0xef160f,0x00df06];

}
}
