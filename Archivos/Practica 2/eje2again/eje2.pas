program eje2;
const
	valoralto = 99999;

type
	tAlumno = record
		cod: integer;
		ape: string;
		nom:string;
		cant_C:integer;
		cant_F:integer;
	end;
	tMateria = record
		cod: integer;
		aprobo : boolean;
	end;
	tMaestro = file of tAlumno;
	tDetalle = file of tMateria;
	
procedure leer(var det:tDetalle, a:tAlumno);
begin
	if not(eof(det)) then
		read(det,a);
	else
		a.cod = valoralto;
end;
	
	
procedure actualizar (var mae:tMaestro, var det:tDetalle);
var
	a:tAlumno;
	mat:tMateria;
	codAct:integer;
	cursadas:integer;
	finales:integer;
begin
	reset(det);
	reset(mae);
	leer(det,mat);
	while mat.cod<>valoralto do begin
		codAct:= mat.cod;
		cursadas:= 0;
		finales:= 0;
		while codAct = mat.cod do begin
			if mat.aprobo then
				cursadas:= cursadas + 1
			else
				finales:= finales + 1;
			leer (det,mat);
		end;
		read(mae,a);
		a.cantC:= a.cantC + cursadas;
		a.cantF:= a.cantF + finales;
		seek(mae, filepos(mae)-1);
		write(mae,a);
	end;
	close(det);
	close(mae);
end;

procedure listar (var mae:tMaestro);
var
	txt : Text;
	a: tAlumno;
begin
	assign(txt, 'Listado.txt');
	rewrite(txt);
	reset(mae);
	read(mae,a);
	while not eof(mae) do begin
		if ((a.cantC - a.cantF) > 5) then begin
			write(txt, a.cod,' ', a.cantC,' ', a.cantF,' ', a.nom,' ', a.ape);
		end;
		read(mae,a);
	end;
	close(txt);
	close(mae);
end;
			
	
	
	
	
	
	
