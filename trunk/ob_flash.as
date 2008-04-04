// the main functions for the appliction

import flash.display.Stage;

private var currentLevel:Number = 1;

public function appInit():void
{
    resetTestMessage();

    // we start off with the atoms moving
    addEventListener(Event.ENTER_FRAME, collisionsArea.doTimeStep);
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
