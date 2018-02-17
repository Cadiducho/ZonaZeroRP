public OnPlayerRequestClass(playerid) {

    GetPlayerName(playerid, PlayersData[playerid][Nombre], 24);
    RemoveRallaName(playerid);
    SetSpawnInfo(playerid, 0, 0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
    GetPlayerIp(playerid, PlayersData[playerid][IP], 16);
    SetPlayerColor(playerid, 0xAAAAAAFF);
    
    SetPlayerCameraPos(playerid, -1450.2291, 662.2463, 1.5133);
    SetPlayerCameraLookAt(playerid, -1297.3114, 731.4880, 39.9422);
    if (!IsUsingSAMPP(playerid))
    {
        SendMessageClient(playerid, 0, "Disculpe las molestias, no esta utilizando el cliente oficial del servidor, por favor vaya a www.ZZRoleplay.com");
        KickEx(playerid);
    }
    TogglePlayerSpectating(playerid, true);
	if ( PlayersDataOnline[playerid][Mundo] == 0 )
	{
		
        new Query[128];
        mysql_format(Sp_Conector, Query, sizeof(Query),"SELECT `Password`, `ID` FROM `cuentas` WHERE `Nombre` = '%e' LIMIT 1", PlayersData[playerid][Nombre]);
        mysql_tquery(Sp_Conector, Query, "ShowLoginOrRegister", "i", playerid);
	}
	return true;
}
public OnPlayerConnect(playerid) {
    SetPlayerColor(playerid, 0xAAAAAAFF);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 1);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 1);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 1);
    ToggleHUDComponentForPlayer(playerid, HUD_COMPONENT_ALL, false);
	TogglePauseMenuAbility(playerid, true);
	return true;
}
public OnPlayerRequestSpawn(playerid) {
	return true;
}
public OnPlayerSpawn(playerid) {
	return true;
}
public OnPlayerUpdate(playerid) {

	if ( PlayersDataOnline[playerid][Logueado] )
	{
		if(PlayersData[playerid][ManoDerecha][0] > 0)
		{
			if(GetPlayerWeapon(playerid) != ObjetoInfo[PlayersData[playerid][ManoDerecha][0]][IDArma] && GetPlayerWeaponAmmo(playerid, ObjetoInfo[PlayersData[playerid][ManoDerecha][0]][IDArma]) > 0)
			{
				SetPlayerArmedWeapon(playerid, ObjetoInfo[PlayersData[playerid][ManoDerecha][0]][IDArma]);
			}
			else if(GetPlayerWeaponAmmo(playerid, ObjetoInfo[PlayersData[playerid][ManoDerecha][0]][IDArma]) == 0) //Si no le queda munición
			{
				if(GetPlayerWeapon(playerid) != 0)SetPlayerArmedWeapon(playerid, 0);
			}
		}
	}
	return true;
}
forward ShowLoginOrRegister(playerid);
public ShowLoginOrRegister(playerid)
{
    new String[140];
    if ( PlayersDataOnline[playerid][Mundo] == 0 )
    {
        MusicaID[playerid] = random(19);
        PlayAudioStreamForPlayer(playerid, MusicaAudio[MusicaID[playerid] - 0]);
        for( new i = 0; i <= 100; i ++ ) SendClientMessage(playerid, -1, " " );

        SetPlayerCameraPos(playerid, -1450.2291, 662.2463, 1.5133);
        SetPlayerCameraLookAt(playerid, -1297.3114, 731.4880, 39.9422);

	    if (cache_num_rows() == 0)
	    {
            SendClientMessage(playerid, -1, Server_Logo_Op);
            format(String, sizeof(String), "{FFFFFF}Bienvenido %s\n\n\t{FFFFFF}Por favor ingrese una contraseña para registrarse en {F37924}Zona Zero", PlayersDataOnline[playerid][NombreFix]);
            Dialog_Show(playerid, Registro, DIALOG_STYLE_PASSWORD, "{414344}»{FFFFFF} Registro!", String, "Continuar", "Salir");
	    }
	    else
	    {
            PlayersDataOnline[playerid][Mundo] = 1;
            cache_get_value_name(0, "Password", PlayersData[playerid][Password]);
            cache_get_value_name_int(0, "ID", PlayersData[playerid][ID]);
            CargarDatosSQL(playerid);
			/////////////////////////////////////////////
            SendClientMessage(playerid, -1, Server_Logo);
            format(String, sizeof(String), "{FFFFFF}Bienvenido nuevamente %s\n\n\t{FFFFFF}Por favor ingrese su contraseña para ingresar en {F37924}Zona Zero", PlayersDataOnline[playerid][NombreFix]);
		    Dialog_Show(playerid, Logueo, DIALOG_STYLE_PASSWORD, "{414344}»{FFFFFF} Iniciar sesión!", String, "Continuar", "Salir");
	    }
	}
	return true;
}
forward SpawnearPlayer(playerid);
public SpawnearPlayer(playerid)
{
    SetPlayerColor(playerid, -1);
	if ( PlayersDataOnline[playerid][Mundo] == 1 )
	{
        for( new i = 0; i <= 100; i ++ ) SendClientMessage(playerid, -1, " " );
        
        TogglePlayerSpectating(playerid, false);
		new String[160];
        format(String, sizeof(String), "Has realizado spawn en tu ultima posición guardada - UC: %s", PlayersData[playerid][Acceso]);
		SendMessageClient(playerid, 2, String);
        SetPlayerHealth(playerid, PlayersData[playerid][Vida]);
        SetPlayerArmour(playerid, PlayersData[playerid][Chaleco]);
        SetPlayerSkin(playerid, PlayersData[playerid][Skin]);
        SetPlayerInterior(playerid, PlayersData[playerid][Interior]);
        SetPlayerVirtualWorld(playerid, PlayersData[playerid][World]);
        SpawnPlayer(playerid);
        SetPlayerPosEx(playerid, PlayersData[playerid][Pos][0], PlayersData[playerid][Pos][1], PlayersData[playerid][Pos][2], PlayersData[playerid][Pos][3]);
		SetPlayerSkin(playerid, PlayersData[playerid][Skin]);
		/////////////////////////////
        format(String, sizeof(String), "Estas escuchando: {83F600}%s {414344}|{FFFFFF} /Stop", Musica[MusicaID[playerid] - 0]);
        SendMessageClient(playerid, 4, String);
        /////////////////////////////
        ClearAnimations(playerid);
        PlayersDataOnline[playerid][Logueado] = true;
        SetCameraBehindPlayer(playerid);
	}
	PlayersDataOnline[playerid][Mundo] = 10;
	return true;
}
public OnPlayerText(playerid, text[])
{
	if ( PlayersDataOnline[playerid][Logueado] )
	{
        SendChatNormal(playerid, text, "dice:", PlayersData[playerid][Idioma]);
	}
	else
	{
		SendMessageClient(playerid, 0, "No te encuentras totalmente conectado cómo para utilizar el Chat");
		return false;
	}
	return false;
}
public OnPlayerDeath(playerid) {
	return true;
}
public OnPlayerDisconnect(playerid, reason) {
    GuardarDatosSQL(playerid);
    CleanVariables(playerid);
	return true;
}
forward RealizarConexionesMySQL();
public RealizarConexionesMySQL() {

    new MySQLOpt:Config = mysql_init_options();
    mysql_set_option(Config, SERVER_PORT, 3306);
    
    mysql_log(ALL);
    
	Sp_Conector = mysql_connect("localhost", "root", "", "zz", Config);
	
//// OPCIONES DEL SERVIDOR
	SetGameModeText(Server_GameText);
	new rcon[80];
	format(rcon, sizeof(rcon), "hostname %s", Server_Nombre);
	SendRconCommand(rcon);

	format(rcon, sizeof(rcon), "weburl %s", Server_Web);
	SendRconCommand(rcon);

	format(rcon, sizeof(rcon), "mapname %s", Server_Map);
	SendRconCommand(rcon);

	format(rcon, sizeof(rcon), "language %s", Server_Language);
	SendRconCommand(rcon);

	format(rcon, sizeof(rcon), "password %s", Server_Password);
	SendRconCommand(rcon);

	format(rcon, sizeof(rcon), "rcon_password %s", Server_Rcon);
	SendRconCommand(rcon);

//// FUNCIONES
	ManualVehicleEngineAndLights();
	DisableInteriorEnterExits();
	ShowPlayerMarkers(0);
	EnableStuntBonusForAll(false);
	SetNameTagDrawDistance(7);
	SetWeather(14);
	SetTimerGlobal();
	SetTimer("PlayersTimer", 500, 1);
	return true;
}
forward PlayersTimer();
public PlayersTimer()
{
    for(new playerid; playerid < MAX_PLAYERS; playerid++)
	{
	    ActualizarManos(playerid);
	}
	return true;
}
forward DetenerConexionesMySQL();
public DetenerConexionesMySQL() {

    mysql_close(Sp_Conector);
    return true;
}
public OnModelSelectionResponse(playerid, extraid, index, modelid, response)
{
	if ((response) && (extraid == SELECCION_SKIN_INTRO))
	{
        TogglePlayerSpectating(playerid, false);
        SpawnPlayer(playerid);
        PlayersData[playerid][Skin] = modelid;
        SetPlayerSkin(playerid, PlayersData[playerid][Skin]);
        SetPlayerPosEx(playerid, 0.0, 0.0, 0.0, 0.0);
        switch (PlayersData[playerid][Sexo])
        {
            case 0:
                SendMessageClient(playerid, 6, "Bienvenida, puedes utilizar el comando /Información");

            case 1:
                SendMessageClient(playerid, 6, "Bienvenido, puedes utilizar el comando /Información");
        }
        SetPlayerMoney(playerid, 2000);
        SetPlayerHealth(playerid, 80);
        StopAudioStreamForPlayer(playerid);
        SetPlayerVirtualWorld(playerid, 0);
        SetCameraBehindPlayer(playerid);
	}
	return 1;
}
