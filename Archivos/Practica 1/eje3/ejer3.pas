program ejer3;
type
	cadena=string[20];
	empleado=record
		num:integer;
		ape:cadena;
		edad:integer;
		nom:cadena;
		dni:integer;
	end;
	arch_emp=file of empleado;
	
procedure CrearArchEmp (var arc_emp: arch_emp);
var
	p:empleado;
begin
	writeln('ape');
	readln(p.ape);
	while p.ape<>'fin' do begin
		writeln('num');
		readln(p.num);
		writeln('nom');
		readln(p.nom);
		writeln('dni');
		readln(p.dni);
		writeln('edad');
		readln(p.edad);
		write (arc_emp, p);
		writeln('ape');
		readln(p.ape);
	end;
	close (arc_emp);
end;

Procedure buscar (Var arc_emp:arch_emp; nom:cadena; ape:cadena); 
 var E: empleado;
  begin
    reset (arc_emp); 
    while not eof( arc_emp ) do begin
        Read( arc_emp, E); 
		if e.nom=nom then begin 
			writeln('el empleado se llama: ', e.nom);
			writeln('el empleado se apellida: ',e.ape);
			writeln('el empleado tiene el dni: ',e.dni);
			writeln('el empleado tiene de numero el: ',e.num);
			writeln('el empleado tiene la edad de: ',e.edad);
		end;
		if e.ape=ape then begin
			writeln('el empleado se llama: ', e.nom);
			writeln('el empleado se apellida: ',e.ape);
			writeln('el empleado tiene el dni: ',e.dni);
			writeln('el empleado tiene de numero el: ',e.num);
			writeln('el empleado tiene la edad de: ',e.edad);
		end;
        Seek( arc_emp,  filepos(arc_emp) -1 );
        Write(arc_emp,E); 
    end;
    close( arc_emp );
 end;







var
	arc_emp: arch_emp;
	nombre:cadena;
	ape:cadena;
begin
	writeln('ingrese un nombre para el archivo');
	readln(nombre);
	assign (arc_emp, nombre);
	//rewrite (arc_emp);
	//CrearArchEmp(arc_emp);
	writeln('ingrese un nombre a buscar');
	readln(nombre);
	writeln('ingrese un apellido a buscar');
	readln(ape);
	buscar (arc_emp, nombre, ape);
end. 
