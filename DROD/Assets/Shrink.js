#pragma strict

var shrinkRate = .001;
var delayDeadline = 0;
var delayTimer = 0;

function Start ()
{
	
}

function Update ()
{
	if (GameObject.Find("Player").GetComponent(PlayerBehavior).inPauseMenu)
		return;
	delayTimer ++;
	if (delayTimer > delayDeadline && transform.lossyScale.x > 0)
	{
		transform.localScale.x -= shrinkRate;
		transform.localScale.y -= shrinkRate;
		transform.localScale.z -= shrinkRate;
	}
}