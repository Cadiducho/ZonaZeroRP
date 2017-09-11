/*                           -----------===============================[ - ZZ Roleplay  - ]===============================-----------
                             ///////////////////////////////////////////////////////////////////////////////////////////////////////
							 //                                     Programador: Endry Rincón                                     //
							 //                                         Mappers: N/A                                              //
							 //                                            Tipo: Roleplay                                         //
							 //                                          Arcivo: Roleplay.pwn - Roleplay.amx                      //
							 //                                    Fecha & Hora: 08/09/17 - 4:21 PM                               //
							 //                                                                                                   //
							 ///////////////////////////////////////////////////////////////////////////////////////////////////////                                */

#include <a_samp>
#include <a_mysql>

#include "./Modulos/Definiciones.pwn"
#include "./Modulos/Mapas.pwn"
#include "./Modulos/Variables.pwn"
#include "./Modulos/Comandos.pwn"
#include "./Modulos/Funciones.pwn"
#include "./Modulos/Callbacks.pwn"
#include "./Modulos/Dialogs.pwn"

main() {
}

public OnGameModeInit() {
    RealizarConexionesMySQL();
    mysql_tquery(Sp_Conector, "SELECT * FROM `vehiculos`", "CargarVehiculos", "");
	return true;
}

public OnGameModeExit() {
    DetenerConexionesMySQL();
	return true;
}
