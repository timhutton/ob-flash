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

/** Has a 2D floating-point location and a fixed radius. */
public class CircularAtom extends Atom
{
	/** the radius of the atom */
	public static const R:Number = 20; // radius of each atom

	public static const INITIAL_SPEED:Number = 5;

	protected var _velocity:Point = new Point(Math.random()*INITIAL_SPEED*2-INITIAL_SPEED,Math.random()*INITIAL_SPEED*2-INITIAL_SPEED);

	// member functions

	public function CircularAtom()
	{
		super();
	}

	/** the current velocity of the atom */
	public function get velocity():Point { return _velocity; }


	override protected function createChildren():void
	{
		super.createChildren();

		var base_color:uint = COLORS[this.type];

		// we add a gradient-filled circle to the canvas
		var specular_offset:int = 10;
		var mat:Matrix = new Matrix();
		mat.createGradientBox(2*R+specular_offset,2*R+specular_offset,0.0,
			-specular_offset,-specular_offset);
		this.graphics.beginGradientFill(GradientType.RADIAL,
			[ColorUtil.adjustBrightness2(base_color,60), 
			base_color, 
			ColorUtil.adjustBrightness2(base_color,-10),
			ColorUtil.adjustBrightness2(base_color,-50)],
				[1, 1, 1,1],
				[0,70,200,255], // the ratios of each gradient segment
				mat,SpreadMethod.PAD);
		this.graphics.drawCircle(R,R,R);
		this.graphics.endFill();

		// and a text label to show the atom's type and state
		var label:Label = new Label();
		label.text = TYPES[this.type] + String(this.state);
		label.setStyle("fontWeight","bold");
		//label.setStyle("textAlign","center"); // (doesn't work?)
		label.setStyle("color","0xCCCCCC");
		label.setStyle("fontSize",String(R-6));
		//label.alpha = 0.2; // (doesn't work?)
		label.x = 3;
		label.y = 7;
		label.includeInLayout = false;
		this.addChild(label);
	}		
}

}
