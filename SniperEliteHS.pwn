/*
	Troydere made this out of his ballsack.
	I'm from Venezuela. We clean our assholes with copyright so you can do pretty much what you want with this script.
		
	Disclaiming is gay aswell.
*/

#include <a_samp>

#define FILTERSCRIPT
#if defined FILTERSCRIPT

// ----- User Configuration --------

#define ALL_PLAYERS_HS 1
#define USE_STREAMER 0

// ----- Definitions and such ------

#if USE_STREAMER == 1
	#include <streamer>
	#define CreateObject CreateDynamicObject
	#define MoveObject MoveDynamicObject
	#define DestroyObject DestroyDynamicObject
#endif

forward MoveBullet(Float:x,Float:y,Float:z);

new Bullet,Blood,Cameraing[MAX_PLAYERS],Player_Damaged = INVALID_PLAYER_ID;

// ----- Disorganized code and such ------

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	if(issuerid != INVALID_PLAYER_ID && weaponid == 38 && bodypart == 9)
	{
		new Float:x,Float:y,Float:z,Float:x1,Float:y1,Float:z1;
		GetPlayerPos(playerid,x1,y1,z1);
		GetPlayerPos(issuerid,x,y,z);
		Player_Damaged = playerid;
		Bullet = CreateObject(3106,x,y,z,0.0,0.0,0.0);
		
		#if ALL_PLAYERS_HS == 1
			for(new i = 0,j = GetPlayerPoolSize(); i <= j; i++)
			{
				if(!IsPlayerConnected(i) || IsPlayerNPC(i) || Cameraing[i] == 1) continue;
				Cameraing[i] = 1;
				TogglePlayerControllable(i,0);
				AttachCameraToObject(i,Bullet);
			}
		#elseif ALL_PLAYERS_HS == 0
			TogglePlayerControllable(playerid,0);
			TogglePlayerControllable(issuerid,0);
			AttachCameraToObject(playerid,Bullet);
			AttachCameraToObject(issuerid,Bullet);
			Cameraing[playerid] = 1;
			Cameraing[issuerid] = 1;
		#endif
		ApplyAnimation(playerid,"SHOP","ROB_Loop_Threat",4.1,1,0,0,0,0);
		SetTimerEx("MoveBullet",700,false,"fff",x1,z1,z1);
	}
	return 1;
}

public MoveBullet(Float:x,Float:y,Float:z)
{
	MoveObject(Bullet,x,y,z,10);
	return 1;
}

public OnObjectMoved(objectid)
{
	new Float:x,Float:y,Float:z;
	if(objectid == Bullet)
	{
		GetObjectPos(Bullet,x,y,z);
		DestroyObject(Bullet);
		
		if(Player_Damaged != INVALID_PLAYER_ID)
		{
			ApplyAnimation(Player_Damaged,"CRACK","crckdeth2",4.1,1,0,0,0,0);
			Player_Damaged = INVALID_PLAYER_ID;
		}
		
		Blood = CreateObject(18668,x,y,z,0.0,0.0,0.0);
		MoveObject(Blood,x,y,z-0.9,1);
	}
	
	if(objectid == Blood)
	{
		DestroyObject(Blood);
		
		for(new i = 0,j = GetPlayerPoolSize(); i <= j; i++)
		{
			if(!IsPlayerConnected(i) || IsPlayerNPC(i) || Cameraing[i] == 0) continue;
			Cameraing[i] = 0;
			TogglePlayerControllable(i,1);
			SetCameraBehindPlayer(i);
		}
	}
	
	return 1;
}

#endif 
