/* ---===[- Macros & Demas -]===--- */
#include <easydialog>
#include <eSelection>
#include <streamer>
#include <zcmd>
#include <sscanf2>
#include <sampp>

#define Server_Logo      "{414344}» {FFFFFF}Ingresa tu contraseña y presiona en 'Continuar' para iniciar sesión !"
#define Server_Logo_Op   "{414344}» {FFFFFF}Ingresa una contraseña y presiona en 'Continuar' para registrar una cuenta !"
#define Server_Version   "v0.1"
#define Server_GameText  "Roleplay | v0.1"
#define Server_Web       "www.Spanish-Rol.com"
#define Server_Nombre    "[ESP/LAT] Spanish Rol ~ Los Ángeles #Oficial"
#define Server_Rcon      "11297"
#define Server_Map       "LA / SF / LV"
#define Server_Language  "Español/Spanish"
#define Server_Password  ""
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define MAX_TEXT_CHAT    (150) // [0]
#undef  MAX_PLAYERS
#define MAX_PLAYERS      (200)
#define MAX_DROP_ITEM    (500)
#define MAX_DYNAMIC_CARS (500)
#define SELECCION_SKIN_INTRO (1)
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
new MySQL:Sp_Conector;
new MusicaID[MAX_PLAYERS];
new MusicaAudio[][] =
{
	{"http://spanish-rol.com/musica/Intro1.mp3"},
	{"http://spanish-rol.com/musica/Intro2.mp3"},
	{"http://spanish-rol.com/musica/Intro3.mp3"},
	{"http://spanish-rol.com/musica/Intro4.mp3"},
	{"http://spanish-rol.com/musica/Intro5.mp3"},
	{"http://spanish-rol.com/musica/Intro6.mp3"},
	{"http://spanish-rol.com/musica/Intro7.mp3"},
	{"http://spanish-rol.com/musica/Intro8.mp3"},
	{"http://spanish-rol.com/musica/Intro9.mp3"},
	{"http://spanish-rol.com/musica/Intro10.mp3"},
	{"http://spanish-rol.com/musica/Intro11.mp3"},
	{"http://spanish-rol.com/musica/Intro12.mp3"},
	{"http://spanish-rol.com/musica/Intro13.mp3"},
	{"http://spanish-rol.com/musica/Intro14.mp3"},
	{"http://spanish-rol.com/musica/Intro15.mp3"},
	{"http://spanish-rol.com/musica/Intro16.mp3"},
	{"http://spanish-rol.com/musica/Intro17.mp3"},
	{"http://spanish-rol.com/musica/Intro18.mp3"},
	{"http://spanish-rol.com/musica/Intro19.mp3"},
	{"http://spanish-rol.com/musica/Intro20.mp3"}
};
new COLOR_MESSAGES[7] =
{
    0xE74C3CFF,      // 0 - COLOR ERROR
    0xFFFFFFFF,      // 1 - COLOR AYUDA
    0x7D7D80F6,      // 2 - COLOR INFORMACIÓN
    0x009C00FF,      // 3 - COLOR AFIRMATIVO
    0xFFFFFFFF,      // 4 - COLOR TIPS
    0x7D7D80F6,		 // 5 - COLOR TIPO DE USO
    0x7D7D80F6       // 6 - COLOR ADMINISTRACIÓN
};
new Musica[][] =
{
	{"Abstract - I'm Good (ft. RoZe) (Prod. Drumma Battalion)"},
	{"Abstract - Neverland (ft. Ruth B) (Prod. Blulake)"},
	{"Logic - Are You Ready (feat. Phil Ade)"},
	{"ODESZA - Say My Name (Luke Christopher Remix)"},
	{"Abstract - Still Woke (ft. RoZe) (Prod. Drumma Battalion)"},
	{"Abstract - Scars (ft. RoZe) (Prod. Drumma Battalion)"},
	{"Abstract - 22 (feat. Delaney) (Prod. Blulake)"},
	{"Abstract - Do The Math"},
	{"Abstract - Radio (ft. RoZe) (Prod. Drumma Battalion)"},
	{"Mario M - Good Morning (Abstract Remix)"},
	{"Abstract - I Wrote You A Letter (Prod. Blulake)"},
	{"Abstract - So Slow (Prod. Craig McAllister)"},
	{"Abstract - Uncharted ft. Mitch (Prod. Craig McAllister)"},
	{"Abstract - Phoenix (Prod. Craig McAllister)"},
	{"Abstract - Have A Nice Day (ft. RoZe) (Prod. Drumma Battalion)"},
	{"Abstract - Hands Up (ft. RoZe) (Prod. Drumma Battalion)"},
	{"Abstract - Lois Lane (ft. Melissa Jo) (Prod. Craig McAllister)"},
	{"Abstract - XOXO (ft. Joint Inc) (Prod. Drumma Battalion)"},
	{"Abstract - The Miracle In A Sunbeam (Prod. Craig McAllister)"},
	{"Abstract - Prologue (Prod. Craig McAllister)"}
};
/*new Sex_SkinsMasculinos[185] = {
	1, 2, 3, 4, 5, 6, 7, 8, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
	30, 32, 33, 34, 35, 36, 37, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 57, 58, 59, 60,
	61, 62, 66, 68, 72, 73, 78, 79, 80, 81, 82, 83, 84, 94, 95, 96, 97, 98, 99, 100, 101, 102,
	103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120,
	121, 122, 123, 124, 125, 126, 127, 128, 132, 133, 134, 135, 136, 137, 142, 143, 144, 146,
	147, 153, 154, 155, 156, 158, 159, 160, 161, 162, 167, 168, 170, 171, 173, 174, 175, 176,
	177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 200, 202, 203, 204, 206,
	208, 209, 210, 212, 213, 217, 220, 221, 222, 223, 228, 229, 230, 234, 235, 236, 239, 240,
	241, 242, 247, 248, 249, 250, 253, 254, 255, 258, 259, 260, 261, 262, 268, 272, 273, 289,
	290, 291, 292, 293, 294, 295, 296, 297, 299
};

new Sex_SkinsFemeninos[77] = {
    9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 63, 64, 65, 69,
    75, 76, 77, 85, 88, 89, 90, 91, 92, 93, 129, 130, 131, 138, 140, 141,
    145, 148, 150, 151, 152, 157, 169, 178, 190, 191, 192, 193, 194, 195,
    196, 197, 198, 199, 201, 205, 207, 211, 214, 215, 216, 219, 224, 225,
    226, 231, 232, 233, 237, 238, 243, 244, 245, 246, 251, 256, 257, 263,
    298
};*/
new IdiomasNames[6][MAX_PLAYER_NAME] =
{
    "[Inglés]",
    "[Francés]",
    "[Portugués]",
    "[Italiano]",
    "[Alemán]",
    "[Japonés]"
};
new SendChatStreamColors[6] =
{
    0xF0F0F0FA,     // 1
    0xDCDCDCFA,     // 2
    0xC8C8C8FA,     // 3
    0xAFAFAFC8,     // 4
    0x9696A096,     // 5
    0x7D7D7D64      // 6
};

