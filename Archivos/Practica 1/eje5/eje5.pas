program ejer5;
type
    cadena=string[20];
    celular = record
        codigo: integer;
        nombre: cadena;
        descripcion: cadena;
        marca: cadena;
        precio: real;
        stockM: integer;
        stockD: integer;
    end;

    arch_celular = file of celular;


// Inciso A
procedure crear_archivo(var p: arch_celular);
var
    txt: Text;
    c: celular;
begin
	readln();
    Assign(txt, 'celulares.txt');
    reset(txt);
    rewrite(p);
    readln();
    while(not eof(txt))do begin
        readln(txt, c.codigo, c.precio, c.marca);
        readln(txt, c.stockD, c.stockM, c.descripcion);
        readln(txt, c.nombre);        
        write(p, c);
    end;

    close(p);
    close(txt);

    writeln('Se creo el archivo binario correctamente.')
end;

//Inciso B

procedure imprimir_celular(var c:celular);
begin
    writeln('Codigo: ', c.codigo);
    writeln('Nombre: ', c.nombre);
    writeln('Descripcion: ', c.descripcion);
    writeln('Marca: ', c.marca);
    writeln('Precio: $', c.precio:2:2);
    writeln('Stock minimo: ', c.stockM);
    writeln('Stock disponible: ', c.stockD);
    writeln();
end;

procedure leerCelular (var c:celular);
begin
	writeln('Ingrese el nombre: ');
	readln(c.nombre);
	if c.nombre<>'fin' then begin
		writeln('Ingrese el codigo del celular: ');
		readln(c.codigo);
		writeln('Ingrese la descripcion: ');
		readln(c.descripcion);
		writeln('Ingrese la marca: ');
		readln(c.marca);
		writeln('Ingrese el precio: ');
		readln(c.precio);
		writeln('Ingrese el stock minimo: ');
		readln(c.stockM);
		writeln('Ingrese el stock disponible: ');
		readln(c.stockD);
	end;
end;




procedure listar_minimo_stock(var p: arch_celular);
var
    c: celular;
begin
    reset(p);
    while(not eof(p))do begin
        read(p,c);
        if(c.stockD < c.stockM ) then 
            imprimir_celular(c);
    end;
    close(p);
end; 

//Inciso C

procedure listar_con_descripcion(var p: arch_celular);
var
    c: celular;
    cadena: string[20];
    encontro: boolean;
begin
    encontro:= false;
    write('Ingrese cadena de texto: ');
    readln(cadena);
    writeln('Resultados que coinciden: ');
    reset(p);
    while(not eof(p))do begin
        read(p,c);
        if( pos(cadena, c.descripcion) <> 0) then begin
            imprimir_celular(c);
            if(not encontro) then
                encontro:= true;
        end;
    end;
    if(not encontro)then
        writeln('La cadena que ingreso no coincide con ninguna descripcion.');
    close(p);
end; 


//Inciso D 
procedure exportar_archivo(var p: arch_celular);
var
    c: celular;
    archivo_guardar: Text;
begin
    reset(p);
    Assign(archivo_guardar,'celulares.txt');
    rewrite(archivo_guardar);
    while (not eof(p)) do begin
        read(p,c);
        writeln(archivo_guardar, c.codigo, c.precio, c.marca);
        writeln(archivo_guardar, c.stockD, c.stockM, c.descripcion);
        writeln(archivo_guardar, c.nombre);
    end;
    close(p);
    close(archivo_guardar);
    writeln('Se exporto el archivo binario a texto como "celulares.txt".');
end;

//6.a

procedure agregarFin (var p:arch_celular);
var
	c:celular;
begin
	reset(p);
	leerCelular(c);
	while (c.nombre<>'fin') do begin
		Seek(p, FileSize(p));//voy al final
		write(p, c);
		leerCelular(c);
	end;
	close(p);
end;

//6.b
procedure modificarStock (var p:arch_celular);
var
	c:celular;
	nom:cadena;
	nueStock:integer;
begin
	reset(p);
	writeln('Ingrese el nombre de un celular a modificar: ');
	readln(nom);
	writeln('Ingrese el valor a modificar: ');
	readln(nueStock);
	while not(eof(p))do begin
		read(p,c);
		if nom=c.nombre then
			c.stockD:=nueStock;
		Seek(p, filepos(p) -1 );
		Write(p,c);
	end;
	close(p);
end;

//6.c
procedure expSinStock (var p:arch_celular);
var
	notStock:text;
	c:celular;
begin
	reset(p);
	assign(notStock, 'sin stock.txt');
	rewrite(notStock);
	while (not eof(p)) do begin
		read(p,c);
		if c.stockD=0 then begin
			writeln(notStock, c.codigo, c.precio, c.marca);
			writeln(notStock, c.stockD, c.stockM, c.descripcion);
			writeln(notStock, c.nombre);
		end;
	end;
	close(p);
	close(notStock);
end;

procedure showMenu(var pfile: arch_celular);
var
    option: cadena;
begin
    writeln('======== MENU ========');
    writeln('1. Crear archivo binario.');
    writeln('2. Listar celulares con stock menor al minimo.');
    writeln('3. Listar celulares con determinada descripcion.');
    writeln('4. Exportar archivo binario a texto.');
    writeln('5. Salir.');
    writeln('6. Agregar celulares al final del archivo, hasta que el nombre del celular sea "fin".');
    writeln('7. Modificar stock de un celular dado.');
    writeln('8. Exportar a "sin stock.txt" aquellos celulares sin stock');
    writeln('======================');
    readln(option);
    case option of 
        '1': crear_archivo(pfile);
        '2': listar_minimo_stock(pfile);
        '3': listar_con_descripcion(pfile);
        '4': exportar_archivo(pfile);
        '5': halt;
        '6': agregarFin(pfile);
        '7': modificarStock(pfile);
        '8': expSinStock(pfile);
        else begin
            write('Ingreso una opcion invalida. Vuelva a intentar.');
            showMenu(pfile);
        end;
    end;
    showMenu(pfile);
end;

var
    pfile: arch_celular;
    nombre_archivo: cadena;
begin
    write('Ingrese nombre para el archivo binario con el que va a trabajar: ');
    readln(nombre_archivo);
    Assign(pfile, nombre_archivo);
    showMenu(pfile);
end.
