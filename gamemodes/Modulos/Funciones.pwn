#define HookEx%0(%1) forward %0(%1); public %0(%1)
////////////////////////////////////////////////////////// FUNCIONES DE LOS VEHÍCULOS
CreateVehicleDynamic(dueno, modelo, Float:x, Float:y, Float:z, Float:angle, color1, color2, faccion, trabajo, sirena)
{
    for (new i = 1; i != MAX_DYNAMIC_CARS; i ++)
	{
		if (!VehiclesData[i][vCreado])
   		{
   		    if (color1 == -1)
   		        color1 = random(127);

			if (color2 == -1)
			    color2 = random(127);

   		    VehiclesData[i][vCreado] = true;
            VehiclesData[i][vModelo] = modelo;
            VehiclesData[i][vDueno] = dueno;

            VehiclesData[i][vAparcado][0] = x;
            VehiclesData[i][vAparcado][1] = y;
            VehiclesData[i][vAparcado][2] = z;
            VehiclesData[i][vAparcado][3] = angle;

            VehiclesData[i][vColor][0] = color1;
            VehiclesData[i][vColor][1] = color2;
            VehiclesData[i][vVinilo] = -1;
            VehiclesData[i][vPuertas][1] = 0;
            VehiclesData[i][vFaccion] = faccion;
            VehiclesData[i][vTrabajo] = trabajo;
            VehiclesData[i][vSirena] = sirena;
            VehiclesData[i][vAlarma] = 0;

			do {
	    		format(VehiclesData[i][vMatricula],31,"%s%d%s%s%d%s%d", Matriculas_L[random(sizeof(Matriculas_L))], random(10), Matriculas_L[random(sizeof(Matriculas_L))], Matriculas_L[random(sizeof(Matriculas_L))], random(10), Matriculas_L[random(sizeof(Matriculas_L))], random(96));
			} while ( !ExisteMatricula(VehiclesData[i][vMatricula]) );
			
            for (new j = 0; j < 14; j ++)
			{
                if (j < 8)
				{
                    VehiclesData[i][vMaleteroG][j] = 0;
                    VehiclesData[i][vMaleteroCant][j] = 0;
                }
                if (j < 2)
				{
                    VehiclesData[i][vGuantera][j] = 0;
                    VehiclesData[i][vGuantera][j] = 0;
                }
                VehiclesData[i][vTuning][j] = 0;
            }
            VehiclesData[i][vIDEx] = CreateVehicle(modelo, x, y, z, angle, color1, color2, -1, sirena);
            SetVehicleNumberPlate(i, VehiclesData[i][vMatricula]);
            SetVehicleNumberPlate(i, VehiclesData[i][vMatricula]);

            if (VehiclesData[i][vIDEx] != INVALID_VEHICLE_ID) {
                VehiculoCreado(VehiclesData[i][vIDEx]);
            }
            mysql_tquery(Sp_Conector, "INSERT INTO `vehiculos` (`Modelo`) VALUES(0)", "CreandoVehiculo", "d", i);
            return i;
		}
	}
	return -1;
}
HookEx CreandoVehiculo(carid)
{
	if (carid == -1 || !VehiclesData[carid][vCreado])
	    return 0;
	    
	VehiclesData[carid][vID] = cache_insert_id();
	GuardarVehiculo(carid);

	return 1;
}
GuardarVehiculo(carid)
{
    new Query[1000], String1[15], String2[15], String3[20], String4[50], String5[15], String6[40], String7[50], String8[15], String9[15], String10[15], String11[15], String12[15];

    format(String1, sizeof(String1), "%d,%d",
	VehiclesData[carid][vInterior][0],
	VehiclesData[carid][vInterior][1]);
	
    format(String2, sizeof(String2), "%d,%d",
	VehiclesData[carid][vWorld][0],
	VehiclesData[carid][vWorld][1]);
	
    format(String3, sizeof(String3), "%d,%d",
	VehiclesData[carid][vColor][0],
	VehiclesData[carid][vColor][1]);
	
    format(String4, sizeof(String4), "%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d",
	VehiclesData[carid][vTuning][0],
	VehiclesData[carid][vTuning][1],
	VehiclesData[carid][vTuning][2],
	VehiclesData[carid][vTuning][3],
	VehiclesData[carid][vTuning][4],
	VehiclesData[carid][vTuning][5],
	VehiclesData[carid][vTuning][6],
	VehiclesData[carid][vTuning][7],
	VehiclesData[carid][vTuning][8],
	VehiclesData[carid][vTuning][9],
	VehiclesData[carid][vTuning][10],
	VehiclesData[carid][vTuning][11],
	VehiclesData[carid][vTuning][12],
	VehiclesData[carid][vTuning][13]);
    
    format(String5, sizeof(String5), "%d,%d",
	VehiclesData[carid][vPuertas][0],
	VehiclesData[carid][vPuertas][1]);
	
	format(String6, sizeof(String6), "%d,%d,%d,%d,%d,%d,%d,%d",
	VehiclesData[carid][vMaleteroG][0],
	VehiclesData[carid][vMaleteroG][1],
	VehiclesData[carid][vMaleteroG][2],
	VehiclesData[carid][vMaleteroG][3],
	VehiclesData[carid][vMaleteroG][4],
	VehiclesData[carid][vMaleteroG][5],
	VehiclesData[carid][vMaleteroG][6],
	VehiclesData[carid][vMaleteroG][7]);

    format(String7, sizeof(String7), "%d,%d,%d,%d,%d,%d,%d,%d",
    VehiclesData[carid][vMaleteroCant][0],
    VehiclesData[carid][vMaleteroCant][1],
    VehiclesData[carid][vMaleteroCant][2],
    VehiclesData[carid][vMaleteroCant][3],
    VehiclesData[carid][vMaleteroCant][4],
    VehiclesData[carid][vMaleteroCant][5],
    VehiclesData[carid][vMaleteroCant][6],
    VehiclesData[carid][vMaleteroCant][7]);

    format(String8, sizeof(String8), "%d,%d",
	VehiclesData[carid][vGuantera][0],
	VehiclesData[carid][vGuantera][1]);

    format(String9, sizeof(String9), "%d,%d",
	VehiclesData[carid][vLuces][0],
	VehiclesData[carid][vLuces][1]);

    format(String10, sizeof(String10), "%d,%d",
	VehiclesData[carid][vGasolina][0],
	VehiclesData[carid][vGasolina][1]);
	
    format(String11, sizeof(String11), "%d,%d",
	VehiclesData[carid][vAceite][0],
	VehiclesData[carid][vAceite][1]);

    format(String12, sizeof(String12), "%d,%d",
	VehiclesData[carid][vBateria][0],
	VehiclesData[carid][vBateria][1]);
    
    mysql_format(Sp_Conector, Query, sizeof(Query),
        "UPDATE `vehiculos` SET `Modelo` = '%d', `Propietario` = '%d', `Matricula` = '%s', `X_P` = '%.4f', `Y_P` = '%.4f', `Z_P` = '%.4f', `A_P` = '%.4f', `Interior` = '%s', `World` = '%s', `POS_X` = '%.4f', `POS_Y` = '%.4f', `POS_Z` = '%.4f', `POS_A` = '%.4f', `Daños` = '%.4f', `Motor` = '%d', `Alarma` = '%d', `Color` = '%s', `Vinilo` = '%d', `Tuning` = '%s', `Sirena` = '%d', `Faccion` = '%s', `Trabajo` = '%d', `Puertas` = '%s', `MaleteroG` = '%s', `MaleteroCant` = '%s', `Guantera` = '%s', `Maletero` = '%d', `Capo` = '%d', `Luces` = '%s', `Carroceria` = '%d', `Neumaticos` = '%d', `Gasolina` = '%s', `Aceite` = '%s', `Bateria` = '%s', `Candado` = '%d', `CandadoRazon` = '%s', `Ventana` = '%d' WHERE `ID` = '%d'",\
	VehiclesData[carid][vModelo],
	VehiclesData[carid][vDueno],
	VehiclesData[carid][vMatricula],
	VehiclesData[carid][vAparcado][0],
	VehiclesData[carid][vAparcado][1],
	VehiclesData[carid][vAparcado][2],
	VehiclesData[carid][vAparcado][3],
	String1,
	String2,
	VehiclesData[carid][vPos][0],
	VehiclesData[carid][vPos][1],
	VehiclesData[carid][vPos][2],
	VehiclesData[carid][vPos][3],
	VehiclesData[carid][vDanos],
	VehiclesData[carid][vMotor],
    VehiclesData[carid][vAlarma],
    String3,
    VehiclesData[carid][vVinilo],
    String4,
    VehiclesData[carid][vSirena],
    VehiclesData[carid][vFaccion],
    VehiclesData[carid][vTrabajo],
    String5,
    String6,
    String7,
    String8,
    VehiclesData[carid][vMaletero],
    VehiclesData[carid][vCapo],
    String9,
    VehiclesData[carid][vCarroceria],
    VehiclesData[carid][vNeumaticos],
    String10,
    String11,
	String12,
    VehiclesData[carid][vCandado],
    VehiclesData[carid][vCandadoRazon],
    VehiclesData[carid][vVentana],
    VehiclesData[carid][vID]);
    mysql_tquery(Sp_Conector, Query);
	return true;
}
forward CargarVehiculos();
public CargarVehiculos()
{
	static
	    rows,
		field,
		Datos[100],
		Cargado;
		
    cache_get_row_count(rows);
    cache_get_field_count(field);
    
    for (new i = 0; i < rows; i ++) if (i < MAX_DYNAMIC_CARS)
    {
        cache_get_value_name_int(0, "ID", VehiclesData[i][vID]);
        cache_get_value_name_int(0, "Propietario", VehiclesData[i][vDueno]);
        cache_get_value_name_int(0, "Modelo", VehiclesData[i][vModelo]);
        cache_get_value_name(0, "Matricula", VehiclesData[i][vMatricula]);
        ///////////////////////////////////////////////////////////////////
        cache_get_value_name_float(0, "X_P", VehiclesData[i][vAparcado][0]);
        cache_get_value_name_float(0, "Y_P", VehiclesData[i][vAparcado][1]);
        cache_get_value_name_float(0, "Z_P", VehiclesData[i][vAparcado][2]);
        cache_get_value_name_float(0, "A_P", VehiclesData[i][vAparcado][3]);
        ///////////////////////////////////////////////////////////////////
        cache_get_value_name(0, "Interior", Datos);
        split(Datos, arrCoords, ',');
        if (i < 2)
        {
            VehiclesData[i][vInterior][i] = strval(arrCoords[i]);
		}
        ///////////////////////////////////////////////////////////////////
        cache_get_value_name(0, "World", Datos);
        split(Datos, arrCoords, ',');
        if (i < 2)
        {
            VehiclesData[i][vWorld][i] = strval(arrCoords[i]);
		}
        ///////////////////////////////////////////////////////////////////
        cache_get_value_name(0, "Color", Datos);
        split(Datos, arrCoords, ',');
        if (i < 2)
        {
            VehiclesData[i][vColor][i] = strval(arrCoords[i]);
		}
        ///////////////////////////////////////////////////////////////////
        cache_get_value_name(0, "Tuning", Datos);
        split(Datos, arrCoords, ',');
        if (i < 14)
        {
            VehiclesData[i][vTuning][i] = strval(arrCoords[i]);
		}
        ///////////////////////////////////////////////////////////////////
        cache_get_value_name(0, "Puertas", Datos);
        split(Datos, arrCoords, ',');
        if (i < 2)
        {
            VehiclesData[i][vPuertas][i] = strval(arrCoords[i]);
		}
        ///////////////////////////////////////////////////////////////////
        cache_get_value_name(0, "MaleteroG", Datos);
        split(Datos, arrCoords, ',');
        if (i < 8)
        {
            VehiclesData[i][vMaleteroG][i] = strval(arrCoords[i]);
		}
        ///////////////////////////////////////////////////////////////////
        cache_get_value_name(0, "MaleteroCant", Datos);
        split(Datos, arrCoords, ',');
        if (i < 8)
        {
            VehiclesData[i][vMaleteroCant][i] = strval(arrCoords[i]);
		}
        ///////////////////////////////////////////////////////////////////
        cache_get_value_name(0, "Guantera", Datos);
        split(Datos, arrCoords, ',');
        if (i < 2)
        {
            VehiclesData[i][vGuantera][i] = strval(arrCoords[i]);
		}
        ///////////////////////////////////////////////////////////////////
        cache_get_value_name(0, "Luces", Datos);
        split(Datos, arrCoords, ',');
        if (i < 2)
        {
            VehiclesData[i][vLuces][i] = strval(arrCoords[i]);
		}
        ///////////////////////////////////////////////////////////////////
        cache_get_value_name(0, "Gasolina", Datos);
        split(Datos, arrCoords, ',');
        if (i < 2)
        {
            VehiclesData[i][vGasolina][i] = strval(arrCoords[i]);
		}
        ///////////////////////////////////////////////////////////////////
        cache_get_value_name(0, "Aceite", Datos);
        split(Datos, arrCoords, ',');
        if (i < 2)
        {
            VehiclesData[i][vAceite][i] = strval(arrCoords[i]);
		}
        ///////////////////////////////////////////////////////////////////
        cache_get_value_name(0, "Bateria", Datos);
        split(Datos, arrCoords, ',');
        if (i < 2)
        {
            VehiclesData[i][vBateria][i] = strval(arrCoords[i]);
		}
		///////////////////////////////////////////////////////////////////
        cache_get_value_name_float(0, "POS_X", VehiclesData[i][vPos][0]);
        cache_get_value_name_float(0, "POS_Y", VehiclesData[i][vPos][1]);
        cache_get_value_name_float(0, "POS_Z", VehiclesData[i][vPos][2]);
        cache_get_value_name_float(0, "POS_A", VehiclesData[i][vPos][3]);
        ///////////////////////////////////////////////////////////////////
        cache_get_value_name_float(0, "Daños", VehiclesData[i][vDanos]);
        cache_get_value_name_int(0, "Motor", VehiclesData[i][vMotor]);
        cache_get_value_name_int(0, "Alarma", VehiclesData[i][vAlarma]);
        cache_get_value_name_int(0, "Vinilo", VehiclesData[i][vVinilo]);
        cache_get_value_name_int(0, "Sirena", VehiclesData[i][vSirena]);
        cache_get_value_name_int(0, "Faccion", VehiclesData[i][vFaccion]);
        cache_get_value_name_int(0, "Trabajo", VehiclesData[i][vTrabajo]);
        cache_get_value_name_int(0, "Maletero", VehiclesData[i][vMaletero]);
        cache_get_value_name_int(0, "Capo", VehiclesData[i][vCapo]);
        cache_get_value_name_int(0, "Carroceria", VehiclesData[i][vCarroceria]);
        cache_get_value_name_int(0, "Neumaticos", VehiclesData[i][vNeumaticos]);
        cache_get_value_name_int(0, "Candado", VehiclesData[i][vCandado]);
        cache_get_value_name(0, "CandadoRazon", VehiclesData[i][vCandadoRazon]);
        cache_get_value_name_int(0, "Ventana", VehiclesData[i][vVentana]);
        VehiclesData[i][vCreado] = 1;
        Vehiculo_Creado(i);
        Cargado++;
    }
    printf("[MySQL]> Se han cargado un total de %d vehículos", Cargado);
	return 1;
}
stock Vehiculo_Creado(carid)
{
	if (carid != -1 && VehiclesData[carid][vCreado])
	{
		if (IsValidVehicle(VehiclesData[carid][vIDEx]))
		    DestroyVehicle(VehiclesData[carid][vIDEx]);

		if (VehiclesData[carid][vColor][0] == -1)
		    VehiclesData[carid][vColor][0] = random(127);

		if (VehiclesData[carid][vColor][1] == -1)
		    VehiclesData[carid][vColor][1] = random(127);

		VehiclesData[carid][vIDEx] = CreateVehicle(VehiclesData[carid][vModelo], VehiclesData[carid][vPos][0], VehiclesData[carid][vPos][1], VehiclesData[carid][vPos][2], VehiclesData[carid][vPos][3], VehiclesData[carid][vColor][0], VehiclesData[carid][vColor][1], (VehiclesData[carid][vDueno] != 0) ? (-1) : (1200000), VehiclesData[carid][vSirena]);
        if (VehiclesData[carid][vIDEx] != INVALID_VEHICLE_ID)
        {
            if (VehiclesData[carid][vVinilo] != -1)
            {
                ChangeVehiclePaintjob(VehiclesData[carid][vIDEx], VehiclesData[carid][vVinilo]);
			}
			
            SetVehicleParamsEx(VehiclesData[carid][vIDEx], VehiclesData[carid][vMotor], VehiclesData[carid][vLuces][0], VehiclesData[carid][vAlarma], VehiclesData[carid][vPuertas][0], VehiclesData[carid][vCapo], VehiclesData[carid][vMaletero], 0);
            UpdateVehicleDamageStatus(VehiclesData[carid][vIDEx], VehiclesData[carid][vCarroceria], VehiclesData[carid][vPuertas][1], VehiclesData[carid][vLuces][1], VehiclesData[carid][vNeumaticos]);
            SetVehicleHealth(VehiclesData[carid][vIDEx], VehiclesData[carid][vDanos]);
            SetVehicleNumberPlate(VehiclesData[carid][vIDEx], VehiclesData[carid][vMatricula]);
			for (new i = 0; i < 14; i ++)
			{
			    if (VehiclesData[carid][vTuning][i]) AddVehicleComponent(VehiclesData[carid][vIDEx], VehiclesData[carid][vTuning][i]);
			}
			return 1;
		}
	}
	return 0;
}
/////////////////////////////////////////////////////////FUNCIONES DE LOS JUGADORES
stock CargarCadenaSQL(playerid, cadena[]) {
    new Query[100];
    mysql_format(Sp_Conector, Query, sizeof(Query), "SELECT * FROM `cuentas` WHERE `Nombre` = '%s'", PlayersData[playerid][Nombre]);
    mysql_query(Sp_Conector, Query);
    
    new Datos[123];
    cache_get_value_name(0, cadena, Datos);
    split(Datos, arrCoords, ',');
	if(strcmp(cadena, "Bolsillos", true) == 0)
	{
		for(new i; i < 8; i++)
		{
			PlayersData[playerid][Bolsillos][i] = strval(arrCoords[i]);
		}
	}
    else if(strcmp(cadena, "BolsillosCant", true) == 0)
	{
		for(new i; i < 8; i++)
		{
			PlayersData[playerid][BolsillosCant][i] = strval(arrCoords[i]);
		}
	}
	else if(strcmp(cadena, "ManoDerecha", true) == 0)
	{
		for(new i; i < 2; i++)
		{
			PlayersData[playerid][ManoDerecha][i] = strval(arrCoords[i]);
		}
	}
	else if(strcmp(cadena, "ManoIzquierda", true) == 0)
	{
		for(new i; i < 2; i++)
		{
			PlayersData[playerid][ManoIzquierda][i] = strval(arrCoords[i]);
		}
	}
	else if(strcmp(cadena, "Espalda", true) == 0)
	{
		for(new i; i < 2; i++)
		{
			PlayersData[playerid][Espalda][i] = strval(arrCoords[i]);
		}
	}
	else if(strcmp(cadena, "Idiomas", true) == 0)
	{
		for(new i; i < 6; i++)
		{
			PlayersData[playerid][Idiomas][i] = strval(arrCoords[i]);
		}
	}
	return true;
}
stock GuardarCadenaSQL(playerid, cadena[]) {
    new tmp[300], Query[256];
	if(strcmp(cadena, "Bolsillos", true) == 0)
	{
		format(tmp, sizeof(tmp), "%d,%d,%d,%d,%d,%d,%d,%d",
		PlayersData[playerid][Bolsillos][0],
		PlayersData[playerid][Bolsillos][1],
		PlayersData[playerid][Bolsillos][2],
		PlayersData[playerid][Bolsillos][3],
		PlayersData[playerid][Bolsillos][4],
		PlayersData[playerid][Bolsillos][5],
		PlayersData[playerid][Bolsillos][6],
		PlayersData[playerid][Bolsillos][7]);
	}
	else if(strcmp(cadena, "BolsillosCant", true) == 0)
	{
		format(tmp, sizeof(tmp), "%d,%d,%d,%d,%d,%d,%d,%d",
		PlayersData[playerid][BolsillosCant][0],
		PlayersData[playerid][BolsillosCant][1],
		PlayersData[playerid][BolsillosCant][2],
		PlayersData[playerid][BolsillosCant][3],
		PlayersData[playerid][BolsillosCant][4],
		PlayersData[playerid][BolsillosCant][5],
		PlayersData[playerid][BolsillosCant][6],
		PlayersData[playerid][BolsillosCant][7]);
	}
	else if(strcmp(cadena, "ManoDerecha", true) == 0)
	{
		format(tmp, sizeof(tmp), "%d,%d", PlayersData[playerid][ManoDerecha][0], PlayersData[playerid][ManoDerecha][1]);
	}
	else if(strcmp(cadena, "ManoIzquierda", true) == 0)
	{
		format(tmp, sizeof(tmp), "%d,%d", PlayersData[playerid][ManoIzquierda][0], PlayersData[playerid][ManoIzquierda][1]);
	}
	else if(strcmp(cadena, "Espalda", true) == 0)
	{
		format(tmp, sizeof(tmp), "%d,%d", PlayersData[playerid][Espalda][0], PlayersData[playerid][Espalda][1]);
	}
	if(strcmp(cadena, "Idiomas", true) == 0)
	{
		format(tmp, sizeof(tmp), "%d,%d,%d,%d,%d,%d",
		PlayersData[playerid][Idiomas][0],
		PlayersData[playerid][Idiomas][1],
		PlayersData[playerid][Idiomas][2],
		PlayersData[playerid][Idiomas][3],
		PlayersData[playerid][Idiomas][4],
		PlayersData[playerid][Idiomas][5]);
	}
    mysql_format(Sp_Conector, Query, sizeof(Query), "UPDATE `cuentas` SET `%s` = '%s' WHERE `ID` = '%d'", cadena, tmp, PlayersData[playerid][ID]);
    mysql_tquery(Sp_Conector, Query);
	return true;
}
stock GuardarDatosSQL(playerid) {

        new Query[600];
        GetPlayerHealth(playerid, PlayersData[playerid][Vida]);
        GetPlayerArmour(playerid, PlayersData[playerid][Chaleco]);
	    GetPlayerPos(playerid, PlayersData[playerid][Pos][0], PlayersData[playerid][Pos][1], PlayersData[playerid][Pos][2]);
	    GetPlayerFacingAngle(playerid, PlayersData[playerid][Pos][3]);
	    PlayersData[playerid][Skin] = GetPlayerSkin(playerid);
	    PlayersData[playerid][World] = GetPlayerVirtualWorld(playerid);
        PlayersData[playerid][Interior] = GetPlayerInterior(playerid);

	    new dia, mes, ano, hora, minuto, segundo;
	    getdate(ano, mes, dia);
	    gettime(hora, minuto, segundo);
        format(PlayersData[playerid][Acceso], 50, "%02d de %s del %02d a las %02d:%02d", dia, Meses(mes), ano, hora, minuto);
        
        mysql_format(Sp_Conector, Query, sizeof(Query),
		    "UPDATE `cuentas` SET `Nombre` = '%s', `NombreADM` = '%s', `IP` = '%s', `Sexo` = '%d', `Edad` = '%d', `POS_X` = '%.4f', `POS_Y` = '%.4f', `POS_Z` = '%.4f', `POS_A` = '%.4f', `Vida` = '%.4f', `Chaleco` = '%.4f', `Skin` = '%d', `Email` = '%s', `Admin` = '%d', `Dinero` = '%d', `Acceso` = '%s', `Interior` = '%d', `World` = '%d', `Idioma` = '%d' WHERE `ID` = '%d'",\
        PlayersData[playerid][Nombre],
		PlayersData[playerid][NombreADM],
		PlayersData[playerid][IP],
		PlayersData[playerid][Sexo],
		PlayersData[playerid][Edad],
		PlayersData[playerid][Pos][0],
		PlayersData[playerid][Pos][1],
		PlayersData[playerid][Pos][2],
		PlayersData[playerid][Pos][3],
		PlayersData[playerid][Vida],
		PlayersData[playerid][Chaleco],
		PlayersData[playerid][Skin],
		PlayersData[playerid][Email],
		PlayersData[playerid][Admin],
		PlayersData[playerid][Dinero],
		PlayersData[playerid][Acceso],
		PlayersData[playerid][Interior],
		PlayersData[playerid][World],
		PlayersData[playerid][Idioma],
		PlayersData[playerid][ID]);
        mysql_tquery(Sp_Conector, Query);
        GuardarCadenaSQL(playerid, "Bolsillos");
        GuardarCadenaSQL(playerid, "BolsillosCant");
        GuardarCadenaSQL(playerid, "ManoDerecha");
        GuardarCadenaSQL(playerid, "ManoIzquierda");
        GuardarCadenaSQL(playerid, "Espalda");
        return true;
}
stock CargarDatosSQL(playerid) {
    new Query[200];
    mysql_format(Sp_Conector, Query, sizeof(Query), "SELECT * FROM `cuentas` WHERE `Nombre` = '%s'", PlayersData[playerid][Nombre]);
    mysql_query(Sp_Conector, Query);
    
    cache_get_value_name(0, "NombreADM", PlayersData[playerid][NombreADM]);
    cache_get_value_name(0, "IP", PlayersData[playerid][IP]);
    cache_get_value_name_int(0, "Sexo", PlayersData[playerid][Sexo]);
    cache_get_value_name_int(0, "Edad", PlayersData[playerid][Edad]);
    cache_get_value_name_float(0, "POS_X", PlayersData[playerid][Pos][0]);
    cache_get_value_name_float(0, "POS_Y", PlayersData[playerid][Pos][1]);
    cache_get_value_name_float(0, "POS_Z", PlayersData[playerid][Pos][2]);
    cache_get_value_name_float(0, "POS_A", PlayersData[playerid][Pos][3]);
    cache_get_value_name_float(0, "Vida", PlayersData[playerid][Vida]);
    cache_get_value_name_float(0, "Chaleco", PlayersData[playerid][Chaleco]);
    cache_get_value_name_int(0, "Skin", PlayersData[playerid][Skin]);
    cache_get_value_name(0, "Email", PlayersData[playerid][Email]);
    cache_get_value_name_int(0, "Admin", PlayersData[playerid][Admin]);
    cache_get_value_name_int(0, "Dinero", PlayersData[playerid][Dinero]);
    cache_get_value_name(0, "Acceso", PlayersData[playerid][Acceso]);
    cache_get_value_name_int(0, "Interior", PlayersData[playerid][Interior]);
    cache_get_value_name_int(0, "World", PlayersData[playerid][World]);
    cache_get_value_name_int(0, "Idioma", PlayersData[playerid][Idioma]);
    
    CargarCadenaSQL(playerid, "Bolsillos");
    CargarCadenaSQL(playerid, "BolsillosCant");
    CargarCadenaSQL(playerid, "ManoDerecha");
    CargarCadenaSQL(playerid, "ManoIzquierda");
    CargarCadenaSQL(playerid, "Espalda");
    CargarCadenaSQL(playerid, "Idiomas");
    return true;
}
stock SetPlayerPosEx(playerid, Float:PosX, Float:PosY, Float:PosZ, Float:PosA) {
	SetPlayerPos(playerid, PosX, PosY, PosZ);
	SetPlayerFacingAngle(playerid, PosA);
	return true;
}
stock CleanVariables(playerid) {
	PlayersDataOnline[playerid][StateKick] = 0;
    PlayersDataOnline[playerid][Mundo] = 0;
    return true;
}
stock SendMessageClient(playerid, type, message[])
{
	new MsgInfo[MAX_TEXT_CHAT];
	switch ( type )
	{
	    // Error
	    case 0:
	    {
	        format(MsgInfo, sizeof(MsgInfo), "ERROR: {FFFFFF}%s", message);
		}
		// Ayuda
	    case 1:
	    {
	        format(MsgInfo, sizeof(MsgInfo), "%s{FFFFFF} %s", message);
		}
		// Información
	    case 2:
	    {
	        format(MsgInfo, sizeof(MsgInfo), "Info:{FFFFFF} %s", message);
		}
		// Afirmativo
	    case 3:
	    {
	        format(MsgInfo, sizeof(MsgInfo), "Importante:{FFFFFF} %s", message);
		}
		// Tips
 	    case 4:
	    {
	        format(MsgInfo, sizeof(MsgInfo), "%s", message);
		}
		// USO
 	    case 5:
	    {
	        format(MsgInfo, sizeof(MsgInfo), "Tipo de uso:{FFFFFF} %s", message);
		}
 	    case 6:
	    {
	        format(MsgInfo, sizeof(MsgInfo), "Administración:{FFFFFF} %s", message);
		}
	}
	SendClientMessage(playerid, COLOR_MESSAGES[type], MsgInfo);
	return true;
}
stock SendChatNormal(playerid, text[], type[], idiomaid)
{
	new Float:X, Float:Y, Float:Z;
	new MsgSendChat[MAX_TEXT_CHAT];
	new MsgSendChatDesconocido[MAX_TEXT_CHAT];
	GetPlayerPos(playerid,X,Y,Z);
	format(MsgSendChat, sizeof(MsgSendChat), "%s %s %s %s", IdiomasNames[idiomaid], PlayersDataOnline[playerid][NombreFix], type, text);
	format(MsgSendChatDesconocido, sizeof(MsgSendChatDesconocido), "%s %s: [No has entendido nada]", IdiomasNames[idiomaid], PlayersDataOnline[playerid][NombreFix]);
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i,30.0,X,Y,Z))
	    {
		    if(IsPlayerInRangeOfPoint(i,5.0,X,Y,Z))
		    {
		        if ( PlayersData[i][Idiomas][idiomaid] )
		        {
		    		SendClientMessage(i, SendChatStreamColors[0],MsgSendChat);
	    		}
	    		else
	    		{
		    		SendClientMessage(i, SendChatStreamColors[0],MsgSendChatDesconocido);
				}
			}
		    else if(IsPlayerInRangeOfPoint(i,10.0,X,Y,Z))
		    {
		        if ( PlayersData[i][Idiomas][idiomaid] )
		        {
		    		SendClientMessage(i, SendChatStreamColors[1],MsgSendChat);
	    		}
	    		else
	    		{
		    		SendClientMessage(i, SendChatStreamColors[1],MsgSendChatDesconocido);
				}
			}
		    else if(IsPlayerInRangeOfPoint(i,15.0,X,Y,Z))
		    {
		        if ( PlayersData[i][Idiomas][idiomaid] )
		        {
		    		SendClientMessage(i, SendChatStreamColors[2],MsgSendChat);
	    		}
	    		else
	    		{
		    		SendClientMessage(i, SendChatStreamColors[2],MsgSendChatDesconocido);
				}
			}
		    else if(IsPlayerInRangeOfPoint(i,20.0,X,Y,Z))
		    {
		        if ( PlayersData[i][Idiomas][idiomaid] )
		        {
		    		SendClientMessage(i, SendChatStreamColors[3],MsgSendChat);
	    		}
	    		else
	    		{
		    		SendClientMessage(i, SendChatStreamColors[3],MsgSendChatDesconocido);
				}
			}
		    else if(IsPlayerInRangeOfPoint(i,25.0,X,Y,Z))
		    {
		        if ( PlayersData[i][Idiomas][idiomaid] )
		        {
		    		SendClientMessage(i, SendChatStreamColors[4],MsgSendChat);
	    		}
	    		else
	    		{
		    		SendClientMessage(i, SendChatStreamColors[4],MsgSendChatDesconocido);
				}
			}
		    else if(IsPlayerInRangeOfPoint(i,30.0,X,Y,Z))
		    {
		        if ( PlayersData[i][Idiomas][idiomaid] )
		        {
		    		SendClientMessage(i, SendChatStreamColors[5],MsgSendChat);
	    		}
	    		else
	    		{
		    		SendClientMessage(i, SendChatStreamColors[5],MsgSendChatDesconocido);
				}
			}
		}
	}
	return true;
}
stock RemoveRallaName(playerid)
{
	strmid(PlayersDataOnline[playerid][NombreFix], PlayersData[playerid][Nombre], 0, strlen(PlayersData[playerid][Nombre]), 24);
	for(new i = 0; i < MAX_PLAYER_NAME; i++)
	{
		if (PlayersDataOnline[playerid][NombreFix][i] == '_') PlayersDataOnline[playerid][NombreFix][i] = ' ';
	}
	return PlayersDataOnline[playerid][NombreFix];
}
KickEx(playerid)
{
	if (PlayersDataOnline[playerid][StateKick])
	    return 0;

	PlayersDataOnline[playerid][StateKick] = 1;
	SetTimerEx("KickTimer", 200, false, "d", playerid);

	return 1;
}
forward KickTimer(playerid);
public KickTimer(playerid)
{
	if (PlayersDataOnline[playerid][StateKick])
	{
        PlayersDataOnline[playerid][StateKick] = 0;
		return Kick(playerid);
	}
	return 0;
}
stock Meses(mes)
{
	new MesesP[24];
	switch(mes)
	{
	    case 1: MesesP = "Enero";
	    case 2: MesesP = "Febrero";
	    case 3: MesesP = "Marzo";
	    case 4: MesesP = "Abril";
	    case 5: MesesP = "Mayo";
	    case 6: MesesP = "Junio";
	    case 7: MesesP = "Julio";
	    case 8: MesesP = "Agosto";
	    case 9: MesesP = "Septiembre";
	    case 10: MesesP = "Octubre";
	    case 11: MesesP = "Noviembre";
	    case 12: MesesP = "Diciembre";
		default: MesesP = "Nel";
	}
	return MesesP;
}
stock SetTimerGlobal()
{
	new HoraGLOBAL, MinutosGLOBAL, SegundosGLOBAL;
	gettime(HoraGLOBAL, MinutosGLOBAL, SegundosGLOBAL);

	if ( HoraGLOBAL == 0 )
	{
		HoraGLOBAL = 23;
	}
	else
	{
	    HoraGLOBAL--;
	}

	SetWorldTime(HoraGLOBAL);

	new NuevaHora = ( (60 - ((MinutosGLOBAL) + 1)) * 60000 ) + ( (60 - (SegundosGLOBAL + 1) ) * 1000);
	SetTimer("SetTimerGlobal", NuevaHora, false);
	printf("[Server]> Nueva Hora: %i Minutos: %i Milisegundos: %i", HoraGLOBAL, (NuevaHora / 1000) / 60,NuevaHora );
	return true;
}
SetPlayerMoney(playerid, cantidad)
{
	PlayersData[playerid][Dinero] += cantidad;
	return 1;
}
Inventario(playerid)
{
    ActualizarManos(playerid);
    new dialog[1094], string[128], StringName[160];
	for(new i = 0; i < 8; i++)
	{
		new Bolsillus = PlayersData[playerid][Bolsillos][i];
		if(Bolsillus == 0)
		{
		    format(string, sizeof(string), "\n{FFFFFF}[{20C800}%d{FFFFFF}]: %s", i+1, ObjetoInfo[Bolsillus][NombreObjeto]);
		}
		else
		{
		    format(string, sizeof(string), "\n{FFFFFF}[{20C800}%d{FFFFFF}]: %s (%d)", i+1, ObjetoInfo[Bolsillus][NombreObjeto], PlayersData[playerid][BolsillosCant][i]);
		}
		strcat(dialog, string);
	}
	strcat(dialog, "\n  ");
	if(PlayersData[playerid][Dinero] > 0)
	{
		format(string, sizeof(string), "\n{20C800}Dinero{FFFFFF}: %s", FormatNumber(PlayersData[playerid][Dinero]));
		strcat(dialog, string);
	}
	if(PlayersData[playerid][ManoDerecha][0] > 0)
	{
		format(string, sizeof(string), "\n{20C800}Mano D{FFFFFF}: %s (%d)", ObjetoInfo[PlayersData[playerid][ManoDerecha][0]][NombreObjeto], PlayersData[playerid][ManoDerecha][1]);
		strcat(dialog, string);
	}
	if(PlayersData[playerid][ManoIzquierda][0] > 0)
	{
		format(string, sizeof(string), "\n{20C800}Mano I{FFFFFF}: %s (%d)", ObjetoInfo[PlayersData[playerid][ManoIzquierda][0]][NombreObjeto], PlayersData[playerid][ManoIzquierda][1]);
		strcat(dialog, string);
	}
	if(PlayersData[playerid][Espalda][0] > 0)
	{
		format(string, sizeof(string), "\n{20C800}Espalda{FFFFFF}: %s (%d)", ObjetoInfo[PlayersData[playerid][Espalda][0]][NombreObjeto], PlayersData[playerid][Espalda][1]);
		strcat(dialog, string);
	}
	format(StringName, sizeof(StringName), "%s - Inventario", PlayersDataOnline[playerid][NombreFix]);
	Dialog_Show(playerid, Inventario, DIALOG_STYLE_LIST, StringName, dialog, "Seleccionar", "Cerrar");
	return true;
}
stock PonerObjeto(playerid, slot, objetoid)
{
    if(slot == 1)
	{
        if(objetoid == 1) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6,0.084999,0.000000,0.013000,83.100006,176.699981,0.000000,1.000000,1.000000,1.000000);
        if(objetoid == 2) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6,0.084999,0.000000,0.013000,83.100006,176.699981,0.000000,1.000000,1.000000,1.000000);
        if(objetoid == 3) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6,0.084999,0.000000,0.013000,83.100006,176.699981,0.000000,1.000000,1.000000,1.000000);
        if(objetoid == 4) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6,0.084999,0.000000,0.013000,83.100006,176.699981,0.000000,1.000000,1.000000,1.000000);
        if(objetoid == 5) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6,0.084999,0.000000,0.013000,83.100006,176.699981,0.000000,1.000000,1.000000,1.000000);
        if(objetoid == 6) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6,0.084999,0.000000,0.013000,83.100006,176.699981,0.000000,1.000000,1.000000,1.000000);
        if(objetoid == 7) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6,0.084999,0.000000,0.013000,83.100006,176.699981,0.000000,1.000000,1.000000,1.000000);
        if(objetoid == 8) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6,0.084999,0.000000,0.013000,83.100006,176.699981,0.000000,1.000000,1.000000,1.000000);
        if(objetoid == 9) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6,0.084999,0.000000,0.013000,83.100006,176.699981,0.000000,1.000000,1.000000,1.000000);
        if(objetoid == 10) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6,0.084999,0.000000,0.013000,83.100006,176.699981,0.000000,1.000000,1.000000,1.000000);
        if(objetoid == 11) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto],6,0.096000,0.001999,0.042999,0.000000,0.000000,31.100009,1.000000,1.000000,1.000000);
        if(objetoid == 12) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto],6,0.051999,0.034000,0.026000,0.000000,0.000000,-176.200027,1.000000,1.000000,1.000000);
        if(objetoid == 13) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,0.070999,0.020000,0.016000,176.999969,0.000000,0.000000,1.000000,1.000000,1.000000);
        if(objetoid == 14) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,0.064999,0.021999,0.053999,169.300018,-12.100000,88.999969,1.000000,1.000000,1.000000);
        if(objetoid == 15) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,0.064999,0.021999,0.053999,169.300018,-12.100000,88.999969,1.000000,1.000000,1.000000);
        if(objetoid == 16) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,0.064999,0.021999,0.053999,169.300018,-12.100000,88.999969,1.000000,1.000000,1.000000);
        if(objetoid == 17) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,0.064999,0.021999,0.053999,169.300018,-12.100000,88.999969,1.000000,1.000000,1.000000);
        if(objetoid == 18) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,0.064999,0.021999,0.053999,169.300018,-12.100000,88.999969,1.000000,1.000000,1.000000);
        if(objetoid == 19) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,0.064999,0.021999,0.053999,169.300018,-12.100000,88.999969,1.000000,1.000000,1.000000);
        if(objetoid == 20) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,-0.037000,0.069999,0.000000,-83.900001,-176.399932,-75.699943,1.000000,1.000000,1.000000);
        if(objetoid == 21) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,0.060999,0.017000,0.033000,-97.200019,0.000000,0.000000,1.000000,1.000000,1.000000);
        if(objetoid == 22) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,0.053999,0.035000,0.025000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000);
        if(objetoid == 23) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,0.074999,0.039000,0.000000,106.699989,-91.099990,0.000000,1.000000,1.000000,1.000000);
        if(objetoid == 24) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,0.068999,0.019000,0.084999,-178.899932,0.000000,0.000000,1.000000,1.000000,1.000000);
        if(objetoid == 25) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000);
        if(objetoid == 26) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,0.059000,0.033000,0.032000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000);
