#pragma strict

var maxHP = 10;
var hp = maxHP;
var MOVE_DIST = 6;
var moveTimer = 0;
var moveRate = 100;
var firstFrame = true;
var hasMoved = false;
var hit : RaycastHit;
var guiSkin : GUISkin;
var guiSkin2 : GUISkin;
var canZoom = true;
var gos : GameObject[];
var firstBow = true;
var showBowText = false;
var showBowText2 = false;
var showBowText3 = false;
var bowTextOver = false;

function Start ()
{
	
}

function Update ()
{
	if (showBowText || showBowText2 || showBowText3)
		return;
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
		{
			if (go.name == "Roach" && !go.GetComponent(RoachBehavior).awoken)
				go.GetComponent(RoachBehavior).CheckForPlayer();
			else if (go.name == "SkeletonArcher" && !go.GetComponent(SkeletonArcher).awoken)
				go.GetComponent(SkeletonArcher).CheckForPlayer();
		}
		if (Physics.Raycast (Vector3(transform.position.x, 5, transform.position.z), Vector3.down, hit, 10, 1) && hit.collider.gameObject.tag == "EndZone")
			hit.collider.gameObject.GetComponent(EndZone).AreaChange();
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
		{
			if (go.name == "Roach" && !go.GetComponent(RoachBehavior).awoken)
				go.GetComponent(RoachBehavior).CheckForPlayer();
			else if (go.name == "SkeletonArcher" && !go.GetComponent(SkeletonArcher).awoken)
				go.GetComponent(SkeletonArcher).CheckForPlayer();
		}
		if (Physics.Raycast (Vector3(transform.position.x, 5, transform.position.z), Vector3.down, hit, 10, 1) && hit.collider.gameObject.tag == "EndZone")
			hit.collider.gameObject.GetComponent(EndZone).AreaChange();
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
		{
			if (go.name == "Roach" && !go.GetComponent(RoachBehavior).awoken)
				go.GetComponent(RoachBehavior).CheckForPlayer();
			else if (go.name == "SkeletonArcher" && !go.GetComponent(SkeletonArcher).awoken)
				go.GetComponent(SkeletonArcher).CheckForPlayer();
		}
		if (Physics.Raycast (Vector3(transform.position.x, 5, transform.position.z), Vector3.down, hit, 10, 1) && hit.collider.gameObject.tag == "EndZone")
			hit.collider.gameObject.GetComponent(EndZone).AreaChange();
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
		{
			if (go.name == "Roach" && !go.GetComponent(RoachBehavior).awoken)
				go.GetComponent(RoachBehavior).CheckForPlayer();
			else if (go.name == "SkeletonArcher" && !go.GetComponent(SkeletonArcher).awoken)
				go.GetComponent(SkeletonArcher).CheckForPlayer();
		}
		if (Physics.Raycast (Vector3(transform.position.x, 5, transform.position.z), Vector3.down, hit, 10, 1) && hit.collider.gameObject.tag == "EndZone")
			hit.collider.gameObject.GetComponent(EndZone).AreaChange();
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
		{
			if (go.name == "Roach" && !go.GetComponent(RoachBehavior).awoken)
				go.GetComponent(RoachBehavior).CheckForPlayer();
			else if (go.name == "SkeletonArcher" && !go.GetComponent(SkeletonArcher).awoken)
				go.GetComponent(SkeletonArcher).CheckForPlayer();
		}
		if (Physics.Raycast (Vector3(transform.position.x, 5, transform.position.z), Vector3.down, hit, 10, 1) && hit.collider.gameObject.tag == "EndZone")
			hit.collider.gameObject.GetComponent(EndZone).AreaChange();
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
		{
			if (go.name == "Roach" && !go.GetComponent(RoachBehavior).awoken)
				go.GetComponent(RoachBehavior).CheckForPlayer();
			else if (go.name == "SkeletonArcher" && !go.GetComponent(SkeletonArcher).awoken)
				go.GetComponent(SkeletonArcher).CheckForPlayer();
		}
		if (Physics.Raycast (Vector3(transform.position.x, 5, transform.position.z), Vector3.down, hit, 10, 1) && hit.collider.gameObject.tag == "EndZone")
			hit.collider.gameObject.GetComponent(EndZone).AreaChange();
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
		{
			if (go.name == "Roach" && !go.GetComponent(RoachBehavior).awoken)
				go.GetComponent(RoachBehavior).CheckForPlayer();
			else if (go.name == "SkeletonArcher" && !go.GetComponent(SkeletonArcher).awoken)
				go.GetComponent(SkeletonArcher).CheckForPlayer();
		}
		if (Physics.Raycast (Vector3(transform.position.x, 5, transform.position.z), Vector3.down, hit, 10, 1) && hit.collider.gameObject.tag == "EndZone")
			hit.collider.gameObject.GetComponent(EndZone).AreaChange();
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
		{
			if (go.name == "Roach" && !go.GetComponent(RoachBehavior).awoken)
				go.GetComponent(RoachBehavior).CheckForPlayer();
			else if (go.name == "SkeletonArcher" && !go.GetComponent(SkeletonArcher).awoken)
				go.GetComponent(SkeletonArcher).CheckForPlayer();
		}
		if (Physics.Raycast (Vector3(transform.position.x, 5, transform.position.z), Vector3.down, hit, 10, 1) && hit.collider.gameObject.tag == "EndZone")
			hit.collider.gameObject.GetComponent(EndZone).AreaChange();
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
		gos = GameObject.FindGameObjectsWithTag("MainCamera");
		var go = GameObject.FindGameObjectWithTag("MainCamera");
		for (var go2 : GameObject in gos)
		{
			if (Vector3.Distance(go2.transform.position, GameObject.Find("Player Graphics").transform.position) < Vector3.Distance(go.transform.position, GameObject.Find("Player Graphics").transform.position))
				go = go2;
			//else
				//go2.camera.enabled = false;
		}
		if (!go.camera.enabled)
			go.camera.enabled = true;
		else
			go.camera.enabled = false;
		canZoom = false;
	}
	else if (Input.GetAxis("Zoom") == 0)
		canZoom = true;
}