enum oInfo
{
	IDObjeto,
	NombreObjeto[30],
	ModeloObjeto,
	IDArma,
	Guardable,
	Arrojadizo,
	Capacidad
};
//{0, "Vacío", 0, 0, 0, 0, 0},
new ObjetoInfo[59][oInfo] = {
    {0, "Vacío", 0, 0, 0, 0, 0},
    {1, "Teléfono Amarillo", 18873, 0, 1, 0, 1},
    {2, "Teléfono Naranja", 18867, 0, 1, 0, 1},
    {3, "Teléfono Rojo", 18870, 0, 1, 0, 1},
    {4, "Teléfono Verde", 18871, 0, 1, 0, 1},
    {5, "Teléfono Dorado", 18865, 0, 1, 0, 1},
    {6, "Teléfono Gris", 18868, 0, 1, 0, 1},
    {7, "Teléfono Blanco", 18874, 0, 1, 0, 1},
    {8, "Teléfono Azul", 18872, 0, 1, 0, 1},
    {9, "Teléfono Celeste", 18866, 0, 1, 0, 1},
	{10, "Teléfono Rosa", 18869, 0, 1, 0, 1},
	{11, "Cigarrillo", 19625, 0, 0, 1, 5},
	{12, "Radio portable", 19942, 0, 1, 0, 1},
	{13, "Destornillador", 18644, 0, 1, 0, 1},
	{14, "Cargador D. Eagle", 19995, 0, 1, 0, 1},
	{15, "Cargador Clock", 19995, 0, 1, 0, 1},
	{16, "Cargador M4A1", 19995, 0, 1, 0, 1},
	{17, "Cargador MP5", 19995, 0, 1, 0, 1},
	{18, "Cargador UZI", 19995, 0, 1, 0, 1},
	{19, "Cargador TEC-9", 19995, 0, 1, 0, 1},
	{20, "Laptop", 19894, 0, 2, 0, 1},
	{21, "Cigarrillos", 19897, 0, 1, 0, 10},
	{22, "Encendedor", 19998, 0, 1, 0, 1},
	{23, "Palanca", 18634, 0, 0, 0, 1},
	{24, "Linterna", 18641, 0, 1, 0, 1},
	{25, "Martillo", 18635, 0, 1, 0, 1},
	{26, "Manzana Verde", 19576, 0, 1, 0, 5},
	{27, "Manzana", 19575, 0, 1, 0, 5},
	{28, "Llave", 19627, 0, 1, 0, 1},
	{29, "Botella de vino", 19822, 0, 0, 0, 10},
	{30, "Botella de ron", 19820, 0, 0, 0, 10},
	{31, "Botella de tequila", 19821, 0, 0, 0, 10},
	{32, "Botella de tequila", 19821, 0, 0, 0, 10},
	{33, "Botella de Whisky", 19823, 0, 0, 0, 10},
	{34, "Vaso de café", 19835, 0, 0, 0, 5},
	{35, "Kit medico", 11738, 0, 0, 0, 20},
	////////////////////////// ARMAS
	{36, "Manopla", 331, 1, 0, 0, 1},
	{37, "Bate", 336, 5, 1, 0, 1},
	{38, "Porra", 334, 3, 1, 0, 1},
	{39, "Pala", 337, 6, 1, 0, 1},
	{40, "Flores", 325, 14, 1, 0, 1},
	{41, "Dildo", 322, 11, 0, 0, 1},
	{42, "Cuchillo", 335, 3, 0, 0, 1},
	{43, "Molotov", 343, 18, 0, 0, 1},
	{44, "Granada", 342, 16, 0, 0, 1},
	{45, "Granada cegadora", 343, 17, 0, 0, 1},
	{46, "Glock 9mm", 346, 22, 0, 0, 17},
	{47, "Glock Silenciada 9mm", 347, 23, 0, 0, 17},
	{48, "Desert Eagle", 348, 24, 0, 0, 7},
	{49, "Escopeta", 349, 25, 1, 0, 8},
	{50, "Escopeta recortada", 350, 26, 1, 0, 2},
	{51, "UZI", 352, 28, 0, 0, 30},
	{52, "MP5", 353, 29, 1, 0, 30},
	{53, "AK-47", 355, 30, 1, 0, 30},
	{54, "M4A1", 356, 31, 0, 0, 30},
	{55, "TEC-9", 372, 32, 0, 0, 30},
	{56, "Rifle", 357, 33, 1, 0, 8},
	{57, "Sniper Rifle", 358, 34, 1, 0, 8},
	{58, "Spray", 365, 40, 0, 0, 500}
};
new arrCoords[100][100];

new Matriculas_L[27][] =
{
	"A","B","C","D","E","F","G","H","I","J","K","L","M","N","Ñ","O","P","Q","R","S","T","U","V","W","X","Y","Z"
};
new stock g_arrVehicleNames[][] = {
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Car", "SFPD Car", "LVPD Car",
    "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};
native IsValidVehicle(vehicleid);
