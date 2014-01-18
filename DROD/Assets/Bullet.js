#pragma strict

var MOVE_DIST = 6;
var moveTimer = 0;
var moveRate = 30;
var vel : Vector3;
var damage = 1;
var destination : Vector3;

function Start ()
{
	
}

function Update ()
{
	moveTimer ++;
	if (moveTimer > moveRate)
	{
		transform.position += vel;
		moveTimer = 0;
		if (transform.position == destination)
			Destroy(gameObject);
	}
}

function OnTriggerStay (other : Collider)
{
	if (other.gameObject.name == "Player Graphics")
	{
		Destroy(gameObject);
		other.transform.parent.gameObject.GetComponent(PlayerBehavior).hp -= damage;
	}
	else if (other.gameObject.name == "Roach")
	{
		Destroy(gameObject);
		other.gameObject.GetComponent(RoachBehavior).hp -= damage;
	}
}