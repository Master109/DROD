#pragma strict

var pairID = 0;
var teleport = false;
var gos : GameObject[];
//var gos2 : GameObject[];
//var gos3 : GameObject[];

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
		{
			if (teleport && gameObject != go && pairID == go.GetComponent(EndZone).pairID)
			{
				GameObject.Find("Player").transform.position.x += go.transform.position.x - GameObject.Find("Player Graphics").transform.position.x;
				GameObject.Find("Player").transform.position.z += go.transform.position.z - GameObject.Find("Player Graphics").transform.position.z;
				gos = GameObject.FindGameObjectsWithTag("MainCamera");
				for (var go2 : GameObject in gos)
				{
					if (go2.camera.enabled)
						go2.camera.enabled = false;
				}
				gos = GameObject.FindGameObjectsWithTag("Area");
				for (var go3 : GameObject in gos)
				{
					if (GameObject.Find("Player Graphics").transform.position.x > (go3.transform.position.x + go3.GetComponent(BoxCollider).center.x) - go3.GetComponent(BoxCollider).size.x / 2 && GameObject.Find("Player Graphics").transform.position.x < (go3.transform.position.x + go3.GetComponent(BoxCollider).center.x) + go3.GetComponent(BoxCollider).size.x / 2 && GameObject.Find("Player Graphics").transform.position.z > (go3.transform.position.z + go3.GetComponent(BoxCollider).center.z) - go3.GetComponent(BoxCollider).size.z / 2 && GameObject.Find("Player Graphics").transform.position.z < (go3.transform.position.z + go3.GetComponent(BoxCollider).center.z) + go3.GetComponent(BoxCollider).size.z / 2)
					{
						gos = GameObject.FindGameObjectsWithTag("Enemy");
						for (var go4 : GameObject in gos)
							if (go4.transform.position.x > (go3.transform.position.x + go3.GetComponent(BoxCollider).center.x) - go3.GetComponent(BoxCollider).size.x / 2 && go4.transform.position.x < (go3.transform.position.x + go3.GetComponent(BoxCollider).center.x) + go3.GetComponent(BoxCollider).size.x / 2 && go4.transform.position.z > (go3.transform.position.z + go3.GetComponent(BoxCollider).center.z) - go3.GetComponent(BoxCollider).size.z / 2 && go4.transform.position.z < (go3.transform.position.z + go3.GetComponent(BoxCollider).center.z) + go3.GetComponent(BoxCollider).size.z / 2)
							{
								if (go4.name == "Roach")
									go4.GetComponent(RoachBehavior).paused = false;
								else if (go4.name == "SkeletonArcher")
									go4.GetComponent(SkeletonArcher).paused = false;
							}
					}
					else
					{
						gos = GameObject.FindGameObjectsWithTag("Enemy");
						for (var go5 : GameObject in gos)
							if (go5.transform.position.x > (go3.transform.position.x + go3.GetComponent(BoxCollider).center.x) - go3.GetComponent(BoxCollider).size.x / 2 && go5.transform.position.x < (go3.transform.position.x + go3.GetComponent(BoxCollider).center.x) + go3.GetComponent(BoxCollider).size.x / 2 && go5.transform.position.z > (go3.transform.position.z + go3.GetComponent(BoxCollider).center.z) - go3.GetComponent(BoxCollider).size.z / 2 && go5.transform.position.z < (go3.transform.position.z + go3.GetComponent(BoxCollider).center.z) + go3.GetComponent(BoxCollider).size.z / 2)
							{
								if (go5.name == "Roach")
									go5.GetComponent(RoachBehavior).paused = true;
								else if (go5.name == "SkeletonArcher")
									go5.GetComponent(SkeletonArcher).paused = true;
							}
					}
					gos = GameObject.FindGameObjectsWithTag("Area");
				}
			}
			gos = GameObject.FindGameObjectsWithTag("EndZone");
		}
	}
}