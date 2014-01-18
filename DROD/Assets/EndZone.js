#pragma strict

var id = 1;
var linkedID = 1;
var gos : GameObject[];

function Start ()
{
	
}

function Update ()
{
	
}

function AreaChange ()
{
	if (transform.position.x == GameObject.Find("Player Graphics").transform.position.x && transform.position.z == GameObject.Find("Player Graphics").transform.position.z)
	{
		gos = GameObject.FindGameObjectsWithTag("EndZone");
		for (var go : GameObject in gos)
			if (id == go.GetComponent(EndZone).linkedID)
			{
				GameObject.Find("Player").transform.position.x += go.transform.position.x - GameObject.Find("Player Graphics").transform.position.x;
				GameObject.Find("Player").transform.position.z += go.transform.position.z - GameObject.Find("Player Graphics").transform.position.z;
				gos = GameObject.FindGameObjectsWithTag("MainCamera");
				//var go = GameObject.FindGameObjectWithTag("MainCamera");
				for (var go2 : GameObject in gos)
				{
					if (go2.camera.enabled)
						go2.camera.enabled = false;
					//if (Vector3.Distance(go2.transform.position, GameObject.Find("Player Graphics").transform.position) < Vector3.Distance(go.transform.position, GameObject.Find("Player Graphics").transform.position))
						//go = go2;
					//else
						//go2.camera.enabled = false;
				}
				//if (!go.camera.enabled)
					//go.camera.enabled = true;
				//else
					//go.camera.enabled = false;
			}
	}
}