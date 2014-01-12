#pragma strict

var hp = 3;
var MOVE_DIST = 6;
var moveTimer = 0;
var moveRate = 30;
var hit : RaycastHit;
var guiSkin : GUISkin;

function Start ()
{
	
}

function Update ()
{
	moveTimer ++;
	if (Input.GetAxis("Horizontal") == 1 && moveTimer > moveRate && Physics.Raycast (Vector3(transform.position.x + MOVE_DIST, 5, transform.position.z), Vector3.down, hit, 100.0, 1) && hit.collider != null)
	{
		transform.position.x += MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.x += MOVE_DIST;
		moveTimer = 0;
	}
	else if (Input.GetAxis("Horizontal") == -1 && moveTimer > moveRate && Physics.Raycast (Vector3(transform.position.x - MOVE_DIST, 5, transform.position.z), Vector3.down, hit, 100.0, 1) && hit.collider != null)
	{
		transform.position.x -= MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.x -= MOVE_DIST;
		moveTimer = 0;
	}
	if (Input.GetAxis("Vertical") == 1 && moveTimer > moveRate && Physics.Raycast (Vector3(transform.position.x, 5, transform.position.z + MOVE_DIST), Vector3.down, hit, 100.0, 1) && hit.collider != null)
	{
		transform.position.z += MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.z += MOVE_DIST;
		moveTimer = 0;
	}
	else if (Input.GetAxis("Vertical") == -1 && moveTimer > moveRate && Physics.Raycast (Vector3(transform.position.x, 5, transform.position.z - MOVE_DIST), Vector3.down, hit, 100.0, 1) && hit.collider != null)
	{
		transform.position.z -= MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.z -= MOVE_DIST;
		moveTimer = 0;
	}
	if (Input.GetAxis("Diagonal45") == 1 && moveTimer > moveRate && Physics.Raycast (Vector3(transform.position.x + MOVE_DIST, 5, transform.position.z + MOVE_DIST), Vector3.down, hit, 100.0, 1) && hit.collider != null)
	{
		transform.position.x += MOVE_DIST;
		transform.position.z += MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.x += MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.z += MOVE_DIST;
		moveTimer = 0;
	}
	else if (Input.GetAxis("Diagonal45") == -1 && moveTimer > moveRate && Physics.Raycast (Vector3(transform.position.x - MOVE_DIST, 5, transform.position.z - MOVE_DIST), Vector3.down, hit, 100.0, 1) && hit.collider != null)
	{
		transform.position.x -= MOVE_DIST;
		transform.position.z -= MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.x -= MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.z -= MOVE_DIST;
		moveTimer = 0;
	}
	if (Input.GetAxis("Diagonal315") == 1 && moveTimer > moveRate && Physics.Raycast (Vector3(transform.position.x + MOVE_DIST, 5, transform.position.z - MOVE_DIST), Vector3.down, hit, 100.0, 1) && hit.collider != null)
	{
		transform.position.x += MOVE_DIST;
		transform.position.z -= MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.x += MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.z -= MOVE_DIST;
		moveTimer = 0;
	}
	else if (Input.GetAxis("Diagonal315") == -1 && moveTimer > moveRate && Physics.Raycast (Vector3(transform.position.x - MOVE_DIST, 5, transform.position.z + MOVE_DIST), Vector3.down, hit, 100.0, 1) && hit.collider != null)
	{
		transform.position.x -= MOVE_DIST;
		transform.position.z += MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.x -= MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.z += MOVE_DIST;
		moveTimer = 0;
	}
	if (Input.GetAxis("Rotate") == 1 && moveTimer > moveRate)
	{
		if (GameObject.Find("Player Sword").transform.position == Vector3(transform.position.x - MOVE_DIST, transform.position.y, transform.position.z))
		{
			GameObject.Find("Player Sword").transform.position.z += MOVE_DIST;
			GameObject.Find("Player Sword").transform.rotation.eulerAngles.y = 45;
		}
		else if (GameObject.Find("Player Sword").transform.position == Vector3(transform.position.x - MOVE_DIST, transform.position.y, transform.position.z + MOVE_DIST))
		{
			GameObject.Find("Player Sword").transform.position.x += MOVE_DIST;
			GameObject.Find("Player Sword").transform.rotation.eulerAngles.y = 90;
		}
		else if (GameObject.Find("Player Sword").transform.position == Vector3(transform.position.x, transform.position.y, transform.position.z + MOVE_DIST))
		{
			GameObject.Find("Player Sword").transform.position.x += MOVE_DIST;
			GameObject.Find("Player Sword").transform.rotation.eulerAngles.y = 135;
		}
		else if (GameObject.Find("Player Sword").transform.position == Vector3(transform.position.x + MOVE_DIST, transform.position.y, transform.position.z + MOVE_DIST))
		{
			GameObject.Find("Player Sword").transform.position.z -= MOVE_DIST;
			GameObject.Find("Player Sword").transform.rotation.eulerAngles.y = 180;
		}
		else if (GameObject.Find("Player Sword").transform.position == Vector3(transform.position.x + MOVE_DIST, transform.position.y, transform.position.z))
		{
			GameObject.Find("Player Sword").transform.position.z -= MOVE_DIST;
			GameObject.Find("Player Sword").transform.rotation.eulerAngles.y = 225;
		}
		else if (GameObject.Find("Player Sword").transform.position == Vector3(transform.position.x + MOVE_DIST, transform.position.y, transform.position.z - MOVE_DIST))
		{
			GameObject.Find("Player Sword").transform.position.x -= MOVE_DIST;
			GameObject.Find("Player Sword").transform.rotation.eulerAngles.y = 270;
		}
		else if (GameObject.Find("Player Sword").transform.position == Vector3(transform.position.x, transform.position.y, transform.position.z - MOVE_DIST))
		{
			GameObject.Find("Player Sword").transform.position.x -= MOVE_DIST;
			GameObject.Find("Player Sword").transform.rotation.eulerAngles.y = 315;
		}
		else if (GameObject.Find("Player Sword").transform.position == Vector3(transform.position.x - MOVE_DIST, transform.position.y, transform.position.z - MOVE_DIST))
		{
			GameObject.Find("Player Sword").transform.position.z += MOVE_DIST;
			GameObject.Find("Player Sword").transform.rotation.eulerAngles.y = 0;
		}
		moveTimer = 0;
	}
	else if (Input.GetAxis("Rotate") == -1 && moveTimer > moveRate)
	{
		if (GameObject.Find("Player Sword").transform.position == Vector3(transform.position.x - MOVE_DIST, transform.position.y, transform.position.z))
		{
			GameObject.Find("Player Sword").transform.position.z -= MOVE_DIST;
			GameObject.Find("Player Sword").transform.rotation.eulerAngles.y = 315;
		}
		else if (GameObject.Find("Player Sword").transform.position == Vector3(transform.position.x - MOVE_DIST, transform.position.y, transform.position.z + MOVE_DIST))
		{
			GameObject.Find("Player Sword").transform.position.z -= MOVE_DIST;
			GameObject.Find("Player Sword").transform.rotation.eulerAngles.y = 0;
		}
		else if (GameObject.Find("Player Sword").transform.position == Vector3(transform.position.x, transform.position.y, transform.position.z + MOVE_DIST))
		{
			GameObject.Find("Player Sword").transform.position.x -= MOVE_DIST;
			GameObject.Find("Player Sword").transform.rotation.eulerAngles.y = 45;
		}
		else if (GameObject.Find("Player Sword").transform.position == Vector3(transform.position.x + MOVE_DIST, transform.position.y, transform.position.z + MOVE_DIST))
		{
			GameObject.Find("Player Sword").transform.position.x -= MOVE_DIST;
			GameObject.Find("Player Sword").transform.rotation.eulerAngles.y = 90;
		}
		else if (GameObject.Find("Player Sword").transform.position == Vector3(transform.position.x + MOVE_DIST, transform.position.y, transform.position.z))
		{
			GameObject.Find("Player Sword").transform.position.z += MOVE_DIST;
			GameObject.Find("Player Sword").transform.rotation.eulerAngles.y = 135;
		}
		else if (GameObject.Find("Player Sword").transform.position == Vector3(transform.position.x + MOVE_DIST, transform.position.y, transform.position.z - MOVE_DIST))
		{
			GameObject.Find("Player Sword").transform.position.z += MOVE_DIST;
			GameObject.Find("Player Sword").transform.rotation.eulerAngles.y = 180;
		}
		else if (GameObject.Find("Player Sword").transform.position == Vector3(transform.position.x, transform.position.y, transform.position.z - MOVE_DIST))
		{
			GameObject.Find("Player Sword").transform.position.x += MOVE_DIST;
			GameObject.Find("Player Sword").transform.rotation.eulerAngles.y = 225;
		}
		else if (GameObject.Find("Player Sword").transform.position == Vector3(transform.position.x - MOVE_DIST, transform.position.y, transform.position.z - MOVE_DIST))
		{
			GameObject.Find("Player Sword").transform.position.x += MOVE_DIST;
			GameObject.Find("Player Sword").transform.rotation.eulerAngles.y = 270;
		}
		moveTimer = 0;
	}
}

function OnGUI ()
{
	GUI.skin = guiSkin;
	GUI.color = Color.black;
	GUI.Label (Rect (10, 10, 100, 40), "Health: " + hp);
}