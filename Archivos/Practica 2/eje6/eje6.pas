{6-
Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de
localidad y código de cepa.
Para la actualización se debe proceder de la siguiente manera:
1. Al número de fallecidos se le suman el valor de fallecidos recibido del detalle.
2. Idem anterior para los recuperados.
3. Los casos activos se actualizan con el valor recibido en el detalle.
4. Idem anterior para los casos nuevos hallados.
Realice las declaraciones necesarias, el programa principal y los procedimientos que
requiera para la actualización solicitada e informe cantidad de localidades con más de 50
casos activos (las localidades pueden o no haber sido actualizadas).}

program ejer6;
uses crt;

CONST
valorAlto = 9999;
n = 3;

type

cMaestro = record
	cod: integer;
	nombre: string;
	cepa: integer;
	nombreC: string;
	cAc: integer;
	cNue: integer;
	cRec: integer;
	cF: integer;
end;

cDetalle = record
	cod: integer;
	cepa: integer;
	cAc: integer;
	cNue:integer;
	cRec:integer;
	cF:integer;
end;

maestro = file of cMaestro;
detalle = file of cDetalle;

arDet = array [1..n] of detalle;
regDet = array [1..n] of cDetalle;

procedure leer (var arc_detalle:detalle; var dato:cDetalle);
begin
	if not eof (arc_detalle) then
		read (arc_detalle,dato)
	else
		dato.cod:= valorAlto;
end;

procedure leerMaestro (var arc_maestro:maestro; var dato:cMaestro);
begin
	if not eof (arc_maestro) then
		read (arc_maestro,dato)
	else
		dato.cod:= valorAlto;
end;


procedure minimo (var registro:regDet, var min:cdetalle, var deta:arDet);
var
	indiceMin,i:integer;
begin
	min.cod := valoralto;
	indiceMin := 0;
	for i:=1 to n do
		if registro[i]<>valoralto then begin
			if registro[i].cod < min.cod then begin
				min := registro[i];
				indiceMin:= i;
			end
			else
				if registro[i].cod = min.cod and registro[i].cepa< min.cepa then
					begin
						min:= registro[i];
						indiceMin:=i;
			end;
		end;
	if indicemin<>0 then
		leer(deta[indicemin], registro[indicemin]);
end;

procedure actualizar_maestro (var arc_maestro:maestro);
var
	aString:string;
	deta: arDet;
	registro: regDet;
	min:cDetalle;
	m:cMaestro;
	i,codActual,cepaActual,totalFallecidos,totalRecuperados,activos,nuevos:integer;
begin
	reset(arc_maestro);
	for i to n do begin
		Str (i,aString);
		Assign (deta[i],'detalle'+aString);
		reset (deta[i]);
		leer (deta[i],registro[i]);
	end;
	minimo(registro, min,deta);
	while min.cod<>valoralto do begin
		codAct:=min.cod;
		while codAct = min.cod do begin
			cepaAct:=min.cepa;
			totalFallecidos: 0;
			totalRecuperados:= 0;
			while codAct=min.cod and cepaAct= min.cepa do begin
				totalFallecidos+= min.cF;
				totalRecuperados+= min.cRec;
				activos:= min.cAc;
				nuevos:= min.cNue;
				minimo (registro,min,deta);
			end;
			read(arc_maestro, m);
			while (m.cod <> codActual) do
				read (arc_maestro,m);
			while (m.cepa <> cepaActual) do
				read (arc_maestro,m);
						m.cF+= totalFallecidos;
			m.cRec+= totalRecuperados;
			m.cAc:= activos;
			m.cNue:= nuevos;
			
			seek (arc_maestro,filePos (arc_maestro)-1);
			write (arc_maestro,m);
		end;
	end;
	for i:=1 to n do
		close (deta[i]);
	close (arc_maestro);
end;


