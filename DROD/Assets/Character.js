#pragma strict

var hp = 1;
var MOVE_DIST = 6;
var moveTimer = 0;
var moveRate = 30;
var attackTimer = 125;
var attackRate = 125;
var playerAttackTimer = 100;
var playerAttackRate = 100;
var shootRate = 50;
var shootTimer = 0;
var awoken = false;
var awakeRadius = 3;
var hit : RaycastHit;
var paused = true;
var guiSkin2 : GUISkin;
var id = 0;
var gos : GameObject[];
var go : GameObject;
var bullet : GameObject;

function Start ()
{
	
}

function Update ()
{
	if (paused)
		return;
	shootTimer ++;
	if (shootTimer > shootRate)
	{
		go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
		go.GetComponent(Bullet).vel = Vector3(-MOVE_DIST, 0, 0);
		go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
		go.GetComponent(Bullet).vel = Vector3(MOVE_DIST, 0, 0);
		go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
		go.GetComponent(Bullet).vel = Vector3(0, 0, -MOVE_DIST);
		go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
		go.GetComponent(Bullet).vel = Vector3(0, 0, MOVE_DIST);
		go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
		go.GetComponent(Bullet).vel = Vector3(-MOVE_DIST, 0, -MOVE_DIST);
		go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
		go.GetComponent(Bullet).vel = Vector3(-MOVE_DIST, 0, MOVE_DIST);
		go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
		go.GetComponent(Bullet).vel = Vector3(MOVE_DIST, 0, -MOVE_DIST);
		go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
		go.GetComponent(Bullet).vel = Vector3(MOVE_DIST, 0, MOVE_DIST);
		shootTimer = 0;
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
	if (id == 1)
	{
		GameObject.Find("Player").GetComponent(PlayerBehavior).paused = true;
		GUI.skin = guiSkin2;
		scrollPosition = GUI.BeginScrollView (Rect (Screen.width / 2 - 375, Screen.height - 150, 750, 150),
			scrollPosition, Rect (0, 0, 725, 275));
		GUI.color = Color.cyan;
		GUI.Box(Rect(0, 0, 725, 25), "There are two guards standing ahead of you");
		GUI.Box(Rect(0, 25, 725, 25), "Behind them is a lowered drawbridge and a portcullis");
		GUI.Box(Rect(0, 50, 725, 25), "Through the portcullis you see a crowded city with large looming buildings in the distance");
		GUI.color = Color.magenta;
		GUI.Box(Rect(0, 75, 725, 25), "'Ho!' they say as you approach them");
		GUI.Box(Rect(0, 100, 725, 25), "'Nice to see another face -- we haven't got anybody going in or out for a while.'");
		GUI.Box(Rect(0, 125, 725, 25), "'Anyway, please hand over your weapons.'");
		GUI.Box(Rect(0, 150, 725, 25), "Without warning, you say, 'Like hell that's happening.'");
		GUI.color = Color.cyan;
		GUI.Box(Rect(0, 175, 725, 25), "Abruptly, they both fall limp");
		GUI.Box(Rect(0, 200, 725, 25), "You instantly levitate one of the guards out of view and, after walking over to him, change into his clothes");
		GUI.Box(Rect(0, 225, 725, 25), "Awhile later....");
		GUI.color = Color.green;
		GUI.Box(Rect(0, 250, 725, 25), "Press [SPACE] to continue");
		GUI.EndScrollView ();
		if (Input.GetAxisRaw("ContinueDialog") == 1)
		{
			Application.DontDestroyOnLoad(GameObject.Find("Player"));
			Application.DontDestroyOnLoad(GameObject.Find("Main Camera"));
			Application.LoadLevel(2);
			GameObject.Find("Player").GetComponent(PlayerBehavior).paused = true;
			GameObject.Find("Player").GetComponent(Cutscene).active = true;
			GameObject.Find("Player Sword").active = false;
		}
	}
}