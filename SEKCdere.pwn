/*
	Troydere made this out of his ballsack.
	I'm from Venezuela. We clean our assholes with copyright so you can do pretty much what you want with this script.
		
	Disclaiming is gay aswell.
*/

#include <a_samp>

#define FILTERSCRIPT
#if defined FILTERSCRIPT

// ----- User Configuration --------

#define ALL_PLAYERS_KC 0
#define RANGE_KC 150
#define USE_STREAMER 1

// ----- Definitions and such ------

#if USE_STREAMER == 1
	#include <streamer>
	#define CreateObject CreateDynamicObject
	#define MoveObject MoveDynamicObject
	#define DestroyObject DestroyDynamicObject
	#define SetObjectPos SetDynamicObjectPos
	#define GetObjectPos GetDynamicObjectPos
	#define OnObjectMoved OnDynamicObjectMoved
	#define AttachCameraToObject AttachCameraToDynamicObject
	#define IsValidObject IsValidDynamicObject
#endif

new Bullet[MAX_PLAYERS],Cameraing[MAX_PLAYERS],Float:Pos[MAX_PLAYERS][3];


// ----- Disorganized code and such ------

public OnFilterScriptInit()
{
	for(new i = 0,j = GetPlayerPoolSize(); i <= j; i++)
	{
		if(!IsPlayerConnected(i)) continue;
		Cameraing[i] = -1;
	}
	printf("[SEKCdere] Sniper Elite Headshot KillCam system loaded.");
	return 1;
}

public OnFilterScriptExit()
{
	printf("[SEKCdere] Sniper Elite Headshot KillCam system unloaded.");
	for(new i = 0; i < MAX_PLAYERS; i++){if(IsValidObject(Bullet[i])) DestroyObject(Bullet[i]);}
	return 1;
}

public OnPlayerConnect(playerid)
{
	Cameraing[playerid] = -1;
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(hittype == BULLET_HIT_TYPE_PLAYER && weaponid == 34)	return 0;
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
	if(playerid != INVALID_PLAYER_ID && weaponid == 34 && bodypart == 9)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(damagedid,Pos[damagedid][0],Pos[damagedid][1],Pos[damagedid][2]);
		GetPlayerPos(playerid,x,y,z);
		if(!IsValidObject(Bullet[damagedid]))
		{
			Bullet[damagedid] = CreateObject(19300,0.0,0.0,0.0,0.0,0.0,0.0);
			SetObjectPos(Bullet[damagedid],x,y,z);
		}		
		#if ALL_PLAYERS_KC == 1
			for(new i = 0,j = GetPlayerPoolSize(); i <= j; i++)
			{
				if(!IsPlayerConnected(i) || Cameraing[i] != -1 || !IsPlayerInRangeOfPoint(i,RANGE_KC,x,y,z)) continue;
				Cameraing[i] = damagedid;
				TogglePlayerControllable(i,0);
				SetPlayerCameraPos(i,x,y,z+10);
				SetPlayerCameraLookAt(i,x,y,z-10);
				SetTimerEx("KillCamMinus",500,false,"ii",i,damagedid);
			}
		#elseif ALL_PLAYERS_KC == 0
			if(Cameraing[damagedid] != -1 || Cameraing[playerid] != -1) return 1;
			SetPlayerCameraPos(playerid,x,y,z+10);
			SetPlayerCameraLookAt(playerid,x,y,z-10);
			SetPlayerCameraPos(damagedid,x,y,z+10);
			SetPlayerCameraLookAt(damagedid,x,y,z-10);				
			TogglePlayerControllable(damagedid,0);
			TogglePlayerControllable(playerid,0);
			SetTimerEx("KillCamMinus",500,false,"ii",playerid,damagedid);
			SetTimerEx("KillCamMinus",500,false,"ii",damagedid,damagedid);
			Cameraing[damagedid] = damagedid;
			Cameraing[playerid] = damagedid;
		#endif
		ApplyAnimation(damagedid,"SHOP","ROB_Loop_Threat",4.1,1,0,0,0,0);
	}
	return 1;
}

forward KillCamMinus(playerid,targetid);
public KillCamMinus(playerid,targetid)
{
	new Float:x,Float:y,Float:z;
	GetObjectPos(Bullet[targetid],x,y,z);
	SetPlayerCameraPos(playerid,x,y,z);
	SetPlayerCameraLookAt(playerid,Pos[targetid][0],Pos[targetid][1],Pos[targetid][2],1);
	AttachCameraToObject(playerid,Bullet[targetid]);
	SetTimerEx("KillCam",1300,false,"ii",playerid,targetid);
	return 1;
}

forward KillCam(playerid,targetid);
public KillCam(playerid,targetid)
{
	MoveObject(Bullet[targetid],Pos[targetid][0],Pos[targetid][1],Pos[targetid][2],50);
	return 1;
}

forward KillCamPlus(playerid,targetid);
public KillCamPlus(playerid,targetid)
{
	if(IsValidObject(Bullet[targetid])) DestroyObject(Bullet[targetid]);
	Cameraing[playerid] = -1;
	TogglePlayerControllable(playerid,1);
	SetCameraBehindPlayer(playerid);
	new Float:hearuto;
	GetPlayerHealth(targetid,hearuto);
	if(hearuto > 0) SetPlayerHealth(targetid,0.0); // Edit this if you don't want the player to die after the cinematic
	return 1;
}

public OnObjectMoved(objectid)
{
	for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
	{
		if(objectid == Bullet[i])
		{
			ApplyAnimation(i,"CRACK","crckdeth2",4.1,1,0,0,0,0);
			for(new k = 0, u = GetPlayerPoolSize(); k <= u; k++)
			{
				if(Cameraing[k] != i) continue;
				SetPlayerCameraPos(k,Pos[i][0],Pos[i][1],Pos[i][2]+2);
				SetPlayerCameraLookAt(k,Pos[i][0],Pos[i][1],Pos[i][2]-10,1);
				SetTimerEx("KillCamPlus",3500,false,"ii",k,i);
			}
		}
	}
	return 1;
}

#endif 
