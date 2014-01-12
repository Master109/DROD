#pragma strict

var moveSpeed = 0.1;

function Start ()
{
	var vel : Vector3;
	vel = GameObject.Find("Player").transform.position - transform.position;
	vel = Vector3.ClampMagnitude(vel, moveSpeed);
	rigidbody.AddForce (vel);
}

function Update ()
{
	
}

function OnCollisionEnter(collision : Collision)
{
	if (collision.gameObject.name == "Player Graphics")
	{
		GameObject.Find("Player").GetComponent(PlayerBehavior2).hp --;
		Destroy(gameObject);
	}
	else if (collision.gameObject.name == "Roach")
	{
		if (!GameObject.Find("Player").GetComponent(SurvivalMode).scoreLocked)
			GameObject.Find("Player").GetComponent(SurvivalMode).score += 3;
		Destroy(gameObject);
	}
	else if (collision.gameObject.name == "Shooter")
	{
		if (!GameObject.Find("Player").GetComponent(SurvivalMode).scoreLocked)
			GameObject.Find("Player").GetComponent(SurvivalMode).score += 25;
		Destroy(gameObject);
	}
}