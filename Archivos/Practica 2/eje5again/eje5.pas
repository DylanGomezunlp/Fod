{se deberá procesar 2 archivos por cada una de las 50 delegaciones distribuidas
en la provincia, un archivo de nacimientos y otro de fallecimientos y crear el archivo maestro
reuniendo dicha información.
Realizar un programa que cree el archivo maestro a partir de toda la información de los
archivos detalles. Se deberá, además, listar en un archivo de texto la información recolectada de cada persona.
Nota: Todos los archivos están ordenados por nro partida de nacimiento que es única.
Tenga en cuenta que no necesariamente va a fallecer en el distrito donde nació la persona y
además puede no haber fallecido.}
program eje5;

const 
	DIMF = 50;
	valoralto = 99999;
type
	
	tDireccion = record
		calle:string;
		nro:integer;
		piso:integer;
		dpto:string;
		ciudad:string;
	end;
	
	
	tNacimientos = record
		nro:integer;
		nomYape:string;
		dir:tDireccion:
		matricula:integer;
		nomYapeMama:string;
		nomYapePapa:string;
		DniPadre:integer;
	end;
	tFallecimientos = record
		nro:integer;
		dni:integer;
		nomYape:string;
		matricula:integer;
		fecha:integer;
		lugar:string;
	end;
	
	tDatoMaestro = record
		nro:integer;
		nomYape:integer;
		dir:tDireccion;
		matriculaNacimiento:integer;
		nomYapeMama:string;
		nomYapePapa:string;
		dniPa:string;
		matriculaMuerte:integer;
		fecha:integer;
		lugar:string;
	end;
	
	tDetalleNacimiento = file of tNacimientos;
	tDetalleFallecimiento = file of tFallecimientos;
	tMaestro = file of tDatoMaestro;
	
	aNacimientos  = array [1..DIMF] of tDetalleNacimiento;
	aFallecimiento = array[1..DIMF] of tDetalleFallecimiento;
	
	registrosN  = array [1..DIMF] of tNacimientos;
	registrosF = array[1..DIMF] of tFallecimientos;
	
	

procedure leerNacimiento(var det:tDetalleNacimiento, var n:tNacimientos);
begin
	if not(eof(det)) then
		read(det,n)
	else
		n.nro:= valoralto;
end
		
	
procedure leerFallecimiento(var det:tDetalleFallecimiento, var n:tFallecimientos);
begin
	if not(eof(det)) then
		read(det,n)
	else
		n.nro:= valoralto;
end

procedure minimoVivo (var min:tNacimientos, var nacimientos: aNacimientos, var registros: registrosN);
var
	i,indicemin:byte;
begin
	indicemin:=0;
	min.nro:=valoralto;
	for i:=1 to DIMF do begin
		if registros[i].nro <> valoralto then
			if registros[i].nro<min.nro then begin
				min:= registros[i];
				indicemin:=i;
			end;
	end;
	if indicemin <> 0 then
		leerVivo(nacimientos[indiceMin],registros[indiceMin]);
end;

procedure minimoMuerto (var min:tFallecimiento, var fallecimientos: aFallecimientos, var registros:registrosF);
var
	i,indicemin:byte;
begin
	indicemin:=0;
	min.nro:=valoralto;
	for i:=1 to DIMF do
		if registro[i].nro <>valoralto then begin
			min:=registros[i];
			indicemin:=i;
		end;
	end;
	if indicemin<>0 then
		leerFallecimiento(fallecimientos[incicemin],registros[indicemin]);
end;

procedure crearMaestro (var maestro: tMaestro, var fallecimientos: aFallecimientos, var registrosMuerto:registrosF, var nacimientos: aNacimientos, var registrosVivo: registrosN)
var
	minVivo:tNacimientos;
	minMuerto:tFallecimientos;
	dato: tDatoMaestro;
	i:byte;
begin
	for i:= 1 to DIMF do begin
		reset(fallecimientos[i]);
		reset(nacimientos[i]);
		leerVivo(nacimientos[i],registrosVivo[i]);
		leerMuerto(fallecimientos[i], registrosMuerto[i]);
	end;
	rewrite(maestro);
	minimoVivo(minVivo,nacimientos, registrosVivo);
	minimoMuerto(minMuerto,fallecimientos, registrosMuerto);
	while minVivo.nro <>valoralto do begin
		if minVivo.nro = minMuerto.nro then
			//paso todos los datos
			minimoMuerto(minMuerto,fallecimientos, registrosMuerto);
		else begin
			//todos los datos en vacio
		end;
		write(maestro,dato);
		minimoVivo(minVivo,nacimientos, registrosVivo);
	end;
	close(maestro);
	for i:=1 to DIMF do begin
		close(fallecimientos[i]);
		close(nacimientos[i]);
	end;
end;
