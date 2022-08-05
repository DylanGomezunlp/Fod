{5. A partir de un siniestro ocurrido se perdieron las actas de nacimiento y fallecimientos de
toda la provincia de buenos aires de los últimos diez años. En pos de recuperar dicha
información, se deberá procesar 2 archivos por cada una de las 50 delegaciones distribuidas
en la provincia, un archivo de nacimientos y otro de fallecimientos y crear el archivo maestro
reuniendo dicha información.
Los archivos detalles con nacimientos, contendrán la siguiente información: nro partida
nacimiento, nombre, apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula
del médico, nombre y apellido de la madre, DNI madre, nombre y apellido del padre, DNI del
padre.
En cambio, los 50 archivos de fallecimientos tendrán: nro partida nacimiento, DNI, nombre y
apellido del fallecido, matrícula del médico que firma el deceso, fecha y hora del deceso y
lugar.
Realizar un programa que cree el archivo maestro a partir de toda la información de los
archivos detalles. Se debe almacenar en el maestro: nro partida nacimiento, nombre,
apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula del médico, nombre y
apellido de la madre, DNI madre, nombre y apellido del padre, DNI del padre y si falleció,
además matrícula del médico que firma el deceso, fecha y hora del deceso y lugar. Se
deberá, además, listar en un archivo de texto la información recolectada de cada persona.
Nota: Todos los archivos están ordenados por nro partida de nacimiento que es única.
Tenga en cuenta que no necesariamente va a fallecer en el distrito donde nació la persona y
además puede no haber fallecido.}

program eje5;
const
	DIMF = 50;
type
	cadena = string[20];
	direccion = record
		calle:cadena;
		nro:integer;
		piso:integer;
		depto:integer;
		ciudad:cadena;
	end;
	fecha = record
		dia: integer;
		hora: integer;
	end;
	nacimiento = record
		nro: integer;
		nombre: cadena;
		ape: cadena;
		dicc: direccion;
		matricula: integer;
		dniMa: integer;
		nomMa:cadena;
		nomPa:cadena;
		dniPa:integer;
	end;
	
	fallecimiento = record
		nro: integer;
		dni: integer;
		nomYape: cadena;
		matricula: integer;
		hora: fecha;
		lugar: cadena;
	end;
	
	nacimientos = file of nacimiento;
    fallecimientos = file of fallecimiento;

    detalles_nacimientos = array[1..DIMF] of nacimientos;
    detalles_fallecimientos = array[1..DIMF] of fallecimientos;


    regMaestro = record
        info_nacimiento : nacimiento;
        info_fallecimiento : fallecimiento;
    end;

    maestro = file of regMaestro;

    arreglo_nacimientos = array[1..DIMF] of nacimiento;
    arreglo_decesos = array[1..DIMF] of fallecimiento;
		
