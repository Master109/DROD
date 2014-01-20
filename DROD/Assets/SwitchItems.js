#pragma strict

var shouldUseSword1 = true;
var shouldUseSword2 = true;

function Start ()
{
	
}

function Update ()
{
	if (Input.GetAxis("Sword") == 1)
		shouldUseSword1 = true;
	else if (Input.GetAxis("Ranged") == 1)
	{
		GameObject.Find("Player Sword").collider.enabled = false;
		GameObject.Find("Player Sword").renderer.enabled = false;
	}
	if (shouldUseSword1 && shouldUseSword2 && (GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText3 || GameObject.Find("Player").GetComponent(PlayerBehavior).bowTextOver))
	{
		GameObject.Find("Player Sword").collider.enabled = true;
		GameObject.Find("Player Sword").renderer.enabled = true;
		shouldUseSword1 = false;
		shouldUseSword2 = false;
		GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText3 = false;
		GameObject.Find("Player").GetComponent(PlayerBehavior).bowTextOver = true;
	}
}