package obClasses
{

import obClasses.Atom;
import mx.controls.Label;

/** An atom with a 2D integer location, lying on a square lattice. */
public class LatticeAtom extends Atom
{
	public static const EDGE:uint = 10; // drawing size of the atom square
	
	// member functions

	public function LatticeAtom()
	{
		super();
	}

	override protected function createChildren():void
	{
		super.createChildren();

		var base_color:uint = COLORS[this.type];

		this.graphics.beginFill(base_color);
		this.graphics.drawRect(0,0,EDGE,EDGE);
		this.graphics.endFill();
				
		// and a text label to show the atom's type and state
		var label:Label = new Label();
		label.text = TYPES[type]+String(state);
		label.setStyle("color","0xEEEEEE");
		label.setStyle("fontSize","4");
		label.setStyle("textAlign","center");
		label.x = -2;
		this.addChild(label);
	}		
}

}
