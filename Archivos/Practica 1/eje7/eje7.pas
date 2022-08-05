program ejercicio7;
type
	novela = record
		codigo:integer;
		precio:integer;
		genero:string;
		nombre:string;
	end;
arch_novelas = file of novela;


procedure crear_archivo(var p: arch_novelas);
var
    txt: Text;
    c: novela;
begin
	readln();
    Assign(txt, 'novelas.txt');
    reset(txt);
    rewrite(p);
    readln();
    while(not eof(txt))do begin
        readln(txt, c.codigo, c.precio, c.genero);
        readln(txt, c.nombre);        
        write(p, c);
    end;

    close(p);
    close(txt);

    writeln('Se creo el archivo binario correctamente.')
end;



procedure buscar (var a:arch_novelas; cod:integer; var pos: integer);
var
 E:novela;
 ok:boolean;
 begin
	ok:=false;
    reset (a); 
    while not eof( a ) and not(ok) do begin
        Read( a, E); 
		if E.codigo=cod then begin 
			pos:= filepos(a);
			ok:= true
		end;
        Seek(a, filepos(a) -1 );
        Write(a,E); 
    end;
    close(a);
    pos:= -1;
 end;


procedure modificar_novela(var p:arch_novelas; c:integer);
var
	opc:String;
	nov:novela;
	valor:integer;
	nom:String;
	pos:integer;
begin         
  reset(p);
  buscar(p,c,pos);
  seek(p, pos);
  read(p,nov);
  seek(p, filepos(p)-1);
  writeln('Ingrese el valor a modificar :');
  writeln('1: precio');
  writeln('2: genero');
  writeln('3: nombre');
  readln(opc);
  case opc of
	'1': begin
			writeln('Ingrese el nuevo genero: ');
			readln(nom);
			nov.genero:= nom;
			write(p,nov);
		end;
	'2': begin
			writeln('Ingrese el nuevo precio: ');
			readln(valor);
			nov.precio:= valor;
			write(p,nov);
		end;
	'3': begin
			writeln('Ingrese el nuevo nombre: ');
			readln(nom);
			nov.nombre:= nom;
			write(p,nov);
		end;
end;
	
  
  
  
  
  
  
  
  
  
  
  
  
	
	
