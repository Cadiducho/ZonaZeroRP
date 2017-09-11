////////////////////////////////////////////////////////////// COMANDOS INVENTARIO
CMD:inventario(playerid, params[])
{
	return Inventario(playerid);
}
CMD:inv(playerid, params[])
    return cmd_inventario(playerid, params);
    
CMD:guardar(playerid, params[])
{
    if (!PlayersData[playerid][ManoDerecha][0])
        return SendMessageClient(playerid, 0, "No tienes nada en tu mano derecha");

    ActualizarManos(playerid);
    GuardarBolsillo(playerid, 1);
    return true;
}
CMD:tirar(playerid, params[])
{
    ActualizarManos(playerid);
    if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT){SendMessageClient(playerid, 0, "No puedes utilizar este comando en este momento"); return true;}
    if(PlayersData[playerid][ManoDerecha][0] > 0)
    {
        ActualizarManos(playerid);
        if(PlayersData[playerid][ManoDerecha][0] == 0){SendMessageClient(playerid, 0, "No tienes ning˙n objeto en tu mano derecha"); return true;}
        new ManoDer = PlayersData[playerid][ManoDerecha][0];
        new ManoDerCant = PlayersData[playerid][ManoDerecha][1];
        PlayersData[playerid][ManoDerecha][0] = 0;
        PlayersData[playerid][ManoDerecha][1] = 0;
        RemovePlayerAttachedObject(playerid, 1);
        ResetPlayerWeapons(playerid);
        new Float:X, Float:Y, Float:Z;
        GetPlayerPos(playerid, X, Y, Z);
        DropObjeto(ManoDer, ManoDerCant, X, Y-0.3, Z, PlayersData[playerid][World], PlayersData[playerid][Interior]);
    }
    else if(PlayersData[playerid][ManoIzquierda][0] > 0)
    {
        ActualizarManos(playerid);
        if(PlayersData[playerid][ManoIzquierda][0] == 0){SendMessageClient(playerid, 0, "No tienes nada en tus manos"); return true;}
        new ManoIzq = PlayersData[playerid][ManoIzquierda][0];
        new ManoIzqCant = PlayersData[playerid][ManoIzquierda][1];
        PlayersData[playerid][ManoIzquierda][0] = 0;
        PlayersData[playerid][ManoIzquierda][1] = 0;
        RemovePlayerAttachedObject(playerid, 2);
        new Float:X, Float:Y, Float:Z;
        GetPlayerPos(playerid, X, Y, Z);
        DropObjeto(ManoIzq, ManoIzqCant, X, Y+0.3, Z, PlayersData[playerid][World], PlayersData[playerid][Interior]);
    }
	Streamer_Update(playerid);
    return true;
}
CMD:recoger(playerid, params[])
{
	return RecogerObjeto(playerid);
}
CMD:slot(playerid, params[])
{
	new Slot;
	if(!sscanf(params, "i", Slot))
	{
	    if(Slot < 1 || Slot > 8) return SendMessageClient(playerid, 0, "El slot del bolsillo debe estar entre 1 y 8");

        SacarBolsillo(playerid, Slot-1);
    }
    else SendMessageClient(playerid, 5, "/Slot [ID]");
 	return true;
}
CMD:espalda(playerid, params[])
{
	return true;
}
CMD:usar(playerid, params[])
{
	return true;
}
CMD:item(playerid, params[])
{
    if(!sscanf(params, "ii", params[0], params[1]))
    {
        new item = params[0];
        if(item <= 0){SendMessageClient(playerid, 0, "El objeto no puede ser nulo o negativo"); return true;}
        if(!strlen(ObjetoInfo[item][NombreObjeto])){SendMessageClient(playerid, 0, "No existe un objeto con esa ID."); return true;}

        new cant = params[1];
        if(cant <= 0){SendMessageClient(playerid, 0, "La cantidad no puede ser nula o negativa"); return true;}
        if(PlayersData[playerid][ManoDerecha][0] > 0 && PlayersData[playerid][ManoIzquierda][0] > 0){SendMessageClient(playerid, 0, "Tus manos se encuentran totalmente ocupadas"); return true;}
        if(PlayersData[playerid][ManoDerecha][0] == 0)
        {
	        PlayersData[playerid][ManoDerecha][0] = item;
	        PlayersData[playerid][ManoDerecha][1] = cant;
	        PonerObjeto(playerid, 1, item);
	        if(ObjetoInfo[item][IDArma] > 0){GivePlayerWeapon(playerid, ObjetoInfo[item][IDArma], cant);}
        }
        else if(PlayersData[playerid][ManoDerecha][0] != 0)
        {
            PlayersData[playerid][ManoIzquierda][0] = item;
	        PlayersData[playerid][ManoIzquierda][1] = cant;
	        PonerObjeto(playerid, 2, item);
        }
	}
	else { return SendMessageClient(playerid, 5, "/Item [Objeto] [Cantidad]"); }
    return true;
}
///////////////////////////////////////////////////////////////////////// FIN COMANDOS DEL INVENTARIO
///////////////////////////////////////////////////////////////////////// COMIENZO DE COMANDOS DE CREACi”N DEL  SERVIDOR
CMD:crear(playerid, params[])
{
    if (PlayersData[playerid][Admin] < 6)
	    return SendMessageClient(playerid, 0, "No tienes acceso al comando /Crear");
	    
	static Opcion[24], String[128];
	static modelo[32], color1, color2, id = -1, faccion = 0, trabajo = 0, sirena = 0;
	static Float:x, Float:y, Float:z, Float:angle;
    if(sscanf(params, "s[24]S()[128]", Opcion, String))
 	{
 	    SendMessageClient(playerid, 5, "/Crear [Coche | Casa | Negocio | Taller | Fabrica | Gasolinera | Objeto | Puerta | Trabajo | FacciÛn]");
 	    return true;
 	}
 	
 	if (!strcmp(Opcion, "coche", true))
 	{
 	 	if (sscanf(String, "s[32]I(-1)I(-1)I(0)I(0)I(0)", modelo, color1, color2, faccion, trabajo, sirena))
 	 	 	return SendMessageClient(playerid, 5, "/Crear Coche [Nombre/Modelo] [Color_1] [Color_2] [FacciÛn] [Trabajo] [Sirena]");

 	 	if ((modelo[0] = GetVehicleModelByName(modelo)) == 0)
 	 	 	return SendMessageClient(playerid, 0, "Has ingresado una modelo inv·lido");
	            
 	 	GetPlayerPos(playerid, x, y, z);
 	 	GetPlayerFacingAngle(playerid, angle);
            
 	 	id = CreateVehicleDynamic(0, modelo[0], x, y, z, angle, color1, color2, faccion, trabajo, sirena);
            
 	 	if (id == -1)
 	 	 	return SendMessageClient(playerid, 0, "El servidor llego al m·ximo de vehÌculos creados");

 	 	SetPlayerPosEx(playerid, x, y, z + 2, angle);
 	}
	return true;
}
