#pragma strict

var rotateSpeed = 0.1;
var moveSpeed = 0.1;
var keys = new Array();
var hp = 2;

function Start ()
{
	for (var i = 0; i < 4; i ++)
		keys.Add(false);
}

function Update ()
{
	var vel = Vector3.zero;
	if (Input.GetKeyDown("d"))
		keys[0] = true;
	if (Input.GetKeyDown("a"))
		keys[1] = true;
	if (Input.GetKeyDown("w"))
		keys[2] = true;
	if (Input.GetKeyDown("s"))
		keys[3] = true;
	if (Input.GetKeyUp("d"))
		keys[0] = false;
	if (Input.GetKeyUp("a"))
		keys[1] = false;
	if (Input.GetKeyUp("w"))
		keys[2] = false;
	if (Input.GetKeyUp("s"))
		keys[3] = false;
	if (keys[0])
		vel.x = moveSpeed;
	if (keys[1])
		vel.x = -moveSpeed;
	if (keys[2])
		vel.z = moveSpeed;
	if (keys[3])
		vel.z = -moveSpeed;
	vel = Vector3.ClampMagnitude(vel, moveSpeed);
	transform.position += vel;
	if (Input.GetAxis("Rotate") == 1)
		transform.rotation.eulerAngles.y += rotateSpeed;
	else if (Input.GetAxis("Rotate") == -1)
		transform.rotation.eulerAngles.y -= rotateSpeed;
}