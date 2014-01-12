#pragma strict

var shootRate = 250;
var shootTimer = 0;
var bullet : GameObject;

function Start ()
{
	
}

function Update ()
{
	shootTimer ++;
	if (shootTimer >= shootRate)
	{
		var createLoc : Vector2;
		createLoc = Vector2(GameObject.Find("Player").transform.position.x - transform.position.x, GameObject.Find("Player").transform.position.z - transform.position.z);
		createLoc = Vector2.ClampMagnitude(createLoc, 5);
		Instantiate(bullet, Vector3(createLoc.x, 3, createLoc.y), Quaternion.identity);
		shootTimer = 0;
	}
}