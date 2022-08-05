
{Implementar un procedimiento que, a partir del
archivo de datos generado, elimine de forma lógica todos los asistentes con nro de
asistente inferior a 1000.
Para ello se podrá utilizar algún carácter especial situándolo delante de algún campo
String a su elección. Ejemplo: ‘@Saldaño’.}




program eje2;
const
	NROELEMINAR = 1000;
	separador = '****************************';
	valorAlto = 3287;
type
	cadena = string[20];
	asistente = record	
		nro:integer;
		nomYape: cadena;
		email: cadena;
		telefono: integer;
		dni: integer;
	end;
	arch = file of asistente;
	
	
procedure leer (var archivo:arch; var a:asistente);
begin
	if not(eof(archivo)) then
		read(archivo,a)
	else
		a.nro:= valorAlto;
end;



	
procedure leerAsistente (var a:asistente);
	begin
		writeln('ingrese el nro del asistente: ');
		readln(a.nro);
		if a.nro<>0 then begin
			writeln('ingrese el nom y ape del asistente: ');
			readln(a.nomYape);
			writeln('ingrese el mail del asistente: ');
			readln(a.email);
			writeln('ingrese el telefono del asistente: ');
			readln(a.telefono);
			writeln('ingrese el dni del asistente: ');
			readln(a.dni);
		end;
	end;


procedure crearArch (var archivo:arch);	
var
	a:asistente;
	file_name:cadena;
begin
	write('Ingresa el nombre que tendra el archivo: ');
    readln(file_name);
    Assign(archivo, file_name);
	rewrite(archivo);
	leerAsistente(a);
	while a.nro<>0 do begin
		write(archivo,a);
		leerAsistente(a);
	end;
	close(archivo);
end;
		
procedure bajaLogica (var archivo:arch);
var
	a:asistente;
begin
	reset(archivo);
	leer(archivo,a);
	while a.nro <> valorAlto do begin
		if a.nro < 1000 then
			a.email:= '?' + a.email;
		writeln(separador);
		writeln(a.email);
		writeln(separador);
		leer(archivo,a);
	end;
	close(archivo);
end;


var
	archivo:arch;
begin
	crearArch(archivo);
	bajaLogica(archivo);
end.







