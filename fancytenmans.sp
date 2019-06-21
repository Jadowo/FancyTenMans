#include <sourcemod>
#include <ccsplayer>
#include <sdktools>
#include <sdkhooks>
#pragma semicolon 1
#pragma newdecls required
#define PLUGIN_AUTHOR "Jadow"
#define PLUGIN_VERSION "1.00"
#define XG_PREFIX_CHAT " \x0A[\x0Bx\x08G\x0A]\x01 "
#define XG_PREFIX_CHAT_WARN " \x07[\x0Bx\x08G\x07]\x01 "

enum TenManSpecialStatus{
	CT_ONLY = 1,
	T_ONLY,
	ENABLED
};

public Plugin myinfo = {
	name = "Fancy 10 Mans",
	author = PLUGIN_AUTHOR,
	description = "Make it fancy",
	version = PLUGIN_VERSION,
	url = "https://github.com/Jadowo/FancyTenMans"
};
int ExoBootsToggle = 0;
int BumpMineToggle = 0;
int ShieldsToggle = 0;
int BreachChargeToggle = 0;
int MediShotToggle = 0;

public void OnPluginStart(){
	RegAdminCmd("sm_bumpy", Command_Bumpy, ADMFLAG_ROOT);
	RegAdminCmd("sm_exoboots", Command_ExoBoots, ADMFLAG_ROOT);
	RegAdminCmd("sm_bumpmine", Command_BumpMine, ADMFLAG_ROOT);
	RegAdminCmd("sm_shield", Command_Shields, ADMFLAG_ROOT);
	RegAdminCmd("sm_breachcharge", Command_BreachCharge, ADMFLAG_ROOT);
	RegAdminCmd("sm_medishot", Command_Medishot, ADMFLAG_ROOT);
	HookEvent("round_start", Event_RoundStart);
	HookEvent("round_end", Event_RoundEnd);
}

public void OnPluginEnd(){
	CCSPlayer p;
	while(CCSPlayer.Next(p)){
		if(p.InGame){
			SetEntProp(p.Index, Prop_Send, "m_passiveItems", 0, 1, 1);
		}
}
}

public Action Command_Bumpy(int client, int args){
	PrintToChatAll("bumpy bumpy");
}

public Action Command_ExoBoots(int client, int args){
	char teamnum[5];
	bool valid_team = false;
	GetCmdArg(1, teamnum, sizeof(teamnum));
	if(StrEqual(teamnum, "3") || StrEqual(teamnum, "2") || StrEqual(teamnum, "1") || StrEqual(teamnum, "0")){
		valid_team = true;
		ExoBootsToggle = StringToInt(teamnum);
		switch(ExoBootsToggle){
			case 0: { ReplyToCommand(client, XG_PREFIX_CHAT..."ExoBoots Off!"); }
			case 1: { ReplyToCommand(client, XG_PREFIX_CHAT..."ExoBoots CT Only!"); }
			case 2: { ReplyToCommand(client, XG_PREFIX_CHAT..."ExoBoots T Only!"); }
			case 3: { ReplyToCommand(client, XG_PREFIX_CHAT..."ExoBoots On!"); }
		}
	}
	if(!valid_team){
		ReplyToCommand(client, XG_PREFIX_CHAT_WARN..."Usage: sm_exoboots <0-3>");
		return Plugin_Handled;
	}
	return Plugin_Handled;
}

public Action Command_BumpMine(int client, int args){
	char teamnum[5];
	bool valid_team = false;
	GetCmdArg(1, teamnum, sizeof(teamnum));
	if(StrEqual(teamnum, "3") || StrEqual(teamnum, "2") || StrEqual(teamnum, "1") || StrEqual(teamnum, "0")){
		valid_team = true;
		BumpMineToggle = StringToInt(teamnum);
		switch(BumpMineToggle){
			case 0: { ReplyToCommand(client, XG_PREFIX_CHAT..."BumpMine Off!"); }
			case 1: { ReplyToCommand(client, XG_PREFIX_CHAT..."BumpMine CT Only!"); }
			case 2: { ReplyToCommand(client, XG_PREFIX_CHAT..."BumpMine T Only!"); }
			case 3: { ReplyToCommand(client, XG_PREFIX_CHAT..."BumpMine On!"); }
		}
	}
	if(!valid_team){
		ReplyToCommand(client, XG_PREFIX_CHAT_WARN..."Usage: sm_bumpmine <0-3>");
		return Plugin_Handled;
	}
	return Plugin_Handled;
}

public Action Command_Shields(int client, int args){
	char teamnum[5];
	bool valid_team = false;
	GetCmdArg(1, teamnum, sizeof(teamnum));
	if(StrEqual(teamnum, "3") || StrEqual(teamnum, "2") || StrEqual(teamnum, "1") || StrEqual(teamnum, "0")){
		valid_team = true;
		ShieldsToggle = StringToInt(teamnum);
		switch(ShieldsToggle){
			case 0: { ReplyToCommand(client, XG_PREFIX_CHAT..."Shields Off!"); }
			case 1: { ReplyToCommand(client, XG_PREFIX_CHAT..."Shields CT Only!"); }
			case 2: { ReplyToCommand(client, XG_PREFIX_CHAT..."Shields T Only!"); }
			case 3: { ReplyToCommand(client, XG_PREFIX_CHAT..."Shields On!"); }
		}
	}
	if(!valid_team){
		ReplyToCommand(client, XG_PREFIX_CHAT_WARN..."Usage: sm_shield <0-3>");
		return Plugin_Handled;
	}
	return Plugin_Handled;
}

