#pragma strict

var actions : String[];
var keyFrames : float[];
var timeMultiplier = 10;
var id = 0;
var frame = 0;
var currentAction = 0;
var CONSECUTIVE_ACTION_MAX = 2;
var MOVE_DIST = 6;
var guiSkin2 : GUISkin;

function Start ()
{
	
}

function FixedUpdate ()
{
	for (var i = 0; i <= CONSECUTIVE_ACTION_MAX; i ++)
		if (currentAction < keyFrames.Length && frame >= keyFrames[currentAction] * timeMultiplier)
		{
			if (actions[currentAction] == "up")
				transform.position.z += MOVE_DIST;
			else if (actions[currentAction] == "down")
				transform.position.z -= MOVE_DIST;
			else if (actions[currentAction] == "right")
				transform.position.x += MOVE_DIST;
			else if (actions[currentAction] == "left")
				transform.position.x -= MOVE_DIST;
			currentAction ++;
		}
	frame ++;
}

var scrollPosition : Vector2 = Vector2(Screen.width / 2, -Screen.height + 150);

function OnGUI ()
{
	if (frame >= keyFrames[keyFrames.Length - 1] * timeMultiplier)
	{
		if (id == 1)
		{
			GUI.skin = guiSkin2;
			scrollPosition = GUI.BeginScrollView (Rect (Screen.width / 2 - 375, Screen.height - 150, 750, 150),
				scrollPosition, Rect (0, 0, 725, 275));
			GUI.color = Color.magenta;
			GUI.Box(Rect(0, 0, 725, 25), "'Your highness, I have some very important news for you,' you say with a grin");
			GUI.Box(Rect(0, 25, 725, 25), "Spitting on the floor, you say, 'Today is your last... I challenge you to a fight to the death!'");
			GUI.color = Color.cyan;
			GUI.Box(Rect(0, 50, 725, 25), "For a moment the king seemed dumbstruck, then wheezed with laughter for a while");
			GUI.color = Color.magenta;
			GUI.Box(Rect(0, 75, 725, 25), "Still chuckling, the king speaks, 'You're a whimp!'");
			GUI.Box(Rect(0, 100, 725, 25), "'No man has EVER scratched me, and YOU talk like you are going to WIN!'");
			GUI.Box(Rect(0, 125, 725, 25), "'Do you know what I do to people like you?'");
			GUI.Box(Rect(0, 150, 725, 25), "'Same as always; I behead them and use their head for sport!'");
			GUI.Box(Rect(0, 175, 725, 25), "'And what makes you think that you are any different?'");
			GUI.Box(Rect(0, 200, 725, 25), "'Because I'm not a man,' you retort");
			GUI.Box(Rect(0, 225, 725, 25), "'No reason to say that, I'll know by your insides,' the king responds");
			GUI.color = Color.green;
			GUI.Box(Rect(0, 250, 725, 25), "Press [SPACE] to continue");
			GUI.EndScrollView ();
			if (Input.GetAxisRaw("ContinueDialog") == 1)
			{
				GameObject.Find("Player").GetComponent(PlayerBehavior).paused = false;
				GameObject.Find("Player Sword").active = true;
				GameObject.Find("Character 1").GetComponent(Character).active = true;
				GameObject.Find("Character 1").GetComponent(Character).paused = false;
				GameObject.Find("Character Sword 1").renderer.active = true;
			}
		}
	}
}