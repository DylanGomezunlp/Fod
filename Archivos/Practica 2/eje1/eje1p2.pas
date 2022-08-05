program ejercicio1;
const
	valoralto=9999;
type
	cadena=string[15];
	empleado=record
		cod:integer;
		monto:real;
		nombre:cadena;
	end;
	detalle=file of empleado;
	maestro=file of empleado;


procedure leer(	var archivo: detalle; var dato: empleado);
begin
	if (not(EOF(archivo))) then 
		read (archivo, dato)
	else 
		dato.cod := valoralto;
end;


procedure crearArchivoComisiones(var arch: detalle);
    procedure leerComision(var c: empleado);
    begin
        write('Ingresar codigo de empleado: ');
        readln(c.cod);
        if(c.cod <> -1)then begin
            write('Ingresar nombre del empleado: ');
            readln(c.nombre);
            write('Ingresar monto de la comision: ');
            readln(c.monto);
        end;
    end;
var
    c: empleado;
begin
    rewrite(arch);
    leerComision(c);
    while(c.cod <> -1)do begin
        write(arch, c);
        leerComision(c);
    end;
    close(arch);
end;



procedure verArchivoComisiones(var arch: maestro);
var
    c: empleado;
begin
    reset(arch);
    while(not eof(arch))do begin
        read(arch, c);
        writeln('codigo: ',c.cod, ' nombre: ', c.nombre, ' monto: $', c.monto:2:2);
    end;
    close(arch);
end;



procedure compactar (var det: detalle; var mae:maestro);
var
	e:empleado;
	e2:empleado;
begin
	reset(det);
	rewrite(mae);
	leer(det,e);
	while e.cod<>valoralto do begin
		e2.cod:= e.cod;
		e2.nombre:=e.nombre;
		e2.monto:=0;
		while (e.cod<>valoralto) and (e.cod=e2.cod) do begin
			e2.monto := e2.monto + e.monto;
			leer(det,e);
		end;
     	write(mae, e2);
	end;
	close(det);
	close(mae);
end;

var
	det:detalle;
	mae:maestro;
begin
	assign(det,'archivo_comisiones');
	assign(mae,'maestro');
	//crearArchivoComisiones(det);
	//compactar(det,mae);
	verArchivoComisiones(mae);
end.
	