public Action Command_BreachCharge(int client, int args){
	char teamnum[5];
	bool valid_team = false;
	GetCmdArg(1, teamnum, sizeof(teamnum));
	if(StrEqual(teamnum, "3") || StrEqual(teamnum, "2") || StrEqual(teamnum, "1") || StrEqual(teamnum, "0")){
		valid_team = true;
		BreachChargeToggle = StringToInt(teamnum);
		switch(BreachChargeToggle){
			case 0: { ReplyToCommand(client, XG_PREFIX_CHAT..."BreachCharge Off!"); }
			case 1: { ReplyToCommand(client, XG_PREFIX_CHAT..."BreachCharge CT Only!"); }
			case 2: { ReplyToCommand(client, XG_PREFIX_CHAT..."BreachCharge T Only!"); }
			case 3: { ReplyToCommand(client, XG_PREFIX_CHAT..."BreachCharge On!"); }
		}
	}
	if(!valid_team){
		ReplyToCommand(client, XG_PREFIX_CHAT_WARN..."Usage: sm_breachcharge <0-3>");
		return Plugin_Handled;
	}
	return Plugin_Handled;
}

public Action Command_Medishot(int client, int args){
	char teamnum[5];
	bool valid_team = false;
	GetCmdArg(1, teamnum, sizeof(teamnum));
	if(StrEqual(teamnum, "3") || StrEqual(teamnum, "2") || StrEqual(teamnum, "1") || StrEqual(teamnum, "0")){
		valid_team = true;
		MediShotToggle = StringToInt(teamnum);
		switch(MediShotToggle){
			case 0: { ReplyToCommand(client, XG_PREFIX_CHAT..."MediShot Off!"); }
			case 1: { ReplyToCommand(client, XG_PREFIX_CHAT..."MediShot CT Only!"); }
			case 2: { ReplyToCommand(client, XG_PREFIX_CHAT..."MediShot T Only!"); }
			case 3: { ReplyToCommand(client, XG_PREFIX_CHAT..."MediShot On!"); }
		}
	}
	if(!valid_team){
		ReplyToCommand(client, XG_PREFIX_CHAT_WARN..."Usage: sm_medishot <0-3>");
		return Plugin_Handled;
	}
	return Plugin_Handled;
}

public void Event_RoundStart(Event event, const char[] name, bool dontbroadcast){
	if(BumpMineToggle == view_as<int>(CT_ONLY)){
		GiveAllCTsWeapon("weapon_bumpmine");
	}else if(BumpMineToggle == view_as<int>(T_ONLY)){
		GiveAllTsWeapon("weapon_bumpmine");
	}else if(BumpMineToggle == view_as<int>(ENABLED)){
		GiveAllPlayersWeapon("weapon_bumpmine");
	}
	if(ShieldsToggle == view_as<int>(CT_ONLY)){
		GiveAllCTsWeapon("weapon_shield");
	}else if(ShieldsToggle == view_as<int>(T_ONLY)){
		GiveAllTsWeapon("weapon_shield");
	}else if(ShieldsToggle == view_as<int>(ENABLED)){
		GiveAllPlayersWeapon("weapon_shield");
	}
	if(BreachChargeToggle == view_as<int>(CT_ONLY)){
		GiveAllCTsWeapon("weapon_breachcharge");
	}else if(BreachChargeToggle == view_as<int>(T_ONLY)){
		GiveAllTsWeapon("weapon_breachcharge");
	}else if(BreachChargeToggle == view_as<int>(ENABLED)){
		GiveAllPlayersWeapon("weapon_breachcharge");
	}
	if(MediShotToggle == view_as<int>(CT_ONLY)){
		GiveAllCTsWeapon("weapon_healthshot");
	}else if(MediShotToggle == view_as<int>(T_ONLY)){
		GiveAllTsWeapon("weapon_healthshot");
	}else if(MediShotToggle == view_as<int>(ENABLED)){
			GiveAllPlayersWeapon("weapon_healthshot");
	}
	if(ExoBootsToggle == view_as<int>(CT_ONLY)){
		CCSPlayer p;
		while(CCSPlayer.Next(p)){
			if(p.InGame && p.Alive){
				if(p.Team == CS_TEAM_CT){
					SetEntProp(p.Index, Prop_Send, "m_passiveItems", 1, 1, 1);
				}
			}
		}
	}else if(ExoBootsToggle == view_as<int>(T_ONLY)){
		CCSPlayer p;
		while(CCSPlayer.Next(p)){
			if(p.InGame && p.Alive){
				if(p.Team == CS_TEAM_T){
					SetEntProp(p.Index, Prop_Send, "m_passiveItems", 1, 1, 1);
				}
			}
		}
	}else if(ExoBootsToggle == view_as<int>(ENABLED)){
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
		if(p.InGame){
			SetEntProp(p.Index, Prop_Send, "m_passiveItems", 0, 1, 1);
			if(p.Alive){
				CWeapon wep = p.GetWeapon(CS_SLOT_C4);
				char weaponClassName[32];
				wep.GetClassname(weaponClassName, sizeof(weaponClassName));
				//PrintToChatAll(weaponClassName);
				if(StrEqual(weaponClassName, "weapon_bumpmine")||StrEqual(weaponClassName, "weapon_breachcharge")){
					p.RemoveItem(wep);
					wep.Kill();
				}
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