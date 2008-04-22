// the main functions for the appliction

import flash.display.Stage;
import obClasses.*;

private var currentLevel:Number = 1;

public var panVelocity:Point = new Point(0,0);
public var zoomSpeed:Number = 0.0;

public function appInit():void
{
	resetTestMessage();

	// we start off with the atoms moving
	addEventListener(Event.ENTER_FRAME, collisionsArea.doTimeStep);

	updatePanButtons();
}

public function switchExperimentType():void
{
	collisionsArea.newExperiment();
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

public function startPan(x:Number,y:Number):void
{
	panVelocity = new Point(x,y);
	addEventListener(Event.ENTER_FRAME,pan);
}

public function endPan():void
{
	panVelocity = new Point(0,0);
	removeEventListener(Event.ENTER_FRAME,pan);
}

internal function pan(event:Event):void
{
	collisionsArea.x += panVelocity.x;
	collisionsArea.y += panVelocity.y;
	updatePanButtons();
}

public function updatePanButtons():void
{
	// show the left/right/up/down buttons only when there is more to see in that direction
	moveLeft.visible = (collisionsArea.x<0);
	moveRight.visible = (collisionsArea.x+collisionsArea.areaX*collisionsArea.scaleX > collisionsPanel.width);
	moveUp.visible = (collisionsArea.y<0);
	moveDown.visible = (collisionsArea.y+collisionsArea.areaY*collisionsArea.scaleX > collisionsPanel.height);

	// stop panning if we move off the edge
	if(!moveLeft.visible && panVelocity.x>0) endPan();
	if(!moveRight.visible && panVelocity.x<0) endPan();
	if(!moveUp.visible && panVelocity.y>0) endPan();
	if(!moveDown.visible && panVelocity.y<0) endPan();
}

public function testLevel():void 
{
	if(true)
	{
		testMessage.text = "Test passed! You can now proceed to the next level.";
		testButton.enabled = false;
		nextLevelButton.enabled = true;
	}
	else
	{
		testMessage.text = "Test not yet passed. Please keep trying.";
	}
}

public function nextLevel():void
{
	currentLevel++;
	levelPanel.title = "Level " + String(currentLevel);
	testButton.enabled = true;
	nextLevelButton.enabled = false;
	resetTestMessage();
}

private function resetTestMessage():void
{
	testMessage.text = "Add chemical reactions using the editor below. Hit the test button when you have completed the task.";
}

public function playButtonClicked():void
{
	// hook the frame ticker up to our update function
	addEventListener(Event.ENTER_FRAME, collisionsArea.doTimeStep);
	// enable/disable the play+pause buttons
	playButton.enabled = false;
	pauseButton.enabled = true;
}

public function pauseButtonClicked():void
{
	// unhook the frame ticker from our update function
	removeEventListener(Event.ENTER_FRAME, collisionsArea.doTimeStep);
	// enable/disable the play+pause buttons
	playButton.enabled = true;
	pauseButton.enabled = false;
}

public function slowButtonClicked():void
{
	// set the speed to update only evey 4 frame ticks
	collisionsArea.running_delay=4;
	// enable/disable the slow/fast buttons
	slowButton.enabled = false;
	fastButton.enabled = true;
}

public function fastButtonClicked():void
{
	// set the speed to update every frame tick
	collisionsArea.running_delay=0;

	// enable/disable the slow/fast buttons
	slowButton.enabled = true;
	fastButton.enabled = false;
}

internal function zoom(f:Number):void
{
	const new_scale:Number = collisionsArea.scaleX * f;  // (we keep scaleY == scaleX)

	// don't want to zoom in/out too far
	zoomInButton.enabled = (new_scale < 16.0);
	zoomOutButton.enabled = (new_scale > 1.0/16.0);

	// stop zooming if the button becomes disabled
	if(zoomSpeed>1.0 && !zoomInButton.enabled) endZoom();
	if(zoomSpeed<1.0 && !zoomOutButton.enabled) endZoom();

	if(zoomSpeed==1.0) return; // stopped zooming

	invalidateDisplayList(); // try to delay redraw until we're finished

	collisionsArea.scaleX = collisionsArea.scaleY = new_scale;

	// we zoom from the centre of the viewport, so need to account for previous scale and translation
	const p:Point = new Point(collisionsPanel.width/2,collisionsPanel.height/2);
	collisionsArea.x = p.x - f * ( p.x - collisionsArea.x );
	collisionsArea.y = p.y - f * ( p.y - collisionsArea.y );

	// may need to make those pan buttons (in)visible now
	updatePanButtons();
}
