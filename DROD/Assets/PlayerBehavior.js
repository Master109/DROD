﻿#pragma strict

var hp = 3;
var MOVE_DIST = 6;
var moveTimer = 0;
var moveRate = 30;
var firstFrame = true;
var hasMoved = false;
var hit : RaycastHit;
var guiSkin : GUISkin;
var canZoom = true;
var gos : GameObject[];

function Start ()
{
	
}

function Update ()
{
	moveTimer ++;
	if (firstFrame || (!hasMoved && !firstFrame))
	{
	if (Input.GetAxis("Horizontal") == 1 && moveTimer > moveRate && Physics.Raycast (Vector3(transform.position.x + MOVE_DIST, 5, transform.position.z), Vector3.down, hit, 10, 1) && hit.collider != null)
	{
		transform.position.x += MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.x += MOVE_DIST;
		moveTimer = 0;
		gos = GameObject.FindGameObjectsWithTag("Enemy");
		for (var go : GameObject in gos)
			if (!go.GetComponent(RoachBehavior).awoken)
				go.GetComponent(RoachBehavior).CheckForPlayer();
		if (firstFrame)
		hasMoved = true;
	}
	else if (Input.GetAxis("Horizontal") == -1 && moveTimer > moveRate && Physics.Raycast (Vector3(transform.position.x - MOVE_DIST, 5, transform.position.z), Vector3.down, hit, 10, 1) && hit.collider != null)
	{
		transform.position.x -= MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.x -= MOVE_DIST;
		moveTimer = 0;
		gos = GameObject.FindGameObjectsWithTag("Enemy");
		for (var go : GameObject in gos)
			if (!go.GetComponent(RoachBehavior).awoken)
				go.GetComponent(RoachBehavior).CheckForPlayer();
		if (firstFrame)
		hasMoved = true;
	}
	if (Input.GetAxis("Vertical") == 1 && moveTimer > moveRate && Physics.Raycast (Vector3(transform.position.x, 5, transform.position.z + MOVE_DIST), Vector3.down, hit, 10, 1) && hit.collider != null)
	{
		transform.position.z += MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.z += MOVE_DIST;
		moveTimer = 0;
		gos = GameObject.FindGameObjectsWithTag("Enemy");
		for (var go : GameObject in gos)
			if (!go.GetComponent(RoachBehavior).awoken)
				go.GetComponent(RoachBehavior).CheckForPlayer();
		if (firstFrame)
		hasMoved = true;
	}
	else if (Input.GetAxis("Vertical") == -1 && moveTimer > moveRate && Physics.Raycast (Vector3(transform.position.x, 5, transform.position.z - MOVE_DIST), Vector3.down, hit, 10, 1) && hit.collider != null)
	{
		transform.position.z -= MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.z -= MOVE_DIST;
		moveTimer = 0;
		gos = GameObject.FindGameObjectsWithTag("Enemy");
		for (var go : GameObject in gos)
			if (!go.GetComponent(RoachBehavior).awoken)
				go.GetComponent(RoachBehavior).CheckForPlayer();
		if (firstFrame)
		hasMoved = true;
	}
	if (Input.GetAxis("Diagonal45") == 1 && moveTimer > moveRate && Physics.Raycast (Vector3(transform.position.x + MOVE_DIST, 5, transform.position.z + MOVE_DIST), Vector3.down, hit, 10, 1) && hit.collider != null)
	{
		transform.position.x += MOVE_DIST;
		transform.position.z += MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.x += MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.z += MOVE_DIST;
		moveTimer = 0;
		gos = GameObject.FindGameObjectsWithTag("Enemy");
		for (var go : GameObject in gos)
			if (!go.GetComponent(RoachBehavior).awoken)
				go.GetComponent(RoachBehavior).CheckForPlayer();
		if (firstFrame)
		hasMoved = true;
	}
	else if (Input.GetAxis("Diagonal45") == -1 && moveTimer > moveRate && Physics.Raycast (Vector3(transform.position.x - MOVE_DIST, 5, transform.position.z - MOVE_DIST), Vector3.down, hit, 10, 1) && hit.collider != null)
	{
		transform.position.x -= MOVE_DIST;
		transform.position.z -= MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.x -= MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.z -= MOVE_DIST;
		moveTimer = 0;
		gos = GameObject.FindGameObjectsWithTag("Enemy");
		for (var go : GameObject in gos)
			if (!go.GetComponent(RoachBehavior).awoken)
				go.GetComponent(RoachBehavior).CheckForPlayer();
		if (firstFrame)
		hasMoved = true;
	}
	if (Input.GetAxis("Diagonal315") == 1 && moveTimer > moveRate && Physics.Raycast (Vector3(transform.position.x + MOVE_DIST, 5, transform.position.z - MOVE_DIST), Vector3.down, hit, 10, 1) && hit.collider != null)
	{
		transform.position.x += MOVE_DIST;
		transform.position.z -= MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.x += MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.z -= MOVE_DIST;
		moveTimer = 0;
		gos = GameObject.FindGameObjectsWithTag("Enemy");
		for (var go : GameObject in gos)
			if (!go.GetComponent(RoachBehavior).awoken)
				go.GetComponent(RoachBehavior).CheckForPlayer();
		if (firstFrame)
		hasMoved = true;
	}
	else if (Input.GetAxis("Diagonal315") == -1 && moveTimer > moveRate && Physics.Raycast (Vector3(transform.position.x - MOVE_DIST, 5, transform.position.z + MOVE_DIST), Vector3.down, hit, 10, 1) && hit.collider != null)
	{
		transform.position.x -= MOVE_DIST;
		transform.position.z += MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.x -= MOVE_DIST;
		//GameObject.Find("Player Sword").transform.position.z += MOVE_DIST;
		moveTimer = 0;
		gos = GameObject.FindGameObjectsWithTag("Enemy");
		for (var go : GameObject in gos)
			if (!go.GetComponent(RoachBehavior).awoken)
				go.GetComponent(RoachBehavior).CheckForPlayer();
		if (firstFrame)
		hasMoved = true;
	}
	}
	if (Input.GetAxis("Rotate") == 1 && moveTimer > moveRate && (hasMoved || (!hasMoved && !firstFrame)))
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
		if (hasMoved)
		{
			hasMoved = false;
			GameObject.Find("Text").renderer.enabled = true;
			GameObject.Find("Text").GetComponent(Shrink).enabled = true;
		}
	}
	else if (Input.GetAxis("Rotate") == -1 && moveTimer > moveRate && (hasMoved || (!hasMoved && !firstFrame)))
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
		if (hasMoved)
		{
			hasMoved = false;
			GameObject.Find("Text").renderer.enabled = true;
			GameObject.Find("Text").GetComponent(Shrink).enabled = true;
		}
	}
	if (Input.GetAxis("Zoom") == 1 && canZoom)
	{
		if (!GameObject.Find("Camera").camera.enabled)
			GameObject.Find("Camera").camera.enabled = true;
		else
			GameObject.Find("Camera").camera.enabled = false;
		canZoom = false;
	}
	else if (Input.GetAxis("Zoom") == 0)
		canZoom = true;
}

