package obClasses
{

import mx.containers.Canvas;
import mx.controls.Label;
import mx.controls.Text;
import mx.utils.ColorUtil;
//import flash.filters.DropShadowFilter;
import flash.geom.Point;
import flash.geom.Matrix;
import flash.display.GradientType;
import flash.display.SpreadMethod;

public class Atom extends Canvas
{
	// public data

	public const type:int = int(Math.random()*1000) % 6;
	public var state:int;

	public const R:Number = 20; // radius of each atom

	public var velocity:Point = new Point(Math.random()*R*2-R,Math.random()*R*2-R);

	// private data 

	private static var TYPES:Array = ["a","b","c","d","e","f"];
	private static var COLORS:Array = [0xcfcf00,0x5f5f5f,0x0753db,0xee10ac,0xef160f,0x00df06];

	// member functions

	public function Atom()
	{
		super();

		this.state = 0;
	}

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
		label.text = Atom.TYPES[this.type] + String(this.state);
		label.setStyle("fontWeight","bold");
		//label.setStyle("textAlign","center"); // (doesn't work?)
		label.setStyle("color","0xCCCCCC");
		label.setStyle("fontSize",String(R-4));
		//label.alpha = 0.2; // (doesn't work?)
		label.x = 5;
		label.y = 5;
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