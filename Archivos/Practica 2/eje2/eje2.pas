program eje2;
const
	valoralto = 9999;
type
	cadena = string[20];
	alumno = record
		cod:integer;
		nom:cadena;
		ape:cadena;
		cantC:integer;
		cantA:integer;
	end;
	rDet = record
		cod:integer;
		CoA:boolean; //true = final aprobado, false = cursada
	end;
	
	detalle = file of rDet;
	maestro = file of alumno;
	
procedure leer(	var archivo: detalle; var dato: rDet);
begin
	if (not(EOF(archivo))) then 
		read(archivo, dato)
	else 
		dato.cod := valoralto;
end;

procedure leer2(	var archivo: maestro; var dato: alumno);
begin
	if (not(EOF(archivo))) then 
		read(archivo, dato)
	else 
		dato.cod := valoralto;
end;

procedure actualizarArch (var archD: detalle; var archM: maestro);
var
	dato:rDet;
	a:alumno;
begin
	reset(archD);
	reset(archM);
	leer(archD, dato);
	while (dato.cod<>valoralto) do begin
		read(archM, a);
		while (a.cod = dato.cod) do begin
			if dato.CoA then 
				a.cantA += 1
			else
				a.cantC += 1;
			leer(archD, dato);
		end;
		seek(archM, filepos(archM) - 1);
		write(archM, a);
	end;
	close(archM);
	close(archD);
end;
	
procedure exportarATexto (var archM:maestro);
var
	txt:Text;
	filename:cadena;
	a:alumno;
begin
	writeln('ingrese el nombre del archivo de texto (EJEMPLO.TXT)');
	readln(filename);
	assign(txt, filename);
	rewrite(txt);
	reset(archM);
	leer2(archM,a);
	while (a.cod<>valoralto) do begin
		if ((a.cantC>=4) and (a.cantA = 0)) then
			write(txt, 'Apellido: ' + a.ape + ' Nombre: ' + a.nom+ ' Codigo de alumno: ', a.cod ,' cantidad de materias con final: ',a.cantA,' cantidad de materias con cursada: ', + a.cantC);
		leer2(archM,a);
	end;
	close(txt);
	close(archM);
end;

var
	archM: maestro;
	archD: detalle;
	nomM, nomD: cadena;
	opc: cadena;
begin
	writeln('ingrese el nombre del archivo maestro');
	readln(nomM);
	writeln('ingrese el nombre del archivo detalle');
	readln(nomD);
	assign(archM, nomM);
	assign(archD, nomD);
	writeln(#10+'================== MENU ==================');
    writeln('a. Actualizar maestro');
    writeln('b. exportar a texto');
    writeln('==========================================');
    write('Ingrese una opcion: ');
    readln(opc);
	case opc of
		'a': actualizarArch(archD,archM);
		'b': exportarATexto(archM);
	end;
	
end.

		
	
	