// The position on of the scrolling viewport
var scrollPosition : Vector2 = Vector2(Screen.width / 2, -Screen.height + 150);

function OnGUI ()
{
	if (firstFrame)
	{
		// An absolute-positioned example: We make a scrollview that has a really large client
		// rect and put it in a small rect on the screen.
		scrollPosition = GUI.BeginScrollView (Rect (Screen.width / 2 - 375, Screen.height - 150, 750, 150),
			scrollPosition, Rect (0, 0, 725, 150));
		
		// Make four buttons - one in each corner. The coordinate system is defined
		// by the last parameter to BeginScrollView.
		//GUI.backgroundColor = Color.gray;
		GUI.color = Color.cyan;
		GUI.Box(Rect(0, 0, 725, 25), "You gain conciousness with no memory of any past that you might have had");
		GUI.Box(Rect(0, 25, 725, 25), "You see that you are standing in a dense forest");
		GUI.Box(Rect(0, 50, 725, 25), "Suddenly, without you telling it to, your body starts to move");
		GUI.color = Color.green;
		GUI.Box(Rect(0, 75, 725, 25), "Hold one of the 8 keys surrounding 'S' to move in that direction (pretend you are standing on the 'S' key)");
		// End the scroll view that we began above.
		GUI.EndScrollView ();
		if (hasMoved)
			firstFrame = false;
	}
	else if (hasMoved)
	{
		// An absolute-positioned example: We make a scrollview that has a really large client
		// rect and put it in a small rect on the screen.
		scrollPosition = GUI.BeginScrollView (Rect (Screen.width / 2 - 375, Screen.height - 150, 750, 150),
			scrollPosition, Rect (0, 0, 725, 150));
		
		// Make four buttons - one in each corner. The coordinate system is defined
		// by the last parameter to BeginScrollView.
		//GUI.backgroundColor = Color.gray;
		GUI.color = Color.green;
		GUI.Box(Rect(0, 0, 725, 25), "Hold the left or right arrow key to rotate your sword");
		// End the scroll view that we began above.
		GUI.EndScrollView ();
	}
	else
	{
		GUI.skin = guiSkin;
		GUI.color = Color.black;
		GUI.Label (Rect (10, 10, 500, 40), "Health: " + hp);
	}
}