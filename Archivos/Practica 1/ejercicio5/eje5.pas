{Realizar un programa para una tienda de celulares, que presente un menú con
opciones para:
NOTA 1: El nombre del archivo binario de celulares debe ser proporcionado por el usuario
una única vez.
NOTA 2: El archivo de carga debe editarse de manera que cada celular se especifique en
tres líneas consecutivas: en la primera se especifica: código de celular, el precio y
marca, en la segunda el stock disponible, stock mínimo y la descripción y en la tercera
nombre en ese orden. Cada celular se carga leyendo tres líneas del archivo
“celulares.txt”.}

program ejercicio 5;

type
	cadena = string[20];
	celular = record
		 cod: integer;
		 nom: cadena;
		 desc:cadena;
		 marca: cadena
		 precio: real;
		 stockM: integer;
		 stockD: integer;
	end;
	archivo = file of celular;
	
	
archivo = file of celu;


procedure imprimir (c:celular);
begin
	with c do begin
		writeln ('|CODIGO: ',cod,' |PRECIO: ',precio:0:2,' |MARCA: ',marca);
		writeln ('|STOCK DISPONIBLE: ',stockD,' |STOCK MINIMO: ',stockM);
		writeln ('|DESCRIPCION:',desc,' |NOMBRE: ',nom);
		writeln ('');
	end;
end;

procedure ingresarNombre (var nombre:string);
begin
	write ('INGRESE NOMBRE DEL ARCHIVO: '); readln (nombre);
	writeln ('')
end;
	
	
procedure crear_archivo_cel (var arch_cel:archivo, var carga: Text);
var
	nombre: cadena;
	cel: celular;
begin
	reset(carga); //reset porque tengo que cargar datos DESDE este 
				  //archivo.
	rewrite(arch_cel); //rewrite porque tengo que llenar de datos este 
					   //nuevo archivo
	read(cel,carga);
	while not eof(carga) do begin
		write(arch_cel,c.cod,c.precio,c.marca);
		write(arch_cel,c.stockD,c.stockm,c.desc);
		write(arch_cel,c.nom);
		read(cel,carga);
	end;
	close(cargar);
	close(arch_cel);
end;

procedure listar_stock_menor_que_min (var arch_cel:archivo);
var
	cel:celular;
begin
	reset(arch_cel);
	read(cel,arch_cel);
	while not eof(arch_cel) do begin
		if cel.stockD<cel.stockM then 
			imprimir(cel);	
		read(cel,arch_cel);
	end;
	close(arch_cel);
end;
	
procedure listar_cadena_usuario (var arch_cel:archivo, nom:cadena);
var
	cel:celular;
begin
	reset(arch_cel);
	read(cel,arch_cel);
	while not eof(arch_cel) do begin
		if cel.desc=nom then 
			imprimir(cel);	
		read(cel,arch_cel);
	end;
	close(arch_cel);
end;

procedure exportar_txt (var arch_cel:archivo);
var
	txt: Text;
	cel: celular;
begin
	reset(arch_cel);
	rewrite(txt);
	read(cel,arch_cel)
	while not eof(arch_cel) do begin
		write(arch_cel,c.cod,c.precio,c.marca, c.stockD,c.stockm,c.desc,c.nom);
	end;
	close(arch_cel);
	close(txt);
end;

var
	
