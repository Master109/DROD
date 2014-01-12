#pragma strict

var enemyA : GameObject;
var enemyAAppearRate = 500.0;
var enemyAAppearTimer = 0;
var enemyB : GameObject;
var enemyBAppearRate = 1500.0;
var enemyBAppearTimer = 0;
var score = 0;
var scoreLocked = false;

function Start ()
{
	scoreLocked = false;
	score = 0;
	GetComponent(PlayerBehavior2).hp = 2;
	enemyAAppearRate = 500.0;
	enemyAAppearTimer = 0;
	var gos = GameObject.FindGameObjectsWithTag("Enemy");
	for (var go : GameObject in gos)
		Destroy(go);
	transform.position = Vector3(0, 3, 0);
}

function Update ()
{
	if (GetComponent(PlayerBehavior2).hp <= 0 || transform.position.y < 0)
		scoreLocked = true;
	enemyAAppearTimer ++;
	if (enemyAAppearTimer >= enemyAAppearRate)
	{
		var createLoc = Vector2(Random.Range(-25.5, 25.5), Random.Range(-25.5, 25.5));
		while (Vector2.Distance(createLoc, Vector2(transform.position.x, transform.position.z)) < 15 || Vector2.Distance(createLoc, Vector2(transform.position.x, transform.position.z)) > 53)
			createLoc = Vector2(Random.Range(-25.5, 25.5), Random.Range(-25.5, 25.5));
		Instantiate(enemyA, Vector3(createLoc.x, 3, createLoc.y), Quaternion.identity);
		enemyAAppearTimer = 0;
		enemyAAppearRate *= .99;
	}
	enemyBAppearTimer ++;
	if (enemyBAppearTimer >= enemyBAppearRate)
	{
		var createLoc2 = Vector2(Random.Range(-75, 75), Random.Range(-75, 75));
		while (Vector2.Distance(createLoc2, Vector2(transform.position.x, transform.position.z)) < 60 || Vector2.Distance(createLoc2, Vector2(transform.position.x, transform.position.z)) > 75)
			createLoc = Vector2(Random.Range(-25.5, 25.5), Random.Range(-25.5, 25.5));
		Instantiate(enemyB, Vector3(createLoc2.x, 3, createLoc2.y), Quaternion.identity);
		enemyBAppearTimer = 0;
		enemyBAppearRate *= .99;
	}
	if (Input.GetAxis("Restart") == 1)
		Start();
}

function OnGUI ()
{
	GUI.Label (Rect (10, 10, 99999, 20), "Score: " + score);
	GUI.Label (Rect (10, 20, 99999, 20), "HP: " + GetComponent(PlayerBehavior2).hp);
}