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
var awakeRadius = 3;
var hit : RaycastHit;
var paused = true;
var guiSkin2 : GUISkin;
var id = 0;
var gos : GameObject[];

function Start ()
{
	
}

function Update ()
{
	
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
			if (vector == GameObject.Find("Player Graphics").transform.position)
				awoken = true;
			Update();
		}
		else if (vector.x - GameObject.Find("Player Graphics").transform.position.x < 0)
		{
			vector.x += MOVE_DIST;
			if (vector == GameObject.Find("Player Graphics").transform.position)
				awoken = true;
			Update();
		}
		if (vector.z - GameObject.Find("Player Graphics").transform.position.z > 0)
		{
			vector.z -= MOVE_DIST;
			if (vector == GameObject.Find("Player Graphics").transform.position)
				awoken = true;
			Update();
		}
		else if (vector.z - GameObject.Find("Player Graphics").transform.position.z < 0)
		{
			vector.z += MOVE_DIST;
			if (vector == GameObject.Find("Player Graphics").transform.position)
				awoken = true;
			Update();
		}
	}
}

function OnTriggerStay (other : Collider)
{
	
}

function OnTriggerExit (other : Collider)
{
	
}

var scrollPosition : Vector2 = Vector2(Screen.width / 2, -Screen.height + 150);

function OnGUI ()
{
	if (!awoken)
		return;
	GameObject.Find("Player").GetComponent(PlayerBehavior).paused = true;
	GUI.skin = guiSkin2;
		//GUI.color = Color.black;
		//GUI.Box(Rect(0, 0, 1000, 25), "THIS GAME IS BARELY IN ITS BEGGINING STAGES -- NO TROLLING");
		//GUI.Box(Rect(0, 25, 1000, 25), "RIGHT CLICK AND PRESS 'GO FULLSCREEN' FOR NO LAG");
		// An absolute-positioned example: We make a scrollview that has a really large client
		// rect and put it in a small rect on the screen.
		scrollPosition = GUI.BeginScrollView (Rect (Screen.width / 2 - 375, Screen.height - 150, 750, 150),
			scrollPosition, Rect (0, 0, 725, 225));
		
		// Make four buttons - one in each corner. The coordinate system is defined
		// by the last parameter to BeginScrollView.
		//GUI.backgroundColor = Color.gray;
		GUI.color = Color.cyan;
		GUI.Box(Rect(0, 0, 725, 25), "There are two guards standing ahead of you");
		GUI.Box(Rect(0, 25, 725, 25), "Behind them is a lowered drawbridge and a portcullis");
		GUI.Box(Rect(0, 50, 725, 25), "Through the portcullis you see a crowded city with large looming buildings in the distance");
		GUI.color = Color.magenta;
		GUI.Box(Rect(0, 75, 725, 25), "'Ho!' they say as you approach them");
		GUI.Box(Rect(0, 100, 725, 25), "'Nice to see another face -- we haven't got anybody going in or out for a while.");
		GUI.Box(Rect(0, 125, 725, 25), "Anyway, please hand over your weapons.'");
		GUI.Box(Rect(0, 150, 725, 25), "Without warning, you say, 'Like hell that's happening!'");
		GUI.color = Color.cyan;
		GUI.Box(Rect(0, 175, 725, 25), "Abruptly, they both fall limp");
		GUI.color = Color.green;
		GUI.Box(Rect(0, 200, 725, 25), "Press [SPACE] to continue");
		if (Input.GetAxisRaw("ContinueDialog") == 1)
		{
			Destroy(gameObject);
			gos = GameObject.FindGameObjectsWithTag("Character");
			for (var go : GameObject in gos)
				if (go.GetComponent(Character).id == 2)
					Destroy(go);
			GameObject.Find("Player").GetComponent(PlayerBehavior).paused = false;
		}
		// End the scroll view that we began above.
		GUI.EndScrollView ();
}