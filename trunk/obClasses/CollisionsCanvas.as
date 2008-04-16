package obClasses
{

import mx.containers.Canvas;
import flash.events.Event;

public class CollisionsCanvas extends Canvas
{
	public var running_delay:int = 4;
	private var frame_delay_remaining:int = running_delay;

	private var atoms:Array = new Array();

	public const areaX:Number = 1000;
	public const areaY:Number = 1000;

	public function CollisionsCanvas()
	{
		super();
		width = areaX;
		height = areaY;
	}

	override protected function createChildren():void
	{
		super.createChildren();
		// create some atoms in random positions
		var i:int;
		const N_ATOMS:int = 100;
		for(i=0;i<N_ATOMS;i++)
		{
			var atom:Atom = new Atom();
			atom.x = Math.random()*this.areaX;
			atom.y = Math.random()*this.areaY;
			this.atoms.push(atom);
			this.addChild(atom);
		}
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
			// (atoms are circles with their x,y in the top-left corner (make clipping simpler))
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