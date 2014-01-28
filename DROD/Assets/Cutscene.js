#pragma strict

var actions : String[];
var keyFrames : float[];
var timeMultiplier = 10;
var frame = 0;
var currentAction = 0;
var CONSECUTIVE_ACTION_MAX = 2;
var MOVE_DIST = 6;

function Start ()
{
	
}

function FixedUpdate ()
{
	for (var i = 0; i <= CONSECUTIVE_ACTION_MAX; i ++)
		if (frame >= keyFrames[currentAction] * timeMultiplier && keyFrames[currentAction] != null)
		{
			if (actions[currentAction] == "up")
				transform.position.z += MOVE_DIST;
			else if (actions[currentAction] == "down")
				transform.position.z -= MOVE_DIST;
			else if (actions[currentAction] == "right")
				transform.position.x += MOVE_DIST;
			else if (actions[currentAction] == "left")
				transform.position.x -= MOVE_DIST;
			else if (actions[currentAction] == "sheath")
				GameObject.Find("Player Sword").active = false;
			currentAction ++;
		}
	frame ++;
}