//        if(objetoid == 27) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],76,6,0.059000,0.033000,0.032000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000);
        if(objetoid == 27) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,0.075999,0.037000,0.034000,0.000000,86.800003,0.000000,1.000000,1.000000,1.000000);
        if(objetoid == 28) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,0.075999,0.037000,0.034000,0.000000,86.800003,0.000000,1.000000,1.000000,1.000000);
        if(objetoid == 29) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,0.054999,0.041000,-0.098000,0.000000,0.000000,0.000000,0.599000,0.599000,0.660000);
        if(objetoid == 30) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,0.053999,0.048999,-0.107000,0.000000,0.000000,0.000000,0.622999,0.578000,0.634999);
        if(objetoid == 31) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,0.049999,0.036000,-0.110999,0.000000,0.000000,0.000000,0.641000,0.617999,0.660999);
        if(objetoid == 32) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,0.049999,0.036000,-0.110999,0.000000,0.000000,0.000000,0.641000,0.617999,0.660999);
        if(objetoid == 33) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,0.055999,0.022000,-0.068000,0.000000,0.000000,0.000000,0.725999,0.659999,0.630999);
		if(objetoid == 34) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,0.039999,0.049999,0.030000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000);
		if(objetoid == 35) SetPlayerAttachedObject(playerid,1,ObjetoInfo[objetoid][ModeloObjeto],6,0.207000,0.020000,0.052999,0.000000,-103.300010,0.000000,0.645000,0.659000,0.570000);
		if(objetoid == 36) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);
	    if(objetoid == 37) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);
	    if(objetoid == 38) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);
	    if(objetoid == 39) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);
	    if(objetoid == 40) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);
	    if(objetoid == 41) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);
	    if(objetoid == 42) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);
	    if(objetoid == 43) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);
	    if(objetoid == 44) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);
	    if(objetoid == 45) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);
	    if(objetoid == 46) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);
	    if(objetoid == 47) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);
	    if(objetoid == 48) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);
	    if(objetoid == 49) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);
	    if(objetoid == 50) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);
	    if(objetoid == 51) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);
	    if(objetoid == 52) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);
		if(objetoid == 53) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);
		if(objetoid == 54) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);
		if(objetoid == 55) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);
		if(objetoid == 56) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);
		if(objetoid == 57) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);
		if(objetoid == 58) SetPlayerAttachedObject(playerid, 1, ObjetoInfo[objetoid][ModeloObjeto], 6);

	}
	if(slot == 2)
	{
	    if(objetoid == 1) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.024999,0.000000,-0.005999,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000); //Armas
        if(objetoid == 2) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,-0.040000,0.067000,-0.003000,-29.899999,152.000000,176.000030,1.000000,1.000000,1.000000);
	    if(objetoid == 3) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.000000,0.059999,-0.022000,161.599990,10.700001,5.800002,1.000000,1.000000,1.000000);
	    if(objetoid == 4) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.180999,0.000000,0.017999,0.000000,177.800018,-8.799996,1.000000,1.000000,1.000000);
	    if(objetoid == 5) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.135999,0.030999,0.053999,-17.900001,153.800018,0.000000,1.000000,1.000000,1.000000);
	    if(objetoid == 6) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.041999,0.051999,-0.080000,-27.899986,155.800018,-167.499938,1.000000,1.000000,1.000000);
	    if(objetoid == 7) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.156999,0.092000,0.071999,-25.099998,172.899963,-19.899995,1.000000,1.000000,1.000000);
	    if(objetoid == 8) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.058000,0.008000,-0.109000,-27.999998,155.100036,172.699966,1.000000,1.000000,1.000000);
	    if(objetoid == 9) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.000000,0.078999,-0.009000,155.599990,7.200000,4.800000,1.000000,1.000000,1.000000);
	    if(objetoid == 10) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.015000,0.041000,-0.068000,-25.599971,162.900054,-175.300018,1.000000,1.000000,1.000000);
        if(objetoid == 11) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.023999,0.052999,-0.041999,157.899978,2.499999,0.000000,1.000000,1.000000,1.000000);
	    if(objetoid == 12) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,-0.002000,0.074000,0.001000,151.200042,23.000000,-9.100001,1.000000,1.000000,1.000000);
	    if(objetoid == 13) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.017999,0.003999,-0.047999,168.200012,18.300003,-27.900005,1.000000,1.000000,1.000000);
        if(objetoid == 14) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.176000,0.000000,-0.011000,-23.399999,160.599990,-6.399995,1.000000,1.000000,1.000000);
	    if(objetoid == 15) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.008999,-0.018999,-0.047999,-33.199996,159.900085,156.399902,1.000000,1.000000,1.000000);
	    if(objetoid == 16) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.019000,0.047000,-0.021000,164.499984,0.000000,-17.599994,1.000000,1.000000,1.000000);
	    if(objetoid == 17) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.034000,0.063000,-0.037999,164.500000,14.599996,-4.700009,1.000000,1.000000,1.000000);
	    if(objetoid == 18) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.022999,0.039000,-0.125999,165.700012,0.000000,0.000000,1.000000,1.000000,1.000000);
	    if(objetoid == 19) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.033000,0.057999,-0.017999,146.299987,14.999998,-4.700002,1.000000,1.000000,1.000000);
	    if(objetoid == 20) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.050999,0.038000,-0.021999,144.500015,9.100000,-11.600002,1.000000,1.000000,1.000000);
	    if(objetoid == 21) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.041000,0.038000,-0.026999,173.899963,0.000000,1.799999,1.000000,1.000000,1.000000);
	    if(objetoid == 22) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.000000,0.089000,0.000000,153.500015,10.000001,4.800000,1.000000,1.000000,1.000000);
        if(objetoid == 23) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.040000,0.026000,0.011000,-156.300003,0.000000,2.600000,1.000000,1.000000,1.000000);
	    if(objetoid == 24) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.023000,0.048999,-0.013000,172.200012,14.400005,0.599999,1.000000,1.000000,1.000000);
	    if(objetoid == 25) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.024999,0.048000,-0.012000,172.000076,-3.099988,-2.099991,1.000000,1.000000,1.000000);
	    if(objetoid == 26) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.005000,0.065000,-0.016000,162.399963,9.599999,8.400000,1.000000,1.000000,1.000000);
	    if(objetoid == 27) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.057999,0.076999,-0.023999,162.799942,14.399999,0.000000,1.000000,1.000000,1.000000);
	    if(objetoid == 28) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.043999,0.028999,-0.038000,167.499969,15.999998,0.000000,1.000000,1.000000,1.000000);
	    if(objetoid == 29) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.048000,0.049999,0.011000,-172.600006,-2.299995,5.999999,1.000000,1.000000,1.000000);
        if(objetoid == 30) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,-0.043000,0.065999,-0.044999,167.499954,17.399999,0.000000,1.000000,1.000000,1.000000);
        if(objetoid == 31) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,-0.018000,0.085000,0.033000,167.399978,12.200000,-0.299997,1.000000,1.000000,1.000000);
        if(objetoid == 32) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,-0.022000,0.087999,0.006999,154.899978,20.799997,-0.300001,1.000000,1.000000,1.000000);
        if(objetoid == 33) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.047000,0.057000,-0.038000,133.699981,17.199989,2.099999,1.000000,1.000000,1.000000);
        if(objetoid == 34) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.036999,0.026999,-0.079999,152.899993,14.900004,-0.400000,1.000000,1.000000,1.000000);
        if(objetoid == 35) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.004000,0.061999,-0.063999,126.599990,33.099998,2.200000,1.000000,1.000000,1.000000);
        if(objetoid == 36) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.018000,0.062999,0.074999,-109.400039,0.000000,0.000000,1.000000,1.000000,1.000000);
        if(objetoid == 37) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.018000,0.062999,0.074999,-109.400039,0.000000,0.000000,1.000000,1.000000,1.000000);
        if(objetoid == 38) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.050999,0.038000,-0.021999,144.500015,9.100000,-11.600002,1.000000,1.000000,1.000000);

		if(objetoid >= 39 && objetoid <= 43) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.092000,0.038000,-0.026000,-37.200008,82.199996,3.499996,0.649999,0.910999,0.476999); //Cargador pequeño
        if(objetoid >= 44 && objetoid <= 46) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.092000,0.038000,-0.026000,-37.200008,82.199996,3.499996,0.649999,0.910999,0.476999); //Cargador grande
        if(objetoid >= 47 && objetoid <= 49) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.067999,0.053999,-0.006999,-110.800018,-20.899999,3.499995,0.482998,0.710998,0.414999); //Munición pequeña
	    if(objetoid == 50) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.129999,0.076999,-0.022999,-108.799964,163.299972,3.499995,0.484999,0.847999,0.408999); //Munición escopeta
		if(objetoid >= 51 && objetoid <= 53) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.145999,0.071999,-0.008000,-107.200004,172.799987,3.499995,0.445999,0.910999,0.476999); //Munición grande

		if(objetoid == 54) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.034000,0.063000,-0.037999,164.500000,14.599996,-4.700009,1.000000,1.000000,1.000000); //Granada cegadora

		if(objetoid >= 55 && objetoid <= 57) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.216999,0.037999,-0.002999,-13.699973,-98.399971,3.000000,0.839000,0.423999,0.645000); //Doritos, patatas y nachos
		if(objetoid == 58 || objetoid == 59) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.072000,0.036999,-0.026000,-11.800009,175.100036,3.000000,1.000000,1.000000,1.000000); //Sprunk y fanta
		if(objetoid == 60) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.134000,0.001999,-0.122000,-37.200008,-149.699951,-37.999996,1.000000,1.000000,1.000000); //Botella agua
		if(objetoid == 61) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.092000,0.114000,0.069000,-37.200008,-173.000015,3.499995,1.000000,1.000000,1.000000); //Botella cerveza
		if(objetoid == 62) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.077000,0.037999,-0.026000,-37.200008,-174.300003,3.499995,1.000000,1.000000,1.000000); //Copa vino
		if(objetoid == 63 || objetoid == 64) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.081000,0.037999,-0.012999,-37.200008,172.500061,3.499995,1.000000,1.000000,1.000000); //Vaso de whisky y ron
		if(objetoid == 65) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.125999,0.037999,-0.006999,-143.300033,-3.300006,144.699966,1.000000,1.000000,0.833999); //Hamburguesa
		if(objetoid == 66) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.092000,0.037999,-0.026000,-37.200008,82.199996,-175.000000,1.000000,1.000000,1.000000); //Burrito
		if(objetoid == 67) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.293000,0.108000,-0.049999,-116.499977,170.400054,3.799995,1.000000,1.000000,1.000000); //Pizza
		if(objetoid == 68) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.144999,-0.009999,0.027000,-23.500009,-173.399993,3.499995,1.000000,1.000000,1.000000); //Móvil
		if(objetoid == 69) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.036000,0.037999,0.054999,-37.200008,82.199996,3.499995,1.000000,1.000000,1.000000); //Mechero
		if(objetoid == 70) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.092000,0.038000,-0.026000,-37.200008,82.199996,3.499996,1.000000,1.000000,1.000000); //Cigarrillos
		if(objetoid == 71) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.092000,0.096000,0.066999,-25.500007,179.099990,3.499995,1.000000,1.000000,1.000000); //Botella de ron
		if(objetoid == 72) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.092000,0.092000,0.045000,-37.200008,-165.699996,3.499995,1.000000,1.000000,1.000000); //Botella de whisky
		if(objetoid == 73) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.072000,0.037999,-0.038000,-15.100006,-158.999984,3.499995,1.000000,1.000000,1.000000); //Botella de vino
		if(objetoid == 74) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.092000,0.037999,-0.026000,-37.200008,-18.400012,3.499995,1.000000,1.000000,1.000000); //Destornillador

		if(objetoid >= 75 && objetoid <= 79) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.150000,0.002999,-0.026000,-117.300010,-4.899999,81.599998,0.703999,0.758000,0.787999); //Fardos droga
		if(objetoid >= 80 && objetoid <= 84) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.036000,0.037999,0.054999,-37.200008,82.199996,3.499995,1.000000,1.000000,1.000000); //Bolsitas droga
		if(objetoid == 85) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.036000,0.037999,0.054999,-37.200008,82.199996,3.499995,1.000000,1.000000,1.000000); //Semillas maria y coca
		if(objetoid == 86) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.146999,0.037999,-0.098000,-37.200008,170.300018,3.499995,0.533999,0.475000,0.656000); //Planta maria

		if(objetoid >= 87 && objetoid <= 101) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,-0.014999,-0.005999,-0.018000,-35.700012,82.199996,-68.900001,1.038000,1.230000,1.000000); //Relojes
		if(objetoid >= 102 && objetoid <= 124) SetPlayerAttachedObject(playerid,2,ObjetoInfo[objetoid][ModeloObjeto],5,0.171999,0.079999,-0.111999,-124.399993,166.300018,-93.599990,1.038999,0.752000,0.854999); //Cajas de armamento
	}
	if(slot == 3)
	{
		if(ObjetoInfo[objetoid][IDArma] < 16){SetPlayerAttachedObject(playerid,3,ObjetoInfo[objetoid][ModeloObjeto],1, -0.1061, -0.1544, -0.0411, 0.0000, 60.0000, 60.0000, 1.0000);}
		if(ObjetoInfo[objetoid][IDArma] >= 16){SetPlayerAttachedObject(playerid,3,ObjetoInfo[objetoid][ModeloObjeto],1, -0.1061, -0.1544, -0.0411, 0.0000, 0.0000, 0.0000, 1.0000);}
	}
	return true;
}
ActualizarManos(playerid)
{
	new ManoDer = PlayersData[playerid][ManoDerecha][0], ManoDerCant = PlayersData[playerid][ManoDerecha][1];
	if(ManoDer > 0 && ObjetoInfo[ManoDer][IDArma] > 0)
	{
	    PlayersData[playerid][ManoDerecha][1] = GetPlayerWeaponAmmo(playerid, ObjetoInfo[ManoDer][IDArma]);
	}
	if(ManoDer == 0){RemovePlayerAttachedObject(playerid, 1);}

	if(ObjetoInfo[ManoDer][Arrojadizo] == 1 && ManoDerCant <= 0)
	{
		PlayersData[playerid][ManoDerecha][0] = 0;
		PlayersData[playerid][ManoDerecha][1] = 0;
		RemovePlayerAttachedObject(playerid, 1);
	}

	if(ManoDer > 0 && ManoDer < sizeof(ObjetoInfo))
	{
	    if(ManoDerCant > ObjetoInfo[ManoDer][Capacidad])
	    {
	        if(ObjetoInfo[ManoDer][IDArma] > 0){ResetPlayerWeapons(playerid), GivePlayerWeapon(playerid, ObjetoInfo[ManoDer][IDArma], ObjetoInfo[ManoDer][Capacidad]);}
	        PlayersData[playerid][ManoDerecha][1] = ObjetoInfo[ManoDer][Capacidad];
	    }
	   /* if(ManoDer < 19 && ManoDerCant <= 0)
		{
		    GivePlayerWeapon(playerid, ObjetoInfo[ManoDer][IDArma], 1);
		}*/
	}

	new ManoIzq = PlayersData[playerid][ManoIzquierda][0], ManoIzqCant = PlayersData[playerid][ManoIzquierda][1];
	if(ManoIzq == 0){RemovePlayerAttachedObject(playerid, 2);}
	if(ManoIzq > 0 && ManoIzq < sizeof(ObjetoInfo))
	{
	    if(ManoIzqCant > ObjetoInfo[ManoIzq][Capacidad])
	    {
	        PlayersData[playerid][ManoIzquierda][1] = ObjetoInfo[ManoIzq][Capacidad];
	    }
	   /* if(ManoIzq < 19 && ManoIzqCant <= 0){PlayersData[playerid][ManoIzquierda] = 1;}*/
	}
	if(ObjetoInfo[ManoIzq][Arrojadizo] == 1 && ManoIzqCant <= 0)
	{
		PlayersData[playerid][ManoIzquierda][0] = 0;
		PlayersData[playerid][ManoIzquierda][1] = 0;
		RemovePlayerAttachedObject(playerid, 2);
	}
}
stock GetPlayerWeaponAmmo(playerid, weapon)
{
    new wdata[13][2];
    for(new i; i < 13; i++)
    {
        GetPlayerWeaponData(playerid, i, wdata[i][0], wdata[i][1]);
        if(wdata[i][0] == weapon)return wdata[i][1];
    }
    return 0;
}
SacarBolsillo(playerid, id)
{
    ActualizarManos(playerid);
    new Bol = PlayersData[playerid][Bolsillos][id];
	new Cant = PlayersData[playerid][BolsillosCant][id];
    if(Bol == 0) return true;
    if(PlayersData[playerid][ManoDerecha][0] == 0)
    {
   	    if(ObjetoInfo[Bol][IDArma] > 0)
		{
			new arma = ObjetoInfo[Bol][IDArma], municion = Cant;
			if(municion > 0){GivePlayerWeapon(playerid, arma, municion);}
		}
		PlayersData[playerid][ManoDerecha][0] = Bol;
		PlayersData[playerid][ManoDerecha][1] = Cant;
		PonerObjeto(playerid, 1, Bol);
		PlayersData[playerid][Bolsillos][id] = 0;
		PlayersData[playerid][BolsillosCant][id] = 0;
        return true;
	}
	else if(PlayersData[playerid][ManoIzquierda][0] == 0)
	{
		PlayersData[playerid][ManoDerecha][0] = Bol;
		PlayersData[playerid][ManoDerecha][1] = Cant;
		PonerObjeto(playerid, 2, Bol);
		PlayersData[playerid][Bolsillos][id] = 0;
		PlayersData[playerid][BolsillosCant][id] = 0;
	}
	else
	{
		SendMessageClient(playerid, 0, "Tus manos se encuentran ocupadas"); return true;
	}
	return true;
}
FormatNumber(number, prefix[] = "$")
{
	static
		value[32],
		length;

	format(value, sizeof(value), "%d", (number < 0) ? (-number) : (number));

	if ((length = strlen(value)) > 3)
	{
		for (new i = length, l = 0; --i >= 0; l ++) {
		    if ((l > 0) && (l % 3 == 0)) strins(value, ",", i + 1);
		}
	}
	if (prefix[0] != 0)
	    strins(value, prefix, 0);

	if (number < 0)
		strins(value, "-", 0);

	return value;
}
stock split(const strsrc[], strdest[][], delimiter = '|')
{
	new i, li, aNum, len, srclen = strlen(strsrc);
	while(i <= srclen)
	{
		if (strsrc[i] == delimiter || i == srclen)
		{
			len = strmid(strdest[aNum], strsrc, li, i, 128);
			strdest[aNum][len] = 0;
			li = i + 1;
			aNum++;
		}
		i++;
	}
}
RecogerObjeto(playerid)
{
	if(PlayersData[playerid][ManoDerecha][0] > 0 && PlayersData[playerid][ManoIzquierda][0] > 0){SendMessageClient(playerid, 0, "Tienes tus manos ocupadas. Guarda algo primero"); return true;}
	new ObjetoRecogido;
	for(new i = 0; i < sizeof(DropInfo); i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.0,DropInfo[i][DropPosX],DropInfo[i][DropPosY],DropInfo[i][DropPosZ]))
		{
			if(GetPlayerVirtualWorld(playerid) == DropInfo[i][DropVWorld] && GetPlayerInterior(playerid) == DropInfo[i][DropInterior])
			{
			    if(DropInfo[i][DropID] == 0) break;
				DestroyDynamicObject(DropObject[i]);
				if(PlayersData[playerid][ManoDerecha][0] == 0)
				{
				    PlayersData[playerid][ManoDerecha][0] = DropInfo[i][DropID], PlayersData[playerid][ManoDerecha][1] = DropInfo[i][DropCantidad];
					if(ObjetoInfo[DropInfo[i][DropID]][IDArma] > 0 && DropInfo[i][DropCantidad] > 0){GivePlayerWeapon(playerid,ObjetoInfo[DropInfo[i][DropID]][IDArma],DropInfo[i][DropCantidad]);}
					PonerObjeto(playerid, 1, DropInfo[i][DropID]);
				}
				else if(PlayersData[playerid][ManoIzquierda][0] == 0)
				{
				    PlayersData[playerid][ManoIzquierda][0] = DropInfo[i][DropID], PlayersData[playerid][ManoIzquierda][1] = DropInfo[i][DropCantidad];
					PonerObjeto(playerid, 2, DropInfo[i][DropID]);
				}
				DropInfo[i][DropPosX] = 0.0;
				DropInfo[i][DropPosY] = 0.0;
				DropInfo[i][DropPosZ] = 0.0;
				DropInfo[i][DropID] = 0;
				DropInfo[i][DropCantidad] = 0;
				Streamer_Update(playerid);
				ObjetoRecogido = 1;
				break;
			}
		}
	}
	if(ObjetoRecogido == 0){SendMessageClient(playerid, 0, "No hay ningún objeto a tu alrededor con la posibilidad de tomarlo"); return true;}
	return true;
}
GuardarBolsillo(playerid, mano)
{
    ActualizarManos(playerid);
    if(mano == 1)
    {
        if(PlayersData[playerid][ManoDerecha][0] == 0){SendMessageClient(playerid, 0, "No tienes nada para guardar"); return true;}
		new Mano = PlayersData[playerid][ManoDerecha][0];
		new Cant = PlayersData[playerid][ManoDerecha][1];
		if(ObjetoInfo[Mano][Guardable] == 0 || ObjetoInfo[Mano][Guardable] == 2){SendMessageClient(playerid, 0, "Este objeto es demasiado grande como para guardarlo en el inventario"); return true;}
        new BolsilloLibre;
		for(new x = 0; x < 8; x++)
		{
			if(PlayersData[playerid][Bolsillos][x] == 0)
			{
			    PlayersData[playerid][Bolsillos][x] = Mano;
			    PlayersData[playerid][BolsillosCant][x] = Cant;
			    RemovePlayerAttachedObject(playerid, 1);
			    if(ObjetoInfo[Mano][IDArma] > 0)
		        {
					Cant = GetPlayerAmmo(playerid);
					RemovePlayerWeapon(playerid, ObjetoInfo[Mano][IDArma]);
		        }
			    PlayersData[playerid][ManoDerecha][0] = 0;
			    PlayersData[playerid][ManoDerecha][1] = 0;
			    BolsilloLibre = 1;
			    return true;
			}
		}
		if(BolsilloLibre == 0){SendMessageClient(playerid, 0, "Tu inventario se encuentra lleno"); return true;}
	}
	else if(mano == 2)
	{
	    if(PlayersData[playerid][ManoIzquierda][0] == 0){SendMessageClient(playerid, 0, "No tienes nada para guardar"); return true;}
		new Mano = PlayersData[playerid][ManoIzquierda][0];
		new Cant = PlayersData[playerid][ManoIzquierda][1];
		if(ObjetoInfo[Mano][Guardable] == 0 || ObjetoInfo[Mano][Guardable] == 2){SendMessageClient(playerid, 0, "Este objeto es demasiado grande como para guardarlo en el inventario"); return true;}
		new BolsilloLibre;
		for(new x = 0; x < 8; x++)
		{
			if(PlayersData[playerid][Bolsillos][x] == 0)
			{
			    PlayersData[playerid][Bolsillos][x] = Mano;
			    PlayersData[playerid][BolsillosCant][x] = Cant;
			    RemovePlayerAttachedObject(playerid, 2);
			    PlayersData[playerid][ManoIzquierda][0] = 0;
			    PlayersData[playerid][ManoIzquierda][1] = 0;
			    BolsilloLibre = 1;
			    return true;
			}
		}
		if(BolsilloLibre == 0){SendMessageClient(playerid, 0, "Tu inventario se encuentra lleno"); return true;}
	}
	return true;
}
stock RemovePlayerWeapon(playerid, weaponid)
{
    if(!IsPlayerConnected(playerid) || weaponid < 0 || weaponid > 50)
        return;
    new saveweapon[13], saveammo[13];
    for(new slot = 0; slot < 13; slot++)
        GetPlayerWeaponData(playerid, slot, saveweapon[slot], saveammo[slot]);
    ResetPlayerWeapons(playerid);
    for(new slot; slot < 13; slot++)
    {
        if(saveweapon[slot] == weaponid || saveammo[slot] == 0)
            continue;
        GivePlayerWeapon(playerid, saveweapon[slot], saveammo[slot]);
    }
    GivePlayerWeapon(playerid, 0, 1);
}
stock DropObjeto(ObjetoID, Cantidad, Float:X, Float:Y, Float:Z, world, interior)
{
    if(ObjetoID != 0)
    {
        new Float:rotx, Float:roty, Float:rotz;
        for(new i = 0; i < sizeof(DropInfo); i++)
        {
            if(DropInfo[i][DropPosX] == 0.0 && DropInfo[i][DropPosY] == 0.0 && DropInfo[i][DropPosZ] == 0.0)
            {
                DropInfo[i][DropID] = ObjetoID;
                DropInfo[i][DropCantidad] = Cantidad;
                DropInfo[i][DropPosX] = X;
                DropInfo[i][DropPosY] = Y;
                DropInfo[i][DropPosZ] = Z;
                DropInfo[i][DropVWorld] = world;
                DropInfo[i][DropInterior] = interior;
                rotx = 80;
                roty = 0;
                rotz = 0;

                if(ObjetoID >= 47 && ObjetoID <= 49) rotx = 0;
                if(ObjetoID >= 50 && ObjetoID <= 53) rotx = 0; Z+=0.02;
                if(ObjetoID == 67) rotx = 0;
                if(ObjetoID >= 75 && ObjetoID <= 79) rotx = 0;
                if(ObjetoID >= 102 && ObjetoID <= 124) rotx = 0; Z+=0.02;

                DropObject[i] = CreateDynamicObject(ObjetoInfo[ObjetoID][ModeloObjeto], X, Y, Z-1, rotx, roty, rotz, world);
                SetTimerEx("DropObjetoTimer", 36000000, false, "i", i);
                return true;
            }
        }
        return true;
    }
    return true;
}
HookEx DropObjetoTimer(i)
{
    DestroyDynamicObject(DropObject[i]);
    DropInfo[i][DropPosX] = 0.0;
    DropInfo[i][DropPosY] = 0.0;
    DropInfo[i][DropPosZ] = 0.0;
    DropInfo[i][DropID] = 0;
    DropInfo[i][DropCantidad] = 0;
    return true;
}
HookEx ExisteMatricula(plate)
{
	//for (new h = 0; h != MAX_DYNAMIC_CARS; h ++)
	for (new h = 0; h < MAX_DYNAMIC_CARS; h ++)
	{
		if ( VehiclesData[h][vMatricula] == plate )
		{
		    return true;
	    }
	}
	return false;
}
GetVehicleModelByName(const name[])
{
	if (IsNumeric(name) && (strval(name) >= 400 && strval(name) <= 611))
	    return strval(name);

	for (new i = 0; i < sizeof(g_arrVehicleNames); i ++)
	{
	    if (strfind(g_arrVehicleNames[i], name, true) != -1)
	    {
	        return i + 400;
		}
	}
	return 0;
}
IsNumeric(const str[])
{
	for (new i = 0, l = strlen(str); i != l; i ++)
	{
	    if (i == 0 && str[0] == '-')
			continue;

	    else if (str[i] < '0' || str[i] > '9')
			return 0;
	}
	return 1;
}
stock VehiculoCreado(vehicleid)
{
	if (1 <= vehicleid <= MAX_VEHICLES)
	{
		if ( EsMoto(vehicleid) ) {
			VehiclesData[vehicleid][vAceite][0] = 1;
			SetMotorAceite(vehicleid, 1);
			SetVehiculoGasolina(vehicleid, 1);
		}
	}
	return 1;
}
stock SetMotorAceite(vehicleid, motor)
{
	switch (motor) {
		case 1: VehiclesData[vehicleid][vAceite][0] = 2,  VehiclesData[vehicleid][vAceite][1] = 2; // MOTOS
		case 2: VehiclesData[vehicleid][vAceite][0] = 5,  VehiclesData[vehicleid][vAceite][1] = 5; // ESTANDAR VEHÍCULOS
		case 3: VehiclesData[vehicleid][vAceite][0] = 7,  VehiclesData[vehicleid][vAceite][1] = 7; // MOTOR  AGRANDADO VEHICULOS
		case 4: VehiclesData[vehicleid][vAceite][0] = 10, VehiclesData[vehicleid][vAceite][1] = 10; // MOTOR ESTANDAR DE UN CAMIÓN
		case 5: VehiclesData[vehicleid][vAceite][0] = 15, VehiclesData[vehicleid][vAceite][1] = 15; // MOTOR AGRANDADO DE UN CAMIÓN
	}
	return true;
}
stock SetVehiculoGasolina(vehicleid, tanque)
{
	switch (tanque) {
		case 1: VehiclesData[vehicleid][vGasolina][0] = 7, VehiclesData[vehicleid][vGasolina][1] = 7; // MOTOS
		case 2: VehiclesData[vehicleid][vGasolina][0] = 75, VehiclesData[vehicleid][vGasolina][1] = 75; // ESTANDAR VEHÍCULOS
		case 3: VehiclesData[vehicleid][vGasolina][0] = 120, VehiclesData[vehicleid][vGasolina][1] = 120; // TANQUE  AGRANDADO VEHICULOS
		case 4: VehiclesData[vehicleid][vGasolina][0] = 300, VehiclesData[vehicleid][vGasolina][1] = 300; // MOTOR ESTANDAR DE UN CAMIÓN
		case 5: VehiclesData[vehicleid][vGasolina][0] = 450, VehiclesData[vehicleid][vGasolina][1] = 450; // MOTOR AGRANDADO DE UN CAMIÓN
	}
	return true;
}
stock EsMoto(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
	    case 448, 461, 462, 463, 468, 471, 521, 522, 523, 581, 586: return 1;
	}
	return 0;
}
