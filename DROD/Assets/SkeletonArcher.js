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
var go : GameObject;
var damage = 1;
var shootForce = 75;
var shouldMove = false;
var paused = true;
var loot : Component[];

function Start ()
{
}

function Update ()
{
	if (!awoken || paused || GameObject.Find("Player").GetComponent(PlayerBehavior).inPauseMenu || GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText || GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText2 || GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText3)
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
	if (vector != GameObject.Find("Player Graphics").transform.position || shouldMove)
	{
		if (transform.position.x - GameObject.Find("Player Graphics").transform.position.x > 0 && transform.position.z - GameObject.Find("Player Graphics").transform.position.z == 0 && Physics.Raycast (Vector3(transform.position.x - MOVE_DIST, 5, transform.position.z), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Player Graphics"))
			transform.position.x -= MOVE_DIST;
		else if (transform.position.x - GameObject.Find("Player Graphics").transform.position.x < 0 && transform.position.z - GameObject.Find("Player Graphics").transform.position.z == 0 && Physics.Raycast (Vector3(transform.position.x + MOVE_DIST, 5, transform.position.z), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Player Graphics"))
			transform.position.x += MOVE_DIST;
		else if (transform.position.z - GameObject.Find("Player Graphics").transform.position.z > 0 && transform.position.x - GameObject.Find("Player Graphics").transform.position.x == 0 && Physics.Raycast (Vector3(transform.position.x, 5, transform.position.z - MOVE_DIST), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Player Graphics"))
			transform.position.z -= MOVE_DIST;
		else if (transform.position.z - GameObject.Find("Player Graphics").transform.position.z < 0 && transform.position.x - GameObject.Find("Player Graphics").transform.position.x == 0 && Physics.Raycast (Vector3(transform.position.x, 5, transform.position.z + MOVE_DIST), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Player Graphics"))
			transform.position.z += MOVE_DIST;
		else if (transform.position.z - GameObject.Find("Player Graphics").transform.position.z < 0 && transform.position.x - GameObject.Find("Player Graphics").transform.position.x > 0 && Physics.Raycast (Vector3(transform.position.x - MOVE_DIST, 5, transform.position.z + MOVE_DIST), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Player Graphics"))
		{
			transform.position.z += MOVE_DIST;
			transform.position.x -= MOVE_DIST;
		}
		else if (transform.position.z - GameObject.Find("Player Graphics").transform.position.z < 0 && transform.position.x - GameObject.Find("Player Graphics").transform.position.x < 0 && Physics.Raycast (Vector3(transform.position.x + MOVE_DIST, 5, transform.position.z + MOVE_DIST), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Player Graphics"))
		{
			transform.position.z += MOVE_DIST;
			transform.position.x += MOVE_DIST;
		}
		else if (transform.position.z - GameObject.Find("Player Graphics").transform.position.z > 0 && transform.position.x - GameObject.Find("Player Graphics").transform.position.x < 0 && Physics.Raycast (Vector3(transform.position.x + MOVE_DIST, 5, transform.position.z - MOVE_DIST), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Player Graphics"))
		{
			transform.position.z -= MOVE_DIST;
			transform.position.x += MOVE_DIST;
		}
		else if (transform.position.z - GameObject.Find("Player Graphics").transform.position.z > 0 && transform.position.x - GameObject.Find("Player Graphics").transform.position.x > 0 && Physics.Raycast (Vector3(transform.position.x - MOVE_DIST, 5, transform.position.z - MOVE_DIST), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Player Graphics"))
		{
			transform.position.z -= MOVE_DIST;
			transform.position.x -= MOVE_DIST;
		}
		else if (transform.position.x - GameObject.Find("Player Graphics").transform.position.x > 0 && Physics.Raycast (Vector3(transform.position.x - MOVE_DIST, 5, transform.position.z), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Player Graphics"))
			transform.position.x -= MOVE_DIST;
		else if (transform.position.x - GameObject.Find("Player Graphics").transform.position.x < 0 && Physics.Raycast (Vector3(transform.position.x + MOVE_DIST, 5, transform.position.z), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Player Graphics"))
			transform.position.x += MOVE_DIST;
		else if (transform.position.z - GameObject.Find("Player Graphics").transform.position.z > 0 && Physics.Raycast (Vector3(transform.position.x, 5, transform.position.z - MOVE_DIST), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Player Graphics"))
			transform.position.z -= MOVE_DIST;
		else if (transform.position.z - GameObject.Find("Player Graphics").transform.position.z < 0 && Physics.Raycast (Vector3(transform.position.x, 5, transform.position.z + MOVE_DIST), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Player Graphics"))
			transform.position.z += MOVE_DIST;
		shouldMove = false;
		moveTimer = 0;
	}
	}
	shootTimer ++;
	if (shootTimer > shootRate)
	{
		var shouldMove2 = true;
		var vector2 = transform.position;
		if (transform.position.x - GameObject.Find("Player Graphics").transform.position.x > 0 && transform.position.z - GameObject.Find("Player Graphics").transform.position.z == 0)
		{
			vector2.x -= MOVE_DIST;if (vector2 == GameObject.Find("Player Graphics").transform.position)
			{
				go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go.GetComponent(Bullet).damage = damage;
				go.GetComponent(Bullet).vel = Vector3(-MOVE_DIST, 0, 0);
				go.GetComponent(Bullet).moveRate = shootForce; go.GetComponent(Bullet).extraRange = range - 1;
				go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;shouldMove2 = false; go.GetComponent(Bullet).shooter = gameObject;
			}
			else
			for (var i2 = 2; i2 <= range; i2 ++)
			{
			if (Physics.Raycast (Vector3(vector2.x, 5, vector2.z), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Player Sword" || hit.collider.gameObject.name == "Player Graphics"))
			{
			vector2.x -= MOVE_DIST;
			if (vector2 == GameObject.Find("Player Graphics").transform.position)
			{
				go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go.GetComponent(Bullet).damage = damage;
				go.GetComponent(Bullet).vel = Vector3(-MOVE_DIST, 0, 0);
				go.GetComponent(Bullet).moveRate = shootForce; go.GetComponent(Bullet).extraRange = range - i2;
				go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;shouldMove2 = false; go.GetComponent(Bullet).shooter = gameObject;
			}
			}
			}
				if (shouldMove2) shouldMove = true;
		}
		else if (transform.position.x - GameObject.Find("Player Graphics").transform.position.x < 0 && transform.position.z - GameObject.Find("Player Graphics").transform.position.z == 0)
		{
		vector2.x += MOVE_DIST;if (vector2 == GameObject.Find("Player Graphics").transform.position)
			{
				go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go.GetComponent(Bullet).damage = damage;
				go.GetComponent(Bullet).vel = Vector3(MOVE_DIST, 0, 0);
				go.GetComponent(Bullet).moveRate = shootForce; go.GetComponent(Bullet).extraRange = range - 1;
				go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;shouldMove2 = false; go.GetComponent(Bullet).shooter = gameObject;
			}
			else
		for (var i3 = 2; i3 <= range; i3 ++)
			{
			if (Physics.Raycast (Vector3(vector2.x, 5, vector2.z), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Player Sword" || hit.collider.gameObject.name == "Player Graphics"))
			{
			vector2.x += MOVE_DIST;
			if (vector2 == GameObject.Find("Player Graphics").transform.position)
			{
				go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go.GetComponent(Bullet).damage = damage;
				go.GetComponent(Bullet).vel = Vector3(MOVE_DIST, 0, 0);
				go.GetComponent(Bullet).moveRate = shootForce; go.GetComponent(Bullet).extraRange = range - i3;
				go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;shouldMove2 = false; go.GetComponent(Bullet).shooter = gameObject;
			}
			}
			}
				if (shouldMove2) shouldMove = true;
		}
		else if (transform.position.x - GameObject.Find("Player Graphics").transform.position.x == 0 && transform.position.z - GameObject.Find("Player Graphics").transform.position.z > 0)
		{
		vector2.z -= MOVE_DIST;if (vector2 == GameObject.Find("Player Graphics").transform.position)
			{
				go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go.GetComponent(Bullet).damage = damage;
				go.GetComponent(Bullet).vel = Vector3(0, 0, -MOVE_DIST);
				go.GetComponent(Bullet).moveRate = shootForce; go.GetComponent(Bullet).extraRange = range - 1;
				go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;shouldMove2 = false; go.GetComponent(Bullet).shooter = gameObject;
			}
			else
		for (var i4 = 2; i4 <= range; i4 ++)
			{
			if (Physics.Raycast (Vector3(vector2.x, 5, vector2.z), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Player Sword" || hit.collider.gameObject.name == "Player Graphics"))
			{
			vector2.z -= MOVE_DIST;
			if (vector2 == GameObject.Find("Player Graphics").transform.position)
			{
				go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go.GetComponent(Bullet).damage = damage;
				go.GetComponent(Bullet).vel = Vector3(0, 0, -MOVE_DIST);
				go.GetComponent(Bullet).moveRate = shootForce; go.GetComponent(Bullet).extraRange = range - i4;
				go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;shouldMove2 = false; go.GetComponent(Bullet).shooter = gameObject;
			}
			}
			}
				if (shouldMove2) shouldMove = true;
		}
		else if (transform.position.x - GameObject.Find("Player Graphics").transform.position.x == 0 && transform.position.z - GameObject.Find("Player Graphics").transform.position.z < 0)
		{
			vector2.z += MOVE_DIST;if (vector2 == GameObject.Find("Player Graphics").transform.position)
			{
				go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go.GetComponent(Bullet).damage = damage;
				go.GetComponent(Bullet).vel = Vector3(0, 0, MOVE_DIST);
				go.GetComponent(Bullet).moveRate = shootForce; go.GetComponent(Bullet).extraRange = range - 1;
				go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;shouldMove2 = false; go.GetComponent(Bullet).shooter = gameObject;
			}
			else
		for (var i5 = 2; i5 <= range; i5 ++)
			{
			if (Physics.Raycast (Vector3(vector2.x, 5, vector2.z), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Player Sword" || hit.collider.gameObject.name == "Player Graphics"))
			{
			vector2.z += MOVE_DIST;
			if (vector2 == GameObject.Find("Player Graphics").transform.position)
			{
				go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go.GetComponent(Bullet).damage = damage;
				go.GetComponent(Bullet).vel = Vector3(0, 0, MOVE_DIST);
				go.GetComponent(Bullet).moveRate = shootForce; go.GetComponent(Bullet).extraRange = range - i5;
				go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;shouldMove2 = false; go.GetComponent(Bullet).shooter = gameObject;
			}
			}
			}
				if (shouldMove2) shouldMove = true;
		}
		else if (transform.position.x - GameObject.Find("Player Graphics").transform.position.x > 0 && transform.position.z - GameObject.Find("Player Graphics").transform.position.z > 0)
		{
		vector2.x -= MOVE_DIST;
			vector2.z -= MOVE_DIST;if (vector2 == GameObject.Find("Player Graphics").transform.position)
			{
				go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go.GetComponent(Bullet).damage = damage;
				go.GetComponent(Bullet).vel = Vector3(-MOVE_DIST, 0, -MOVE_DIST);
				go.GetComponent(Bullet).moveRate = shootForce; go.GetComponent(Bullet).extraRange = range - 1;
				go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;
				shouldMove2 = false; go.GetComponent(Bullet).shooter = gameObject;
			}
			else
		for (var i9 = 2; i9 <= range; i9 ++)
			{
			if (Physics.Raycast (Vector3(vector2.x, 5, vector2.z), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy")
			{
			vector2.x -= MOVE_DIST;
			vector2.z -= MOVE_DIST;
			if (vector2 == GameObject.Find("Player Graphics").transform.position)
			{
				go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go.GetComponent(Bullet).damage = damage;
				go.GetComponent(Bullet).vel = Vector3(-MOVE_DIST, 0, -MOVE_DIST);
				go.GetComponent(Bullet).moveRate = shootForce; go.GetComponent(Bullet).extraRange = range - i9;
				go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;
				shouldMove2 = false; go.GetComponent(Bullet).shooter = gameObject;
			}
			}
			}
				if (shouldMove2) shouldMove = true;
		}
		else if (transform.position.x - GameObject.Find("Player Graphics").transform.position.x < 0 && transform.position.z - GameObject.Find("Player Graphics").transform.position.z > 0)
		{
		vector2.x += MOVE_DIST;
			vector2.z -= MOVE_DIST;if (vector2 == GameObject.Find("Player Graphics").transform.position)
			{
				go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go.GetComponent(Bullet).damage = damage;
				go.GetComponent(Bullet).vel = Vector3(MOVE_DIST, 0, -MOVE_DIST);
				go.GetComponent(Bullet).moveRate = shootForce; go.GetComponent(Bullet).extraRange = range - 1;
				go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;shouldMove2 = false; go.GetComponent(Bullet).shooter = gameObject;
			}
			else
		for (var i6 = 2; i6 <= range; i6 ++)
			{
			if (Physics.Raycast (Vector3(vector2.x, 5, vector2.z), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Player Sword" || hit.collider.gameObject.name == "Player Graphics"))
			{
			vector2.x += MOVE_DIST;
			vector2.z -= MOVE_DIST;
			if (vector2 == GameObject.Find("Player Graphics").transform.position)
			{
				go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go.GetComponent(Bullet).damage = damage;
				go.GetComponent(Bullet).vel = Vector3(MOVE_DIST, 0, -MOVE_DIST);
				go.GetComponent(Bullet).moveRate = shootForce; go.GetComponent(Bullet).extraRange = range - i6;
				go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;shouldMove2 = false; go.GetComponent(Bullet).shooter = gameObject;
			}
			}
			}
				if (shouldMove2) shouldMove = true;
		}
		else if (transform.position.x - GameObject.Find("Player Graphics").transform.position.x < 0 && transform.position.z - GameObject.Find("Player Graphics").transform.position.z < 0)
		{
		vector2.x += MOVE_DIST;
			vector2.z += MOVE_DIST;if (vector2 == GameObject.Find("Player Graphics").transform.position)
			{
				go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go.GetComponent(Bullet).damage = damage;
				go.GetComponent(Bullet).vel = Vector3(MOVE_DIST, 0, MOVE_DIST);
				go.GetComponent(Bullet).moveRate = shootForce; go.GetComponent(Bullet).extraRange = range - 1;
				go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;shouldMove2 = false; go.GetComponent(Bullet).shooter = gameObject;
			}
			else
		for (var i7 = 2; i7 <= range; i7 ++)
			{
			if (Physics.Raycast (Vector3(vector2.x, 5, vector2.z), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Player Sword" || hit.collider.gameObject.name == "Player Graphics"))
			{
			vector2.x += MOVE_DIST;
			vector2.z += MOVE_DIST;
			if (vector2 == GameObject.Find("Player Graphics").transform.position)
			{
				go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go.GetComponent(Bullet).damage = damage;
				go.GetComponent(Bullet).vel = Vector3(MOVE_DIST, 0, MOVE_DIST);
				go.GetComponent(Bullet).moveRate = shootForce; go.GetComponent(Bullet).extraRange = range - i7;
				go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;shouldMove2 = false; go.GetComponent(Bullet).shooter = gameObject;
			}
			}
			}
				if (shouldMove2) shouldMove = true;
		}
		else if (transform.position.x - GameObject.Find("Player Graphics").transform.position.x > 0 && transform.position.z - GameObject.Find("Player Graphics").transform.position.z < 0)
		{
		vector2.x -= MOVE_DIST;
			vector2.z += MOVE_DIST;
			if (vector2 == GameObject.Find("Player Graphics").transform.position)
			{
				go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go.GetComponent(Bullet).damage = damage;
				go.GetComponent(Bullet).vel = Vector3(-MOVE_DIST, 0, MOVE_DIST);
				go.GetComponent(Bullet).moveRate = shootForce; go.GetComponent(Bullet).extraRange = range - 1;
				go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;shouldMove2 = false; go.GetComponent(Bullet).shooter = gameObject;
			}
			else
		for (var i8 = 2; i8 <= range; i8 ++)
			{
			if (Physics.Raycast (Vector3(vector2.x, 5, vector2.z), Vector3.down, hit, 10) && hit.collider.gameObject.tag != "Enemy" && (hit.collider.gameObject.name == "Player Sword" || hit.collider.gameObject.name == "Player Graphics"))
			{
			vector2.x -= MOVE_DIST;
			vector2.z += MOVE_DIST;
			if (vector2 == GameObject.Find("Player Graphics").transform.position)
			{
				go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
				go.GetComponent(Bullet).damage = damage;
				go.GetComponent(Bullet).vel = Vector3(-MOVE_DIST, 0, MOVE_DIST);
				go.GetComponent(Bullet).moveRate = shootForce; go.GetComponent(Bullet).extraRange = range - i8;
				go.GetComponent(Bullet).destination = GameObject.Find("Player Graphics").transform.position;
				shootTimer = 0;shouldMove2 = false; go.GetComponent(Bullet).shooter = gameObject;
			}
				}
				}
				if (shouldMove2) shouldMove = true;
				}
				}
				}
		
function CheckForPlayer ()
{
	if (paused)
		return;
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
	if (paused || GameObject.Find("Player").GetComponent(PlayerBehavior).inPauseMenu || GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText || GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText2 || GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText3)
		return;
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
		{
			Destroy(gameObject);
			for (var i = 0; i < loot.length; i ++)
			{
				if (loot[i].name == "Bow")
				{
					if (GameObject.Find("Player Graphics").GetComponent(Bow) == null)
					{
						GameObject.Find("Player Graphics").AddComponent(Bow);
						GameObject.Find("Player Graphics").GetComponent(Bow).bullet = GameObject.Find("Bow").GetComponent(Bow).bullet;
						GameObject.Find("Player Graphics").GetComponent(Bow).arrows += transform.GetChild(1).gameObject.GetComponent(Bow).arrows;
						if (GameObject.Find("Player").GetComponent(PlayerBehavior).firstBow)
							GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText = true;
						GameObject.Find("Player").GetComponent(PlayerBehavior).firstBow = false;
					}
					else
						GameObject.Find("Player Graphics").GetComponent(Bow).arrows += transform.GetChild(1).gameObject.GetComponent(Bow).arrows;
				}
			}
		}
	}
}

function OnTriggerExit (other : Collider)
{
	if (paused || GameObject.Find("Player").GetComponent(PlayerBehavior).inPauseMenu || GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText || GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText2 || GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText3)
		return;
	if (other.gameObject.name == "Player Graphics")
		attackTimer = attackRate;
	else if (other.gameObject.name == "Player Sword")
		playerAttackTimer = playerAttackRate;
}