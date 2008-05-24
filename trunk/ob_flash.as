// the main functions for the appliction

import flash.display.Stage;
import flash.geom.Matrix;
import mx.controls.Alert;
import obClasses.*;

private var currentLevel:Number = 1;

public var zoomSpeed:Number = 0.0;

public var mouseGrabbed:Point;

public function appInit():void
{
	// retrieve query string var "experiment" from URL, load XML experiment file, initialise (TODO)
	if(Application.application.parameters.hasOwnProperty("experiment") && Application.application.parameters.experiment.length>0)
	{
		RetrieveExperiment(Application.application.parameters.experiment);
	}

	// we start off with the atoms moving
	addEventListener(Event.ENTER_FRAME, collisionsArea.Update);

	// we update the iterations count label when the experiment updates
	addEventListener(ExperimentUpdateEvent.UPDATE,updateItCountLabel);

	// we allow the collisions area to be dragged
	collisionsArea.addEventListener(MouseEvent.MOUSE_DOWN, startDragging);
}

public function testCGI():void
{
	try 
	{
		var loader:URLLoader = new URLLoader();
		loader.addEventListener(Event.COMPLETE, CGI_return);
		loader.load(new URLRequest("http://www.sq3.org.uk/test/experiments/get_experiments_list.cgi"));
	} 
	catch(e:Error)
	{
		// (may be badly formed URL or attempt to access out-of-domain resources)
		Alert.show("Error calling CGI: "+e.message);
	}
}

public function CGI_return(event:Event):void
{
	Alert.show(event.target.data);
}

public function RetrieveExperiment(url:String):void
{
	try 
	{
		var loader:URLLoader = new URLLoader();
		loader.addEventListener(Event.COMPLETE, ExperimentRetrievedFromURL);
		loader.load(new URLRequest(url));
	} 
	catch(e:Error)
	{
		// (may be badly formed URL or attempt to access out-of-domain resources)
		Alert.show("Error loading experiment: "+e.message);
	}
}

public function ExperimentRetrievedFromURL(event:Event):void
{	
	try
	{
		LoadExperiment(event.target.data);
	} 
	catch(e:Error)
	{
		Alert.show("Error loading experiment: " + e.message);
		return;
	}
}

public function LoadExperiment(contents:String):void
{
	// We would like to be able to apply an XML schema (XSD) here to ensure that the XML matches
	// our expectations. In the absence of this, we will have to manually check each item, and keep this code
	// synchronized with changes to the schema.
	
	var experiment:XML = new XML(contents); // (may throw if not well-formed xml)

	default xml namespace = "http://www.sq3.org.uk/Experiment";
	if(experiment.hasOwnProperty("about") && experiment.about.hasOwnProperty("username") &&
			experiment.about.hasOwnProperty("summary"))
		Alert.show("Experiment loaded.\n\nusername: "+experiment.about.username + "\n\nSummary: " + experiment.about.summary);
	else
		Alert.show("Experiment loaded. No description included.");
}

public function updateItCountLabel(event:ExperimentUpdateEvent):void
{
	itCountLabel.text = String(event.new_it_count);
}

/** fit the collisionsArea to the available screen area */
public function fitButtonClicked():void
{
	collisionsArea.x=0;
	collisionsArea.y=0;
	collisionsArea.scaleX = collisionsArea.scaleY = Math.min(collisionsPanel.width/collisionsArea.areaX,
			collisionsPanel.height/collisionsArea.areaY);
	zoomInButton.enabled = zoomOutButton.enabled = true;
}

public function startDragging(event:MouseEvent):void 
{
	// these events are heard from anywhere (unlike the MOUSE_DOWN for collisionsArea that got us here)
	// so it doesn't matter whether the mouse cursor is currently over the collisionsArea
	stage.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
	stage.addEventListener(MouseEvent.ROLL_OUT, stopDragging);
	stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoving);
	// save the mouse coords for comparison
	mouseGrabbed = new Point(event.stageX,event.stageY);
}

public function stopDragging(event:MouseEvent):void 
{
	stage.removeEventListener(MouseEvent.MOUSE_UP, stopDragging);
	stage.removeEventListener(MouseEvent.ROLL_OUT, stopDragging);
	stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoving);
	
	// we turn off the collisions area tooltip because the user has worked it out now and it's a bit annoying
	if(collisionsArea.toolTip!="") collisionsArea.toolTip="";
}

public function mouseMoving(event:MouseEvent):void 
{
	// move the area by the vector from the old to new mouse positions
	var p:Point = new Point(event.stageX,event.stageY);
	collisionsArea.x += p.x - mouseGrabbed.x;
	collisionsArea.y += p.y - mouseGrabbed.y;
	// and record the new mouse position for comparison with next time
	mouseGrabbed = p;
}

public function switchExperimentType():void
{
	collisionsArea.newExperiment();
}

public function localeChanged(event:Event):void
{
	resourceManager.localeChain = [event.currentTarget.selectedItem.data];
	invalidateDisplayList(); // some text controls need to be updated
}

public function startZoom(f:Number):void
{
	zoomSpeed = f;
	addEventListener(Event.ENTER_FRAME,OnZoom);
}

public function endZoom():void
{
	zoomSpeed = 1.0;
	removeEventListener(Event.ENTER_FRAME,OnZoom);
}

public function OnZoom(event:Event):void
{
	zoom(zoomSpeed);
}

public function testLevel():void 
{
	if(true)
	{
		testButton.enabled = false;
		nextLevelButton.enabled = true;
	}
}

public function nextLevel():void
{
	currentLevel++;
	levelPanel.title = "Level " + String(currentLevel);
	testButton.enabled = true;
	nextLevelButton.enabled = false;
}

public function playButtonClicked():void
{
	// hook the frame ticker up to our update function
	addEventListener(Event.ENTER_FRAME, collisionsArea.Update);

	// enable/disable the play+pause buttons
	playButton.enabled = false;
	pauseButton.enabled = true;
}

public function pauseButtonClicked():void
{
	// unhook the frame ticker from our update function
	removeEventListener(Event.ENTER_FRAME, collisionsArea.Update);

	// enable/disable the play+pause buttons
	playButton.enabled = true;
	pauseButton.enabled = false;
}

public function slowButtonClicked():void
{
	// set the speed to update only evey 1 frame tick
	collisionsArea.timesteps_per_frame=1;

	// enable/disable the slow/fast buttons
	slowButton.enabled = false;
	fastButton.enabled = true;
}

public function fastButtonClicked():void
{
	// set the speed to do more timesteps every frame tick
	collisionsArea.timesteps_per_frame=20;

	// enable/disable the slow/fast buttons
	slowButton.enabled = true;
	fastButton.enabled = false;
}

internal function zoom(f:Number):void
{
	// don't want to zoom in/out too far
	zoomInButton.enabled = (collisionsArea.scaleX * f < 2.0); // too big and bitmap caching becomes very slow
	zoomOutButton.enabled = (collisionsArea.scaleX * f > 1.0/16.0);

	// stop zooming if the button becomes disabled
	if( (zoomSpeed>1.0 && !zoomInButton.enabled) || (zoomSpeed<1.0 && !zoomOutButton.enabled) )
	{
		endZoom();
		return;
	}

	// we zoom from the centre of the viewport, so need to account for previous translation
	collisionsArea.x = (1.0 - f) * collisionsPanel.width / 2.0 + f * collisionsArea.x ;
	collisionsArea.y = (1.0 - f) * collisionsPanel.height / 2.0 + f * collisionsArea.y ;
	collisionsArea.scaleX *= f;
	collisionsArea.scaleY *= f;
}
