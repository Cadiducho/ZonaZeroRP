#if defined _config_included
	#endinput
#endif

#define _config_included

//#define TEST_MODE

#define SQL_Host        "127.0.0.1"
#define SQL_User        "zonauser"
#define SQL_Password    "4o3ay5"
#if !defined TEST_MODE
	#define SQL_Database "zonazero"
#else 
	#define SQL_Database "zz_pruebas"
#endif
