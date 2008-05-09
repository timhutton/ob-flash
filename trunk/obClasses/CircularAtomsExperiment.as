package obClasses
{

import flash.geom.Point;
import mx.containers.Canvas;
import obClasses.Experiment;
import obClasses.CircularAtom;

/** An experiment with circular atoms in a 2D rectangular area. */
public class CircularAtomsExperiment extends Experiment
{
	public static const N_ATOMS:int = 50;

	/** Constructor. */
	public function CircularAtomsExperiment()
	{
		super();
		this._sizeX=600;
		this._sizeY=500;
	}

	/** @inheritDoc */
	override protected function createChildren():void
	{
		super.createChildren();
		// create some atoms in random positions
		var i:int;
		for(i=0;i<N_ATOMS;i++)
		{
			var atom:CircularAtom = new CircularAtom();
			atom.x = Math.random() * (sizeX-CircularAtom.R*2-1);
			atom.y = Math.random() * (sizeY-CircularAtom.R*2-1);
			this.atoms.push(atom);
			this.addChild(atom);
		}
	}

	/** @inheritDoc */
	override public function timeStep():void
	{
		super.timeStep();
	
		moveAtoms();
		bounceAtomsOffWalls();
		bounceAtomsOffEachOther();
	}

	protected function bounceAtomsOffWalls():void
	{
		// (atoms are circles with their x,y in the top-left corner (makes clipping simpler))
		const max_x:Number = this.sizeX-CircularAtom.R*2-1;
		const max_y:Number = this.sizeY-CircularAtom.R*2-1;

		// recompute the velocity of each atom
		var atom:CircularAtom;
		for each (atom in atoms)
		{
			if((atom.x<0 && atom.velocity.x<0) || (atom.x>max_x && atom.velocity.x>0))
				atom.velocity.x = -atom.velocity.x;
			if((atom.y<0 && atom.velocity.y<0) || (atom.y>max_y && atom.velocity.y>0))
				atom.velocity.y = -atom.velocity.y;
		}
	}

	protected function bounceAtomsOffEachOther():void
	{
		var a:CircularAtom;
		var b:CircularAtom;
		var i:uint;
		var j:uint;
		for(i=0;i<N_ATOMS;i++)
		{
			a = atoms[i];
			for(j=i+1;j<N_ATOMS;j++)
			{
				b=atoms[j];
				bounceTwoAtomsOffEachOther(a,b);
			}
		}
	}

	protected function bounceTwoAtomsOffEachOther(a:CircularAtom,b:CircularAtom):void
	{
		// calculate some vectors 
		var dx:Number = a.x - b.x;
		var dy:Number = a.y - b.y;
		var dvx:Number = a.velocity.x - b.velocity.x;
		var dvy:Number = a.velocity.y - b.velocity.y;	
		var distance2:Number = dx*dx + dy*dy;

		const d:Number = CircularAtom.R*2;
		const d2:Number = d*d;
			
		if (Math.abs(dx) > d || Math.abs(dy) > d) 
			return;
		if (distance2 > d2)
			return;
		
		// make absolutely elastic collision
		var mag:Number = dvx*dx + dvy*dy;
		
		// test that balls move towards each other	
		if (mag > 0) 
			return;
	
		mag /= distance2;
		
		var delta_vx:Number = dx*mag;
		var delta_vy:Number = dy*mag;
		
		a.velocity.x -= delta_vx;
		a.velocity.y -= delta_vy;
		
		b.velocity.x += delta_vx;
		b.velocity.y += delta_vy;
	}

	protected function moveAtoms():void
	{
		// move each atom
		var atom:CircularAtom;
		for each (atom in atoms)
		{
			// Euler integration: we simply assume the velocity was constant over the whole timestep
			atom.x += atom.velocity.x;
			atom.y += atom.velocity.y;
		}
	}
}

}
