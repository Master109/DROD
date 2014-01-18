#pragma strict

var hp = 1;
var MOVE_DIST = 6;
var moveTimer = 0;
var moveRate = 30;
var attackTimer = 125;
var attackRate = 125;
var playerAttackTimer = 100;
var playerAttackRate = 100;
var awoken = false;
var awakeRadius = 5;
var hit : RaycastHit;

function Start ()
{
	
}

function Update ()
{
	if (!awoken)
		return;
	moveTimer ++;
	if (moveTimer > moveRate)
	{
		if (transform.position.x - GameObject.Find("Player Graphics").transform.position.x > 0 && Physics.Raycast (Vector3(transform.position.x - MOVE_DIST, 5, transform.position.z), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Cube" || hit.collider.gameObject.name == "Player Graphics"))
			transform.position.x -= MOVE_DIST;
		else if (transform.position.x - GameObject.Find("Player Graphics").transform.position.x < 0 && Physics.Raycast (Vector3(transform.position.x + MOVE_DIST, 5, transform.position.z), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Cube" || hit.collider.gameObject.name == "Player Graphics"))
			transform.position.x += MOVE_DIST;
		if (transform.position.z - GameObject.Find("Player Graphics").transform.position.z > 0 && Physics.Raycast (Vector3(transform.position.x, 5, transform.position.z - MOVE_DIST), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Cube" || hit.collider.gameObject.name == "Player Graphics"))
			transform.position.z -= MOVE_DIST;
		else if (transform.position.z - GameObject.Find("Player Graphics").transform.position.z < 0 && Physics.Raycast (Vector3(transform.position.x, 5, transform.position.z + MOVE_DIST), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Cube" || hit.collider.gameObject.name == "Player Graphics"))
			transform.position.z += MOVE_DIST;
		moveTimer = 0;
	}
}

function CheckForPlayer ()
{
	var vector = transform.position;
	for (var i = 0; i < awakeRadius; i ++)
	{
		if (vector.x - GameObject.Find("Player Graphics").transform.position.x > 0)
		{
			vector.x -= MOVE_DIST;
			if (vector.x == GameObject.Find("Player Graphics").transform.position.x && vector.z == GameObject.Find("Player Graphics").transform.position.z)
				awoken = true;
			Update();
		}
		else if (vector.x - GameObject.Find("Player Graphics").transform.position.x < 0)
		{
			vector.x += MOVE_DIST;
			if (vector.x == GameObject.Find("Player Graphics").transform.position.x && vector.z == GameObject.Find("Player Graphics").transform.position.z)
				awoken = true;
			Update();
		}
		if (vector.z - GameObject.Find("Player Graphics").transform.position.z > 0)
		{
			vector.z -= MOVE_DIST;
			if (vector.x == GameObject.Find("Player Graphics").transform.position.x && vector.z == GameObject.Find("Player Graphics").transform.position.z)
				awoken = true;
			Update();
		}
		else if (vector.z - GameObject.Find("Player Graphics").transform.position.z < 0)
		{
			vector.z += MOVE_DIST;
			if (vector.x == GameObject.Find("Player Graphics").transform.position.x && vector.z == GameObject.Find("Player Graphics").transform.position.z)
				awoken = true;
			Update();
		}
	}
}

function OnTriggerStay (other : Collider)
{
	attackTimer ++;
	playerAttackTimer ++;
	if (other.gameObject.name == "Player Graphics" && attackTimer > attackRate)
	{
		attackTimer = 0;
		GameObject.Find("Player").GetComponent(PlayerBehavior).hp --;
		if (GameObject.Find("Player").GetComponent(PlayerBehavior).hp <= 0)
			Application.LoadLevel(0);
	}
	else if (other.gameObject.name == "Player Sword" && playerAttackTimer > playerAttackRate)
	{
		playerAttackTimer = 0;
		hp --;
		if (hp <= 0)
			Destroy(gameObject);
	}
}

function OnTriggerExit (other : Collider)
{
	if (other.gameObject.name == "Player Graphics")
		attackTimer = attackRate;
	else if (other.gameObject.name == "Player Sword")
		playerAttackTimer = playerAttackRate;
}