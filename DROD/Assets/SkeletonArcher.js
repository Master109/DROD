#pragma strict

var hp = 1;
var MOVE_DIST = 6;
var moveTimer = 0;
var moveRate = 30;
var attackTimer = -1;
var attackRate = -1;
var playerAttackTimer = 100;
var playerAttackRate = 100;
var awoken = false;
var awakeRadius = 7;
var hit : RaycastHit;
var shootRate = 350;
var shootTimer = 0;
var range = 5;
var bullet : GameObject;
var damage = 1;
var shootForce = 75;

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
		var vector = transform.position;
	for (var i = 0; i <= range; i ++)
	{
		if (vector.x - GameObject.Find("Player Graphics").transform.position.x > 0)
			vector.x -= MOVE_DIST;
		else if (vector.x - GameObject.Find("Player Graphics").transform.position.x < 0)
			vector.x += MOVE_DIST;
		if (vector.z - GameObject.Find("Player Graphics").transform.position.z > 0)
			vector.z -= MOVE_DIST;
		else if (vector.z - GameObject.Find("Player Graphics").transform.position.z < 0)
			vector.z += MOVE_DIST;
	}
	if (vector.x != GameObject.Find("Player Graphics").transform.position.x && vector.z != GameObject.Find("Player Graphics").transform.position.z)
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
	shootTimer ++;
	if (shootTimer > shootRate)
	{
		var vector2 = transform.position;
		if (transform.position.x - GameObject.Find("Player Graphics").transform.position.x > 0 && transform.position.z - GameObject.Find("Player Graphics").transform.position.z == 0 && Physics.Raycast (Vector3(vector2.x, 5, vector2.z), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Cube" || hit.collider.gameObject.name == "Player Graphics"))
		{
			for (var i2 = 0; i2 <= range; i2 ++)
			{
			vector2.x -= MOVE_DIST;
			if (vector2.x == GameObject.Find("Player Graphics").transform.position.x && vector2.z == GameObject.Find("Player Graphics").transform.position.z)
			{
				var go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go.GetComponent(Bullet).damage = damage;
				go.GetComponent(Bullet).vel = Vector3(-MOVE_DIST, 0, 0);
				go.GetComponent(Bullet).moveRate = shootForce;
				go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;Update();
			}
			}
		}
		else if (transform.position.x - GameObject.Find("Player Graphics").transform.position.x < 0 && transform.position.z - GameObject.Find("Player Graphics").transform.position.z == 0 && Physics.Raycast (Vector3(vector2.x, 5, vector2.z), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Cube" || hit.collider.gameObject.name == "Player Graphics"))
		{for (var i3 = 0; i3 <= range; i3 ++)
			{
			vector2.x += MOVE_DIST;
			if (vector2.x == GameObject.Find("Player Graphics").transform.position.x && vector2.z == GameObject.Find("Player Graphics").transform.position.z)
			{
				var go3 = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go3.GetComponent(Bullet).damage = damage;
				go3.GetComponent(Bullet).vel = Vector3(MOVE_DIST, 0, 0);
				go3.GetComponent(Bullet).moveRate = shootForce;go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;Update();
			}
			}
		}
		else if (transform.position.x - GameObject.Find("Player Graphics").transform.position.x == 0 && transform.position.z - GameObject.Find("Player Graphics").transform.position.z > 0 && Physics.Raycast (Vector3(vector2.x, 5, vector2.z), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Cube" || hit.collider.gameObject.name == "Player Graphics"))
		{for (var i4 = 0; i4 <= range; i4 ++)
			{
			vector2.z -= MOVE_DIST;
			if (vector2.x == GameObject.Find("Player Graphics").transform.position.x && vector2.z == GameObject.Find("Player Graphics").transform.position.z)
			{
				var go4 = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go4.GetComponent(Bullet).damage = damage;
				go4.GetComponent(Bullet).vel = Vector3(0, 0, -MOVE_DIST);
				go4.GetComponent(Bullet).moveRate = shootForce;go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;Update();
			}
			}
		}
		else if (transform.position.x - GameObject.Find("Player Graphics").transform.position.x == 0 && transform.position.z - GameObject.Find("Player Graphics").transform.position.z < 0 && Physics.Raycast (Vector3(vector2.x, 5, vector2.z), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Cube" || hit.collider.gameObject.name == "Player Graphics"))
		{for (var i5 = 0; i5 <= range; i5 ++)
			{
			vector2.z += MOVE_DIST;
			if (vector2.x == GameObject.Find("Player Graphics").transform.position.x && vector2.z == GameObject.Find("Player Graphics").transform.position.z)
			{
				var go5 = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go5.GetComponent(Bullet).damage = damage;
				go5.GetComponent(Bullet).vel = Vector3(0, 0, MOVE_DIST);
				go5.GetComponent(Bullet).moveRate = shootForce;go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;Update();
			}
			}
		}
		else if (transform.position.x - GameObject.Find("Player Graphics").transform.position.x > 0 && transform.position.z - GameObject.Find("Player Graphics").transform.position.z > 0 && Physics.Raycast (Vector3(vector2.x, 5, vector2.z), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Cube" || hit.collider.gameObject.name == "Player Graphics"))
		{for (var i9 = 0; i9 <= range; i9 ++)
			{
			vector2.x -= MOVE_DIST;
			vector2.z -= MOVE_DIST;
			if (vector2.x == GameObject.Find("Player Graphics").transform.position.x && vector2.z == GameObject.Find("Player Graphics").transform.position.z)
			{
				var go6 = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go6.GetComponent(Bullet).damage = damage;
				go6.GetComponent(Bullet).vel = Vector3(-MOVE_DIST, 0, -MOVE_DIST);
				go6.GetComponent(Bullet).moveRate = shootForce;go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;Update();
			}
			}
		}
		else if (transform.position.x - GameObject.Find("Player Graphics").transform.position.x < 0 && transform.position.z - GameObject.Find("Player Graphics").transform.position.z > 0 && Physics.Raycast (Vector3(vector2.x, 5, vector2.z), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Cube" || hit.collider.gameObject.name == "Player Graphics"))
		{for (var i6 = 0; i6 <= range; i6 ++)
			{
			vector2.x += MOVE_DIST;
			vector2.z -= MOVE_DIST;
			if (vector2.x == GameObject.Find("Player Graphics").transform.position.x && vector2.z == GameObject.Find("Player Graphics").transform.position.z)
			{
				var go7 = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go7.GetComponent(Bullet).damage = damage;
				go7.GetComponent(Bullet).vel = Vector3(MOVE_DIST, 0, -MOVE_DIST);
				go7.GetComponent(Bullet).moveRate = shootForce;go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;Update();
			}
			}
		}
		else if (transform.position.x - GameObject.Find("Player Graphics").transform.position.x < 0 && transform.position.z - GameObject.Find("Player Graphics").transform.position.z < 0 && Physics.Raycast (Vector3(vector2.x, 5, vector2.z), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Cube" || hit.collider.gameObject.name == "Player Graphics"))
		{for (var i7 = 0; i7 <= range; i7 ++)
			{
			vector2.x += MOVE_DIST;
			vector2.z += MOVE_DIST;
			if (vector2.x == GameObject.Find("Player Graphics").transform.position.x && vector2.z == GameObject.Find("Player Graphics").transform.position.z)
			{
				var go8 = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go8.GetComponent(Bullet).damage = damage;
				go8.GetComponent(Bullet).vel = Vector3(MOVE_DIST, 0, MOVE_DIST);
				go8.GetComponent(Bullet).moveRate = shootForce;go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;Update();
			}
			}
		}
		else if (transform.position.x - GameObject.Find("Player Graphics").transform.position.x > 0 && transform.position.z - GameObject.Find("Player Graphics").transform.position.z < 0 && Physics.Raycast (Vector3(vector2.x, 5, vector2.z), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Cube" || hit.collider.gameObject.name == "Player Graphics"))
		{for (var i8 = 0; i8 <= range; i8 ++)
			{
			vector2.x -= MOVE_DIST;
			vector2.z += MOVE_DIST;
			if (vector2.x == GameObject.Find("Player Graphics").transform.position.x && vector2.z == GameObject.Find("Player Graphics").transform.position.z)
			{
				var go2 = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go2.GetComponent(Bullet).damage = damage;
				go2.GetComponent(Bullet).vel = Vector3(-MOVE_DIST, 0, MOVE_DIST);
				go2.GetComponent(Bullet).moveRate = shootForce;
				go2.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;Update();
			}
				}
				}
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
	if (other.gameObject.name == "Player Graphics" && attackTimer > attackRate && attackRate != -1)
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