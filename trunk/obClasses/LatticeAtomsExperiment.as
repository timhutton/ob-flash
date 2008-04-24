package obClasses
{

import obClasses.Experiment;
import obClasses.LatticeAtom;

public class LatticeAtomsExperiment extends Experiment
{
	public function LatticeAtomsExperiment()
	{
		super();
		this._sizeX=150;
		this._sizeY=140;
	}

	override protected function createChildren():void
	{
		super.createChildren();
		// create some atoms in random positions
		var i:int;
		const N_ATOMS:int = 200;
		for(i=0;i<N_ATOMS;i++)
		{
			var atom:LatticeAtom = new LatticeAtom();
			atom.x = uint(Math.random()*10000) % sizeX;
			atom.y = uint(Math.random()*10000) % sizeY;
			this.atoms.push(atom);
			this.addChild(atom);
		}
	}

	override public function timeStep():void
	{		
		super.timeStep();

		for each (var atom:LatticeAtom in this.atoms)
		{
			// move the atom at random
			atom.x += uint(Math.random()*1000)%3 - 1;
			atom.y += uint(Math.random()*1000)%3 - 1;
			// clamp to remain within area
			atom.x = Math.max(0,Math.min(sizeX-1,atom.x));
			atom.y = Math.max(0,Math.min(sizeY-1,atom.y));
		}
	}
}

}
