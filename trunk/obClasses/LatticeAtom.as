package obClasses
{

import obClasses.Atom;
import mx.controls.Label;
import mx.controls.Text;
import mx.utils.ColorUtil;
import flash.geom.Point;
import flash.geom.Matrix;
import flash.display.GradientType;
import flash.display.SpreadMethod;

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
		label.text = Atom.TYPES[this.type] + String(this.state);
		label.setStyle("fontWeight","bold");
		//label.setStyle("textAlign","center"); // doesn't work?
		//label.setStyle("horizontalCenter","0"); // doesn't work?
		label.setStyle("color","0xCCCCCC");
		label.setStyle("fontSize","6");
		//label.alpha = 0.2; // (doesn't work?)
		this.addChild(label);
	}		
}

}
