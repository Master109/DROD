#pragma strict

var moveSpeed = 0.1;

function Start ()
{

}

function Update ()
{
	var vel = GameObject.Find("Player").transform.position - transform.position;
	vel = Vector3.ClampMagnitude(vel, moveSpeed);
	transform.position += vel;
}

function OnCollisionEnter(collision : Collision)
{
	if (collision.gameObject.name == "Player Graphics")
	{
		GameObject.Find("Player").GetComponent(PlayerBehavior2).hp --;
		Destroy(gameObject);
	}
	else if (collision.gameObject.name == "Sword")
	{
		if (!GameObject.Find("Player").GetComponent(SurvivalMode).scoreLocked)
			GameObject.Find("Player").GetComponent(SurvivalMode).score += 3;
		Destroy(gameObject);
	}
}