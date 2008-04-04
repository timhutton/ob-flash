package obClasses
{

import 	mx.containers.Canvas;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.events.Event;
import flash.filters.DropShadowFilter;
import mx.controls.Label;

public class CollisionsCanvas extends Canvas
{
	public var running_delay:int = 4;

	public static var N_ATOMS:Number = 50;
	public var atoms:Array = new Array();
	public var is_running:Boolean = true;

	public var frame_delay_remaining:int = running_delay;

	public function CollisionsCanvas()
	{
		super();
		// create some atoms in random positions
		var dropShadow:DropShadowFilter = new DropShadowFilter();
		dropShadow.alpha=0.2;
		var i:int;
		for(i=0;i<N_ATOMS;i++)
		{
			var atom:Atom = new Atom();
			atom.x = Math.random()*300;
			atom.y = Math.random()*300;
			//atom.filters = [dropShadow];
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
			atom.x += atom.velocity.x;
			atom.y += atom.velocity.y;
			if(atom.x<atom.R) 
			{ 
				atom.velocity.x = Math.abs(atom.velocity.x); 
				atom.x=atom.R; 
			}
			else if(atom.x>=this.width-atom.R) 
			{ 
				atom.velocity.x = -1*Math.abs(atom.velocity.x); 
				atom.x=this.width-atom.R-1; 
			}
			if(atom.y<atom.R) 
			{ 
				atom.velocity.y = Math.abs(atom.velocity.y); 
				atom.y=atom.R; 
			}
			else if(atom.y>=this.height-atom.R) 
			{ 
				atom.velocity.y = -1*Math.abs(atom.velocity.y); 											atom.y=this.height-atom.R-1; 
			}
		}
	}
}

}