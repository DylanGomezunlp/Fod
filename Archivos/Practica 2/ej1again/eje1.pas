program ejercicio1;
const
	valoralto= 99999;
type
	tEmpleado = record
		cod:integer;
		nom:string;
		monto:real;
	end;
	
	tDetalle = file of tEmpleado;
	tMaestro = file of tEmpleado;

procedure leer (var detalle: tDetalle, e:tEmpleado);
begin
	if (not(eof(detalle)) then
		read(detalle,e)
	else
		e.cod = valoralto;
end;
			
		
procedure compactar (var det:tDetalle);
var
	e:tEmpleado;
	mae:tMaestro;
	codAct:integer;
	tot:real;
	nom:string;
begin
	writeln('Ingrese el nombre del nuevo archivo: ');
	readln(nom);
	assign(mae,nom);
	rewrite(mae);
	reset(det);
	leer(det,e);
	while e.cod <> valoralto do begin
		codAct:= e.cod;
		tot:= 0;
		while codAct = e.cod then begin
			tot := tot + e.monto;
			leer(det,e);
		end;
		e.cod := codAct;
		e.monto:= tot;
		write(mae, e);
	end;
	close(det);
	close(mae);
end;
		
		
	
		
		
		