// The position on of the scrolling viewport
var scrollPosition : Vector2 = Vector2(Screen.width / 2, -Screen.height + 150);

function OnGUI ()
{
	GUI.skin = guiSkin2;
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
		GUI.Box(Rect(0, 75, 725, 25), "Hold one of the 8 keys surrounding the '5' on the numpad to move in that direction (pretend you are standing on the '5')");
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
		GUI.Box(Rect(0, 0, 725, 25), "Hold 'Q' or 'W' to rotate your sword");
		// End the scroll view that we began above.
		GUI.EndScrollView ();
	}
	else
	{
		GUI.skin = guiSkin;
		GUI.color = Color.black;
		GUI.Label (Rect (10, 10, 500, 40), "Health: " + hp + " / " + maxHP);
	}
	if (showBowText)
	{
		// An absolute-positioned example: We make a scrollview that has a really large client
		// rect and put it in a small rect on the screen.
		scrollPosition = GUI.BeginScrollView (Rect (Screen.width / 2 - 375, Screen.height - 150, 750, 150),
			scrollPosition, Rect (0, 0, 725, 150));
		
		// Make four buttons - one in each corner. The coordinate system is defined
		// by the last parameter to BeginScrollView.
		//GUI.backgroundColor = Color.gray;
		GUI.color = Color.cyan;
	GUI.Box(Rect(0, 0, 725, 25), "Congratz! You have earned your first bow!");
		GUI.color = Color.green;
		GUI.Box(Rect(0, 25, 725, 25), "Press '2' to switch from using your sword to using your bow");
		// End the scroll view that we began above.
		GUI.EndScrollView ();
		if (Input.GetAxis("Ranged") == 1)
		{
			showBowText2 = true;
			showBowText = false;
		}
	}
	else if (showBowText3)
	{
		showBowText2 = false;
		// An absolute-positioned example: We make a scrollview that has a really large client
		// rect and put it in a small rect on the screen.
		scrollPosition = GUI.BeginScrollView (Rect (Screen.width / 2 - 375, Screen.height - 150, 750, 150),
			scrollPosition, Rect (0, 0, 725, 150));
		
		// Make four buttons - one in each corner. The coordinate system is defined
		// by the last parameter to BeginScrollView.
		//GUI.backgroundColor = Color.gray;
		//GUI.color = Color.cyan;
		//GUI.Box(Rect(0, 0, 725, 25), "Congratz! You have earned your first bow!");
		GUI.color = Color.green;
		GUI.Box(Rect(0, 0, 725, 25), "Remember that your arrow supply is limited; it is displayed in the top-left corner of the screen");
		GUI.Box(Rect(0, 25, 725, 25), "Press '1' to switch back to using your sword (cannot be done untill you are ready to shoot the next arrow)");
		// End the scroll view that we began above.
		GUI.EndScrollView ();
	}
	else if (showBowText2)
	{
		// An absolute-positioned example: We make a scrollview that has a really large client
		// rect and put it in a small rect on the screen.
		scrollPosition = GUI.BeginScrollView (Rect (Screen.width / 2 - 375, Screen.height - 150, 750, 150),
			scrollPosition, Rect (0, 0, 725, 150));
		
		// Make four buttons - one in each corner. The coordinate system is defined
		// by the last parameter to BeginScrollView.
		//GUI.backgroundColor = Color.gray;
		//GUI.color = Color.cyan;
		//GUI.Box(Rect(0, 0, 725, 25), "Congratz! You have earned your first bow!");
		GUI.color = Color.green;
		GUI.Box(Rect(0, 0, 725, 25), "Hold one of the 8 keys surrounding the 'S' on the numpad to shoot in that direction (pretend you are standing on the 'S')");
		// End the scroll view that we began above.
		GUI.EndScrollView ();
	}
}