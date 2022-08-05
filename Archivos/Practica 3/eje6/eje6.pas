{UDeberá implementar un procedimiento que reciba ambos archivos
y realice la baja lógica de las prendas, para ello deberá modificar el stock de la prenda
correspondiente a valor negativo.
Por último, una vez finalizadas las bajas lógicas, deberá efectivizar las mismas
compactando el archivo. Para ello se deberá utilizar una estructura auxiliar, renombrando
el archivo original al finalizar el proceso.. Solo deben quedar en el archivo las prendas
que no fueron borradas, una vez realizadas todas las bajas físicas.}
program ejercicio6;
const
	valor_alto = 9999;
type
	cadena = string[20];
	prenda = record
		cod:integer;
		desc:cadena;
		colores:cadena;
		tipo:cadena;
		stock:integer;
		precio:real;
	end;
	maestro = file of prenda;
	obsoletas = file of integer;
	nuevo = file of prenda;
	
procedure leer (var m:maestro; var dato:prenda);
begin
	if not(eof(m)) then	
		read(m,dato)
	else
		dato.cod:=valor_alto;
end;

procedure leerObs (var m:obsoletas; var dato:integer);
begin
	if not(eof(m)) then	
		read(m,dato)
	else
		dato:=valor_alto;
end;



	
procedure actMaestro (var m: maestro; var o:obsoletas);
var
	dato:prenda;
	cod:integer;
begin
	reset(m);
	reset(o);
	leer(m,dato);
	while (dato.cod<>valor_alto) do begin
		leerObs(o,cod);
		while ((cod<>valor_alto) and (dato.cod <> cod)) do
			leerObs(o,cod);
		if dato.cod = cod then 
			dato.cod:= (dato.cod * (-1));
		seek (m,filePos(m)-1);
		write(m,dato);
		reset(o);
		leer(m,dato);
	end;
	close(m);
	close(o);
end;

procedure compactar (var m:maestro; var n:nuevo);
var
	p:prenda;
begin
	reset(m);
	rewrite(n);
	leer(m,p);
	while p.cod<>valor_alto do begin
		if p.cod > 0 then
			write(n,p);
		leer(m,p);
	end;
	close(m);
	close(n);
end;



var
	prendaFile: nuevo;
	mae:maestro;
	obs:obsoletas;
	file_name:cadena;
begin
	write('Ingresa el nombre que tendra el archivo (tiene que tener el mismo que el maestro): ');
    readln(file_name);
    Assign(prendaFile, file_name);
    actMaestro(mae,obs);
    compactar(mae,prendaFile);
    erase (mae);
	rename(prendaFile,'maestro.dot');
end.

