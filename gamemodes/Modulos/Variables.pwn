
enum _PlayersData
{
	ID,
	Nombre[24],
	NombreADM[24],
	Password[64],
	Salt[11],
	Sexo,
	Edad,
	IP[16],
	Float:Pos[4],
	Float:Vida,
	Float:Chaleco,
	Skin,
	Email[32],
	Admin,
	Dinero,
	Acceso[64],
	Interior,
	World,
	Bolsillos[8],
	BolsillosCant[8],
	ManoDerecha[2],
	ManoIzquierda[2],
	Espalda[2],
	Idioma,
	Idiomas[6]
	
};
new PlayersData[MAX_PLAYERS][_PlayersData];

enum _PlayersDataOnline
{
	NombreFix[24],
	Mundo,
	StateKick,
	bool:Logueado,
	Salt[11]
};
new PlayersDataOnline[MAX_PLAYERS][_PlayersDataOnline];

enum dData
{
    DropID,
    DropCantidad,
    Float:DropPosX,
    Float:DropPosY,
    Float:DropPosZ,
    DropVWorld,
    DropInterior
};

new DropInfo[MAX_DROP_ITEM][dData];
new DropObject[MAX_DROP_ITEM];
//////////////////////////////////////////////////////////////////////////////
enum _VehiclesData
{
    vID,
	vDueno,
	vModelo,
	vMatricula[16],
	Float:vAparcado[4],
	vInterior[2],
	vWorld[2],
	Float:vPos[4],
	Float:vDanos,
	vMotor,
	vAlarma,
	vColor[2],
	vVinilo,
	vTuning[14],
	vSirena,
	vFaccion,
	vTrabajo,
	vPuertas[2],
	vMaleteroG[8],
	vMaleteroCant[8],
	vGuantera[2],   
	vMaletero,       
	vCapo,            
	vLuces[2],
	vCarroceria,      
	vNeumaticos,     
	vGasolina[2],
	vAceite[2],
	vBateria[2],
	vCandado,
	vCandadoRazon[106],
	vVentana,
	vIDEx,
	vCreado
};
new VehiclesData[MAX_DYNAMIC_CARS][_VehiclesData];
	
	
