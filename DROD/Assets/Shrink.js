#pragma strict

var shrinkRate = .001;
var delayDeadline = 0;
var delayTimer = 0;

function Start ()
{
	
}

function Update ()
{
	delayTimer ++;
	if (delayTimer > delayDeadline)
	{
		transform.localScale.x -= shrinkRate;
		transform.localScale.y -= shrinkRate;
		transform.localScale.z -= shrinkRate;
		if (transform.lossyScale.x <= 0)
			gameObject.active = false;
	}
}