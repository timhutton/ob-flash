package obClasses
{

import flash.geom.Point;
import mx.containers.Canvas;
import obClasses.Experiment;
import obClasses.CircularAtom;

public class CircularAtomsExperiment extends Experiment
{
	public function CircularAtomsExperiment()
	{
		super();
		this._sizeX=400;
		this._sizeY=300;
	}

	override protected function createChildren():void
	{
		super.createChildren();
		// create some atoms in random positions
		var i:int;
		const N_ATOMS:int = 100;
		for(i=0;i<N_ATOMS;i++)
		{
			var atom:CircularAtom = new CircularAtom();
			atom.x = Math.random() * sizeX;
			atom.y = Math.random() * sizeY;
			this.atoms.push(atom);
			this.addChild(atom);
		}
	}

	override public function timeStep():void
	{
		super.timeStep();
		for each (var atom:CircularAtom in this.atoms)
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
			else if(atom.x>=this.sizeX-atom.R*2) 
			{ 
				atom.velocity.x = -1*Math.abs(atom.velocity.x); 
				atom.x=this.sizeX-atom.R*2-1; 
			}
			if(atom.y<0) 
			{ 
				atom.velocity.y = Math.abs(atom.velocity.y); 
				atom.y=0; 
			}
			else if(atom.y>=this.sizeY-atom.R*2) 
			{ 
				atom.velocity.y = -1*Math.abs(atom.velocity.y);
				atom.y=this.sizeY-atom.R*2-1; 
			}
		}
	}
}

}
