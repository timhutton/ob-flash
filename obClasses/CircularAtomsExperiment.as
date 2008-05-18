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
		this.global_reactions.push(new Reaction(0,0,false,0,0,1,true,2));
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
	override public function redraw():void
	{
		super.redraw();

		// redraw chemical bonds
		graphics.clear();
		graphics.lineStyle(10, 0x000000, 0.2); // thickness,colour,opacity
		var i:int;
		var a:CircularAtom;
		var b:CircularAtom;
		for(i = 0;i<bond_pairs.length;i+=2)
		{
			a = bond_pairs[i];
			b = bond_pairs[i+1];
			graphics.moveTo(a.x+CircularAtom.R,a.y+CircularAtom.R);
			graphics.lineTo(b.x+CircularAtom.R,b.y+CircularAtom.R);
		}	
	}

	/** @inheritDoc */
	override public function timeStep():void
	{
		super.timeStep();
	
		moveAtoms();
		bounceAtomsOffWalls();
		bounceAtomsOffEachOther();
		for(var i:uint=0;i<bond_pairs.length;i+=2)
			bounceTwoAtomsOffEachOthersBonds(bond_pairs[i+0],bond_pairs[i+1]);
	}

	/** Does any reaction apply to these atoms, since they've collided? */
	protected function Collision(a:CircularAtom,b:CircularAtom):void
	{
		for each(var r:Reaction in global_reactions)
		{
			// TODO: check pre_bond, set post_bond
			if(r.a_type == a.type && r.a_pre_state == a.state &&
				r.b_type == b.type && r.b_pre_state == b.state)
			{
				a.state = r.a_post_state;				
				b.state = r.b_post_state;				
				bond_pairs.push(a);
				bond_pairs.push(b);
			}
		}
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

		Collision(a,b);
	}

	protected function bounceTwoAtomsOffEachOthersBonds(a:CircularAtom,b:CircularAtom):void
	{
		// we simply pretend that b is on the other side of a
		const bond_d:Number = CircularAtom.R*3; // how long are bonds allowed to be?
		const ghost_d:Number = bond_d + CircularAtom.R*2;
		var pre_dist:Number = Math.sqrt((a.x-b.x)*(a.x-b.x)+(a.y-b.y)*(a.y-b.y));
		var b2x:Number = b.x + (a.x-b.x)*ghost_d/pre_dist;
		var b2y:Number = b.y + (a.y-b.y)*ghost_d/pre_dist;

		const d:Number = CircularAtom.R*2;
		const d2:Number = d*d;
			
		// calculate some vectors 
		var dx:Number = a.x - b2x;
		var dy:Number = a.y - b2y;
		var dvx:Number = a.velocity.x - b.velocity.x;
		var dvy:Number = a.velocity.y - b.velocity.y;	
		var distance2:Number = dx*dx + dy*dy;

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
