program ejer2;
type
	numero= file of integer;


{Procedure Recorrido(var arch_num: numero );
 var  nro:integer;  
  begin
    reset(arch_num); 
   	   while not eof(arch_num) do begin
        read(arch_num, nro);
        write(nro);           
     end;
     close(arch_num);
 end;}
 
Procedure Recorrido(var arch_num: numero );
var  
 nro:integer;  
 cont:integer;
 prom:real;
  begin
	cont:=0;
	prom:=0;
    reset(arch_num); 
   	   while not eof(arch_num) do begin
        read(arch_num, nro);
		if nro<1500 then
				cont:=cont+1;
		prom:=prom+nro;
     end;
     writeln('el promedio de los numero es de: ', (prom/filesize (arch_num)):2:2);
     Writeln('la cantidad de numeros menores a 1500 es de: ', cont);
     close(arch_num);
 end;
 
 
var
	arch_num:numero;
	nombre:string[20];
begin
	writeln('ingrese el nombre del archivo a buscar');
	readln(nombre);
	Assign (arch_num, nombre);
	Recorrido (arch_num);
end.
	
