package obClasses
{

import mx.containers.Canvas;
import mx.controls.Label;
import mx.controls.Text;
import flash.geom.Point;

public class Atom extends Canvas
{
	public var type:String;
	public var state:Number;

	public var velocity:Point = new Point(Math.random()*10,Math.random()*10);

	public var R:Number=20; // radius of each atom

	public function Atom()
	{
		super();

		this.type = 'a';
		this.state = 0;

		this.graphics.beginFill(0xEE7733,0.8);
		this.graphics.drawCircle(this.x,this.y,R);
		this.graphics.endFill();

		/* (haven't yet got the hang of this actionscript stuff... :)
		var label:Label = new Label();
		label.text = this.type + String(this.state);
		label.setStyle("fontWeight","bold");
		this.addChild(label); */
	}		


}

}