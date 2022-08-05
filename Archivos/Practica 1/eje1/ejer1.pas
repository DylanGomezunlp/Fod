Program ejer1;
type
	numero= file of integer;
var
	arch_num:numero;
	nombre:string[20];
	n:integer;
begin
	writeln('ingrese un nombre para el archivo');
	readln(nombre);
	assign (arch_num, nombre);
	Rewrite (arch_num);
	writeln('ingrese un numero para el archivo');
	readln(n);
	while (n<>0) do begin
		write (arch_num,n);
		writeln('ingrese un numero para el archivo');
		readln(n);
	end;
	close (arch_num);
end.
	
