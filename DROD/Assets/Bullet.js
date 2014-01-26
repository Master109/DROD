#pragma strict

var MOVE_DIST = 6;
var moveTimer = 0;
var moveRate = 30;
var vel : Vector3;
var damage = 1;
var destination : Vector3;
var extraRange = 0;
var shooter : GameObject;
var paused = false;

function Start ()
{
	
}

function Update ()
{
	if (paused || GameObject.Find("Player").GetComponent(PlayerBehavior).inPauseMenu || GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText || GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText2 || GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText3)
		return;
	moveTimer ++;
	if (moveTimer > moveRate)
	{
		transform.position += vel;
		moveTimer = 0;
		if (transform.position == destination + vel + (vel * extraRange))
			Destroy(gameObject);
	}
}

function OnTriggerStay (other : Collider)
{
	if (other.gameObject != shooter)
	{
	if (other.gameObject.name == "Player Graphics")
	{
		Destroy(gameObject);
		other.transform.parent.gameObject.GetComponent(PlayerBehavior).hp -= damage;
	}
	else if (other.gameObject.tag == "Enemy")
	{
		Destroy(gameObject);
		if (other.gameObject.name == "Roach")
		{
			other.gameObject.GetComponent(RoachBehavior).hp -= damage;
			if (other.gameObject.GetComponent(RoachBehavior).hp <= 0)
				Destroy(other.gameObject);
		}
		else if (other.gameObject.name == "SkeletonArcher")
		{
			other.gameObject.GetComponent(SkeletonArcher).hp -= damage;
			if (other.gameObject.GetComponent(SkeletonArcher).hp <= 0)
				Destroy(other.gameObject);
		}
	}
	}
}