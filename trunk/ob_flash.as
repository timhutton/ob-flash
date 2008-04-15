// the main functions for the appliction

import flash.display.Stage;

private var currentLevel:Number = 1;

public function appInit():void
{
    resetTestMessage();

    // we start off with the atoms moving
    addEventListener(Event.ENTER_FRAME, collisionsArea.doTimeStep);

    addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
}

public function OnMouseMove(e:MouseEvent):void
{
	if(moveUp.hitTestPoint(e.stageX,e.stageY)) moveUp.visible=true; else moveUp.visible=false;
	if(moveDown.hitTestPoint(e.stageX,e.stageY)) moveDown.visible=true; else moveDown.visible=false;
	if(moveLeft.hitTestPoint(e.stageX,e.stageY)) moveLeft.visible=true; else moveLeft.visible=false;
	if(moveRight.hitTestPoint(e.stageX,e.stageY)) moveRight.visible=true; else moveRight.visible=false;
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

public function ZoomIn():void
{
	collisionsArea.scaleX *= 2.0;
	collisionsArea.scaleY *= 2.0;
	collisionsArea.x /= 2.0;
	collisionsArea.y /= 2.0;
}

public function ZoomOut():void
{
	collisionsArea.scaleX /= 2.0;
	collisionsArea.scaleY /= 2.0;
	collisionsArea.x *= 2.0;
	collisionsArea.y *= 2.0;
}
