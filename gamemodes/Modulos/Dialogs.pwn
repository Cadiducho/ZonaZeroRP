Dialog:Logueo(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new
		    Query[128];
		    
        SHA256_PassHash(inputtext, PlayersData[playerid][Salt], Query, 64);
        if(!strcmp(Query, PlayersData[playerid][Password]))
        {
            mysql_format(Sp_Conector, Query, sizeof(Query), "SELECT * FROM `cuentas` WHERE `Nombre` = '%e' LIMIT 1", PlayersData[playerid][Nombre]);
            mysql_tquery(Sp_Conector, Query, "SpawnearPlayer", "i", playerid);

            PlayersDataOnline[playerid][Mundo] = 1;
        }
        else
        {
            new String[180+MAX_PLAYER_NAME];
            format(String, sizeof(String), "{FFFFFF}Bienvenido nuevamente %s\n\n\t\t{FFFFFF}Por favor ingrese su contraseña para ingresar en {F37924}Zona Zero\n\n\t{E74C3C}Has ingresado una contraseña incorrecta", PlayersDataOnline[playerid][NombreFix]);
            Dialog_Show(playerid, Logueo, DIALOG_STYLE_PASSWORD, "{E74C3C}»{FFFFFF} Iniciar sesión!", String, "Continuar", "Salir");
        }
    }
    else
    {
        SendMessageClient(playerid, 2, "Gracias por entrar en el servidor, recuerde visitar www.ZZRoleplay.com!");
        KickEx(playerid);
    }
    return 1;
}
Dialog:Registro(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(strlen(inputtext) < 4 || strlen(inputtext) > 64)
        {
		    for(new i; i < 10; i++) {
			    PlayersDataOnline[playerid][Salt][i] = random(79) + 47;
		    }
		    PlayersDataOnline[playerid][Salt][10] = 0;
		    SHA256_PassHash(inputtext, PlayersDataOnline[playerid][Salt], PlayersData[playerid][Password], 65);
		}
		else
		{
            new String[180+MAX_PLAYER_NAME];
            format(String, sizeof(String), "{FFFFFF}Bienvenido %s\n\n\t\t{FFFFFF}Por favor ingrese una contraseña para registrar en {F37924}Zona Zero\n\n\t{E74C3C}Mínimo 4 caraceteres y máximo 64", PlayersDataOnline[playerid][NombreFix]);
            Dialog_Show(playerid, Logueo, DIALOG_STYLE_PASSWORD, "{E74C3C}»{FFFFFF} Registro!", String, "Continuar", "Salir");
		}
    }
    else
    {
        SendMessageClient(playerid, 2, "Gracias por entrar en el servidor, recuerde visitar www.ZZRoleplay.com!");
        KickEx(playerid);
    }
    return 1;
}
Dialog:Inventario(playerid, response, listitem, inputtext[])
{
    if (!response) { return true; }
    new i = listitem;
    if(i == 8){return true;}
    if(i >= 0 && i <= 7)
    {
        SacarBolsillo(playerid, i);
    }
    return true;
}
