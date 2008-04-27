package obClasses
{

import obClasses.Atom;
import mx.controls.Label;
import mx.controls.Text;
import mx.utils.ColorUtil;
//import flash.filters.DropShadowFilter;
import flash.geom.Point;
import flash.geom.Matrix;
import flash.display.GradientType;
import flash.display.SpreadMethod;

/** An atom with a 2D integer location, lying on a square lattice. */
public class LatticeAtom extends Atom
{
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
		this.graphics.drawRect(0,0,1,1);;
		this.graphics.endFill();
				
		// and a text label to show the atom's type and state
		var label:Label = new Label();
		label.text = Atom.TYPES[this.type] + String(this.state);
		label.setStyle("fontWeight","bold");
		label.setStyle("textAlign","center");
		label.setStyle("horizontalCenter","0");
		label.setStyle("color","0xCCCCCC");
		label.setStyle("fontSize","1");
		//label.alpha = 0.2; // (doesn't work?)
		label.x = -.5;
		label.y = -.5;
		this.addChild(label);

		// let's get fancy and add a drop shadow too
		/*var dropShadow:DropShadowFilter = new DropShadowFilter();
		dropShadow.alpha = 0.4;
		dropShadow.distance = 8.0;
		dropShadow.blurX = dropShadow.blurY = 8.0;
		this.filters = [dropShadow];*/
	}		
}

}
