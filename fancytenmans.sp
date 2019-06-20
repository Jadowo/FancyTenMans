#include <sourcemod>
#include <ccsplayer>
#include <sdktools>
#include <sdkhooks>
#pragma semicolon 1
#pragma newdecls required
#define PLUGIN_AUTHOR "Jadow"
#define PLUGIN_VERSION "1.00"

enum TenManSpecialStatus{
	CT_ONLY = 1,
	T_ONLY,
	ENABLED
};

public Plugin myinfo = {
	name = "Fancy 10 Mans",
	author = PLUGIN_AUTHOR,
	description = "Yes",
	version = PLUGIN_VERSION,
	url = ""
};
ConVar ExoBootsToggle;
ConVar BumpMineToggle;
ConVar ShieldToggle;
ConVar BreachChargeToggle;
ConVar MediShotToggle;
ConVar MediShotNum;

public void OnPluginStart(){
	RegAdminCmd("sm_bumpy", Command_Bumpy, ADMFLAG_ROOT);
	HookEvent("round_start", Event_RoundStart);
	HookEvent("round_end", Event_RoundEnd);
	
	ExoBootsToggle = CreateConVar("sm_10man_toggle_exoboots", "0", "0 = Disabled, 1 = CT, 2 = T, 3 = Both", _, true, 0.0, true, 3.0);
	BumpMineToggle = CreateConVar("sm_10man_toggle_bumpmine", "0", "0 = Disabled, 1 = CT, 2 = T, 3 = Both", _, true, 0.0, true, 3.0);
	ShieldToggle = CreateConVar("sm_10man_toggle_shield", "0", "0 = Disabled, 1 = CT, 2 = T, 3 = Both", _, true, 0.0, true, 3.0);
	BreachChargeToggle = CreateConVar("sm_10man_toggle_breachcharge", "0", "0 = Disabled, 1 = CT, 2 = T, 3 = Both", _, true, 0.0, true, 3.0);
	MediShotToggle = CreateConVar("sm_10man_toggle_medishot", "0", "0 = Disabled, 1 = CT, 2 = T, 3 = Both", _, true, 0.0, true, 3.0);
	MediShotNum = CreateConVar("sm_10man_num_medishot", "1", "Amount of MediShots", _, true, 0.0, true, 5.0);
	AutoExecConfig(true, "plugin.fancytenman");
}

public Action Command_Bumpy(int client, int args){
	PrintToChatAll("bumpy bumpy");
}

public void Event_RoundStart(Event event, const char[] name, bool dontbroadcast){
	if(BumpMineToggle.IntValue == view_as<int>(CT_ONLY)){
		GiveAllCTsWeapon("weapon_bumpmine");
	}else if(BumpMineToggle.IntValue == view_as<int>(T_ONLY)){
		GiveAllTsWeapon("weapon_bumpmine");
	}else if(BumpMineToggle.IntValue == view_as<int>(ENABLED)){
		GiveAllPlayersWeapon("weapon_bumpmine");
	}
	if(ShieldToggle.IntValue == view_as<int>(CT_ONLY)){
		GiveAllCTsWeapon("weapon_shield");
	}else if(ShieldToggle.IntValue == view_as<int>(T_ONLY)){
		GiveAllTsWeapon("weapon_shield");
	}else if(ShieldToggle.IntValue == view_as<int>(ENABLED)){
		GiveAllPlayersWeapon("weapon_shield");
	}
	if(BreachChargeToggle.IntValue == view_as<int>(CT_ONLY)){
		GiveAllCTsWeapon("weapon_breachcharge");
	}else if(BreachChargeToggle.IntValue == view_as<int>(T_ONLY)){
		GiveAllTsWeapon("weapon_breachcharge");
	}else if(BreachChargeToggle.IntValue == view_as<int>(ENABLED)){
		GiveAllPlayersWeapon("weapon_breachcharge");
	}
	if(MediShotToggle.IntValue == view_as<int>(CT_ONLY)){
		for(int num = 1; num <= MediShotNum.IntValue; num++){
			GiveAllCTsWeapon("weapon_healthshot");
		}
	}else if(MediShotToggle.IntValue == view_as<int>(T_ONLY)){
		for(int num = 1; num <= MediShotNum.IntValue; num++){
			GiveAllTsWeapon("weapon_healthshot");
		}
	}else if(MediShotToggle.IntValue == view_as<int>(ENABLED)){
		for(int num = 1; num <= MediShotNum.IntValue; num++){
			GiveAllPlayersWeapon("weapon_healthshot");
		}
	}
	if(ExoBootsToggle.IntValue == view_as<int>(CT_ONLY)){
		CCSPlayer p;
		while(CCSPlayer.Next(p)){
			if(p.InGame && p.Alive){
				if(p.Team == CS_TEAM_CT){
					SetEntProp(p.Index, Prop_Send, "m_passiveItems", 1, 1, 1);
				}
			}
		}
	}else if(ExoBootsToggle.IntValue == view_as<int>(T_ONLY)){
		CCSPlayer p;
		while(CCSPlayer.Next(p)){
			if(p.InGame && p.Alive){
				if(p.Team == CS_TEAM_T){
					SetEntProp(p.Index, Prop_Send, "m_passiveItems", 1, 1, 1);
				}
			}
		}
	}else if(ExoBootsToggle.IntValue == view_as<int>(ENABLED)){
		CCSPlayer p;
		while(CCSPlayer.Next(p)){
			if(p.InGame && p.Alive){
				SetEntProp(p.Index, Prop_Send, "m_passiveItems", 1, 1, 1);
			}
		}
	}
}

public void Event_RoundEnd(Event event, const char[] name, bool dontBroadcast){
	CCSPlayer p;
	while(CCSPlayer.Next(p)){
		if(p.InGame && p.Alive){
			CWeapon wep = p.GetWeapon(CS_SLOT_C4);
			char weaponClassName[32];
			wep.GetClassname(weaponClassName, sizeof(weaponClassName));
			PrintToChatAll(weaponClassName);
			if(StrEqual(weaponClassName, "weapon_bumpmine")||StrEqual(weaponClassName, "weapon_breachcharge")){
				p.RemoveItem(wep);
				wep.Kill();
			}
		}
	}
}

public void GiveAllPlayersWeapon(char[] weapon_Name){
	CCSPlayer p;
	while(CCSPlayer.Next(p)){
		if(p.InGame && p.Alive){
			GivePlayerWeapon(p, weapon_Name);
		}
	}
}

public void GiveAllCTsWeapon(char[] weapon_Name){
	CCSPlayer p;
	while(CCSPlayer.Next(p)){
		if(p.InGame && p.Alive && p.Team == CS_TEAM_CT){
			GivePlayerWeapon(p, weapon_Name);
		}
	}
}

public void GiveAllTsWeapon(char[] weapon_Name){
	CCSPlayer p;
	while(CCSPlayer.Next(p)){
		if(p.InGame && p.Alive && p.Team == CS_TEAM_T){
			GivePlayerWeapon(p, weapon_Name);
		}
	}
}