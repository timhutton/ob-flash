package obClasses
{

import flash.utils.Timer;
import flash.events.*;
import mx.containers.Canvas;
import mx.controls.*;
import mx.core.*;
import mx.events.*;

public class CollisionsCanvas extends Canvas
{
	public var running_delay:int = 4;
	public var is_running:Boolean = true;

	private static var N_ATOMS:Number = 50;
	private var atoms:Array = new Array();

	private var frame_delay_remaining:int = running_delay;

	private var areaX:Number = 500;
	private var areaY:Number = 500;

	public function CollisionsCanvas()
	{
		super();
	}

	/*protected function OnMouseMove(event:MouseEvent):void
	{
		// trying to add panning to move around the area - not yet working 
		if(event.localX > (this.areaX/4)) this.x-=10;
		else this.x+=10;
		event.updateAfterEvent();
	}*/

	override protected function createChildren():void
	{
		super.createChildren();
		// create some atoms in random positions
		var i:int;
		for(i=0;i<N_ATOMS;i++)
		{
			var atom:Atom = new Atom();
			atom.x = Math.random()*this.areaX;
			atom.y = Math.random()*this.areaY;
			this.atoms.push(atom);
			this.addChild(atom);
		}
		//this.addEventListener(MouseEvent.MOUSE_OVER,OnMouseMove);
	}

	public function doTimeStep(event:Event):void
	{
		// running_delay tells us whether to update on the current frame tick, or wait for a later one
		if(this.frame_delay_remaining-->0) return;
		else this.frame_delay_remaining=running_delay;

		for each (var atom:Atom in this.atoms)
		{
			// move the atom (assume the velocity was constant over the timestep)
			atom.x += atom.velocity.x;
			atom.y += atom.velocity.y;
			// if the atom has moved outside the area, move it back in and reverse one component of the velocity
			// (atoms are circles with their x,y in the top-left corner)
			if(atom.x<0) 
			{ 
				// (safest implementation is to ensure the atom is moving away from the edge after the bounce)
				atom.velocity.x = Math.abs(atom.velocity.x); 
				atom.x=0; 
			}
			else if(atom.x>=this.areaX-atom.R*2) 
			{ 
				atom.velocity.x = -1*Math.abs(atom.velocity.x); 
				atom.x=this.areaX-atom.R*2-1; 
			}
			if(atom.y<0) 
			{ 
				atom.velocity.y = Math.abs(atom.velocity.y); 
				atom.y=0; 
			}
			else if(atom.y>=this.areaY-atom.R*2) 
			{ 
				atom.velocity.y = -1*Math.abs(atom.velocity.y);
				atom.y=this.areaY-atom.R*2-1; 
			}
		}
	}

}

}