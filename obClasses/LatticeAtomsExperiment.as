package obClasses
{

import obClasses.Experiment;
import obClasses.LatticeAtom;

/** A 2D square lattice world. 
 * @see LatticeAtom
*/
public class LatticeAtomsExperiment extends Experiment
{
	public function LatticeAtomsExperiment()
	{
		super();
		this._sizeX=X*LatticeAtom.EDGE;
		this._sizeY=Y*LatticeAtom.EDGE;
	}

	override protected function createChildren():void
	{
		super.createChildren();
		// create some atoms in random positions
		var i:int;
		const N_ATOMS:int = 100;
		for(i=0;i<N_ATOMS;i++)
		{
			var atom:LatticeAtom = new LatticeAtom();
			atom.x = (uint(Math.random()*10000) % X) * LatticeAtom.EDGE;
			atom.y = (uint(Math.random()*10000) % Y) * LatticeAtom.EDGE;
			this.atoms.push(atom);
			this.addChild(atom);
		}
	}

	/** @inheritDoc */
	override public function timeStep():void
	{		
		super.timeStep();

		for each (var atom:LatticeAtom in this.atoms)
		{
			// move the atom at random
			atom.x += (uint(Math.random()*1000)%3 - 1)*LatticeAtom.EDGE;
			atom.y += (uint(Math.random()*1000)%3 - 1)*LatticeAtom.EDGE;
			// clamp to remain within area
			atom.x = Math.max(0,Math.min(X-1,atom.x/LatticeAtom.EDGE))*LatticeAtom.EDGE;
			atom.y = Math.max(0,Math.min(Y-1,atom.y/LatticeAtom.EDGE))*LatticeAtom.EDGE;
		}
	}

	protected const X:uint = 60;
	protected const Y:uint = 50;
}

}
