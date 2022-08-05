program eje3;
const
	valoralto = 32767;
type
	cadena = string[20];
	novela = record
		cod: integer;
		genero: cadena;
		nombre: cadena;
		duracion: integer;
		director: cadena;
		precio: real;
	end;
	
	archivo_novela = file of novela;
	
procedure leerNovela (var n: novela);
begin
	writeln('ingrese el codigo de la novela (-1 para terminar)');
	readln(n.cod);
	if n.cod <> -1 then begin
		writeln('ingrese el genero de la novela');
		readln(n.genero);
		writeln('ingrese el nombre de la novela');
		readln(n.nombre);
		writeln('ingrese la duracion de la novela');
		readln(n.duracion);
		writeln('ingrese el director de la novela');
		readln(n.director);
		writeln('ingrese el precio de la novela');
		readln(n.precio);
	end;
end;

procedure crearArch(var arch: archivo_novela);
var
	n:novela;
	file_name:cadena;
begin
	write('Ingresa el nombre que tendra el archivo: ');
    readln(file_name);
    Assign(arch, file_name);
	rewrite(arch);
	n.cod:= 0;
	write(arch, n);
	while n.cod <> -1 do begin
		leerNovela(n);
		write(arch, n);
	end;
	close(arch);
end;


procedure agregarFin (var nfile:archivo_novela);
var
	n:novela;
begin
	leerNovela(n);
	while (n.cod<> -1) do begin
		Seek(nfile, FileSize(nfile));//voy al final
		write(nfile, n);
		leerNovela(n);
	end;
end;


procedure Alta(var nfile:archivo_novela);
var
	n:novela;
	aux:novela;
begin
	reset(nfile);
	read(nfile, n);
	if n.cod=0 then
		agregarFin(nfile)
	else	begin
		seek (nfile, n.cod * (-1)); //voy a la posicion con espacio libre
		read(nfile, aux); //me guardo ese registro en uno auxiliar para que me quede bien la lista invertida
		seek (nfile, filepos(nfile)-1); //reubico el puntero porque antes me guardde el registro que no servia, y tengo que escribir en esta posicion
		leerNovela(n);//leo la novela que voy a leer
		write(nfile, n);//la escribo
		seek (nfile, 0);//voy al inicio
		write (nfile, aux);// y pongo el indice correcto de la lista invertida
	end;
	close(nfile);
end;


procedure leer (var nfile:archivo_novela; var n:novela);
begin
	if not eof(nfile) then
		read(nfile,n)
	else
		n.cod:=valoralto;
end;


Procedure buscar (Var nfile:archivo_novela; nom:integer; var pos:integer); 
var
	n:novela;
	termine:boolean;
begin
	termine:= false;
	leer(nfile,n);
	while (n.cod <> valoralto) and (not termine) do begin
        leer(nfile, n); 
		if n.cod=nom then begin
			termine:=true;
		end;
	end;
end;
		
			


procedure modificarNovela (var nfile: archivo_novela);
var
	n:novela;
	name:integer;
	pos: integer;
	opc:char;
begin
	reset(nfile);
	write('ingrese el codigo de la novela que quiere modificar');
	readln(name);
	buscar(nfile,name,pos);
	seek(nfile, pos);
	read(nfile,n);
	writeln('********** MENU DE MODIFICACION **********');
	writeln('0. salir');
	writeln('1. cambiar nombre novela');
	writeln('2. cambiar genero novela');
	writeln('3. cambiar duracion novela');
	writeln('4. cambiar director novela');
	writeln('5. cambiar precio novela');
	writeln('*******************************************');
	readln(opc);
	case opc of
		'1': begin
			writeln('ingrese el nombre de la novela');
			readln(n.nombre);
			end;
		'2':begin
			writeln('ingrese el genero de la novela');
			readln(n.genero);
			end;
		'3': begin
			writeln('ingrese la duracion de la novela');
			readln(n.duracion);
			end;
		'4': begin
			writeln('ingrese el director de la novela');
			readln(n.director);
			end;
		'5': begin
			writeln('ingrese el precio de la novela');
			readln(n.precio);
			end;
	end;
	seek(nfile, filepos(nfile)-1);
	write(nfile,n);
	close(nfile);
end;
			
procedure baja (var nfile:archivo_novela);
var
	n:novela;
	aux:novela;
	cod:integer;
	pos:integer;
begin
	reset(nfile);
	leer(nfile,aux);//leo el registro cabecera
	
	write('ingrese el codigo de la novela que quiere eliminar');//buscar codigo
	readln(cod);
	buscar(nfile,cod,pos);

	seek(nfile, pos);//estoy parado en el codigo a eliminar
	read(nfile,n);//leo el dato a eliminar
	
	n.cod:=aux.cod;//comienzo la lista invertida
	seek(nfile, filepos(nfile)-1);//voy uno atras para escribir el dato
	n.cod:= n.cod * (-1);//cambio el signo para que la lista invertida quede coherente
	write(nfile,n);//escribo el nodo
	
	seek(nfile, 0);//voy al inicio
	write(nfile,aux);//cambio el registro cabecera
	close(nfile);
end;
	
	

procedure imprimir (var nfile:archivo_novela; var txt:text);
var
	n:novela;
begin
	reset(nfile);
	rewrite(txt);
	seek (nfile,1); // me salteo el cabecera
	leer(nfile,n);
	while (n.cod <> valoralto) do begin
		with n do begin
			if (cod > 0) then
				writeln (txt,'CODIGO: ',cod,' NOMBRE: ',nombre,' GENERO: ',genero,' DIRECTOR: ',director,' DURACION: ',duracion,' PRECIO: ',precio:1:1)
			else
				writeln (txt,'ESPACIO LIBRE');
		end;
		leer(nfile,n);
	end;
end;

procedure showMenu(var nfile: archivo_novela; var txt:text);
var
    option: cadena;
begin
    writeln('********** MENU **********');
    writeln('0. Terminar ejecucion');
    writeln('1. Crear archivo novelas.');
	writeln('2. Alta en el archivo novelas.');
	writeln('3. Modificar el archivo novelas.');
	writeln('4. Baja en el archivo novelas.');
	writeln('5. Listar archivo en un txt');
	writeln('******************************');
    readln(option);
    case option of 
        '1': crearArch(nfile);
        '2': Alta(nfile);
        '3': modificarNovela(nfile);
        '4': baja (nfile);
        '5': imprimir(nfile, txt);
        '0': halt;
        else begin
            write('Ingreso una opcion invalida. Vuelva a intentar.');
            showMenu(nfile,txt);
        end;
    end;
    showMenu(nfile,txt);
end;
var
	nfile: archivo_novela;
	file_name:cadena;
	txt:Text;
	
begin
	write('Ingresa el nombre que tendra el archivo: ');
    readln(file_name);
    Assign(nfile, file_name);
    Assign(txt, 'novelas.txt');
	showMenu(nfile,txt);
end.





	
