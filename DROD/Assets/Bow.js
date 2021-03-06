﻿#pragma strict

var canControl = true;
var arrows = 0;
var damage = 1;
var shootForce = 75;
var range = 5;
var shootRate = 500;
var shootTimer = 0;
var bullet : GameObject;
var go : GameObject;
var guiSkin : GUISkin;
var MOVE_DIST = 6;

function Start ()
{
	
}

function Update ()
{
	if (!canControl || arrows <= 0 || GameObject.Find("Player Sword").collider.enabled || GameObject.Find("Player").GetComponent(PlayerBehavior).inPauseMenu)
		return;
	shootTimer ++;
	if (shootTimer > shootRate)
	{
	GameObject.Find("Player Graphics").GetComponent(SwitchItems).shouldUseSword2 = true;
	if (Input.GetAxisRaw("ShootHorizontal") == 1)
	{
		go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
		go.GetComponent(Bullet).shooter = gameObject;
		go.GetComponent(Bullet).damage = damage;
		go.GetComponent(Bullet).vel = Vector3(MOVE_DIST, 0, 0);
		go.GetComponent(Bullet).moveRate = shootForce;
		go.GetComponent(Bullet).destination = transform.position + (go.GetComponent(Bullet).vel * range);
		arrows --; GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText3 = true;
		shootTimer = 0;
	}
	else if (Input.GetAxisRaw("ShootHorizontal") == -1)
	{
		go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
		go.GetComponent(Bullet).shooter = gameObject;
		go.GetComponent(Bullet).damage = damage;
		go.GetComponent(Bullet).vel = Vector3(-MOVE_DIST, 0, 0);
		go.GetComponent(Bullet).moveRate = shootForce;
		go.GetComponent(Bullet).destination = transform.position + (go.GetComponent(Bullet).vel * range);
		arrows --; GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText3 = true;
		shootTimer = 0;
	}
	else if (Input.GetAxisRaw("ShootVertical") == 1)
	{
		go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
		go.GetComponent(Bullet).shooter = gameObject;
		go.GetComponent(Bullet).damage = damage;
		go.GetComponent(Bullet).vel = Vector3(0, 0, MOVE_DIST);
		go.GetComponent(Bullet).moveRate = shootForce;
		go.GetComponent(Bullet).destination = transform.position + (go.GetComponent(Bullet).vel * range);
		arrows --; GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText3 = true;
		shootTimer = 0;
	}
	else if (Input.GetAxisRaw("ShootVertical") == -1)
	{
		go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
		go.GetComponent(Bullet).shooter = gameObject;
		go.GetComponent(Bullet).damage = damage;
		go.GetComponent(Bullet).vel = Vector3(0, 0, -MOVE_DIST);
		go.GetComponent(Bullet).moveRate = shootForce;
		go.GetComponent(Bullet).destination = transform.position + (go.GetComponent(Bullet).vel * range);
		arrows --; GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText3 = true;
		shootTimer = 0;
	}
	else if (Input.GetAxisRaw("ShootDiagonal45") == 1)
	{
		go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
		go.GetComponent(Bullet).shooter = gameObject;
		go.GetComponent(Bullet).damage = damage;
		go.GetComponent(Bullet).vel = Vector3(MOVE_DIST, 0, MOVE_DIST);
		go.GetComponent(Bullet).moveRate = shootForce;
		go.GetComponent(Bullet).destination = transform.position + (go.GetComponent(Bullet).vel * range);
		arrows --; GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText3 = true;
		shootTimer = 0;
	}
	else if (Input.GetAxisRaw("ShootDiagonal45") == -1)
	{
		go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
		go.GetComponent(Bullet).shooter = gameObject;
		go.GetComponent(Bullet).damage = damage;
		go.GetComponent(Bullet).vel = Vector3(-MOVE_DIST, 0, -MOVE_DIST);
		go.GetComponent(Bullet).moveRate = shootForce;
		go.GetComponent(Bullet).destination = transform.position + (go.GetComponent(Bullet).vel * range);
		arrows --; GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText3 = true;
		shootTimer = 0;
	}
	else if (Input.GetAxisRaw("ShootDiagonal315") == 1)
	{
		go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
		go.GetComponent(Bullet).shooter = gameObject;
		go.GetComponent(Bullet).damage = damage;
		go.GetComponent(Bullet).vel = Vector3(MOVE_DIST, 0, -MOVE_DIST);
		go.GetComponent(Bullet).moveRate = shootForce;
		go.GetComponent(Bullet).destination = transform.position + (go.GetComponent(Bullet).vel * range);
		arrows --; GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText3 = true;
		shootTimer = 0;
	}
	else if (Input.GetAxisRaw("ShootDiagonal315") == -1)
	{
		go = GameObject.Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 90));
		go.GetComponent(Bullet).shooter = gameObject;
		go.GetComponent(Bullet).damage = damage;
		go.GetComponent(Bullet).vel = Vector3(-MOVE_DIST, 0, MOVE_DIST);
		go.GetComponent(Bullet).moveRate = shootForce;
		go.GetComponent(Bullet).destination = transform.position + (go.GetComponent(Bullet).vel * range);
		arrows --; GameObject.Find("Player").GetComponent(PlayerBehavior).showBowText3 = true;
		shootTimer = 0;
	}
	}
}

function OnGUI ()
{
	if (!canControl)
		return;
	GUI.skin = guiSkin;
	GUI.color = Color.black;
	GUI.Label (Rect (10, 30, 500, 40), "Arrows: " + arrows);
}