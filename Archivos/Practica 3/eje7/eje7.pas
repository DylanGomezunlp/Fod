program eje7;
type
	tAve = record
		cod:integer;
		nom:string;
		fam:string;
		des:string;
		zona:string;
	end;
	tArchivo = file of tAve;

procedure marcar (var arc:tArchivo, nom:string);
var
	dato:tAve;
	ok = boolean;
begin
	ok := false;
	reset(arc);
	read(arc,dato);
	while dato.cod<> valoralto and not ok do begin
		if dato.nom = nom then begin
			dato.nom:= '###';
			seek(arc, filepos(arc)-1);
			write(arc,dato);
			ok:=true;
		end
		else
			read(arc,dato);
	end;
	close(arc);
end;
		
procedure compactar (var arc:tArchivo);
var
	ave:tAve;
	pos:integer;
begin
	reset(arc);
	leer(arc,ave);
	while ave.cod <> valoralto do begin
		if ave.nom = '###' then begin
			pos:= filepos(arc) - 1;
			seek(arc,fileSize(arc)-1);
			read(arc,ave);
			while ave.nom = '###' do begin
				seek(arc,filesize(arc)-1); //voy al final
				trunctate(arc); //bajo en 1 el tamaño del archivo
				seek(arc,filesize(arc)-1);//voy al final
				read(arc,ave);//leo mientras haya valores a eliminar
			end;
			seek(arc,pos);//voy a la posicion donde estaba el coso a eliminar
			write(arc,ave);//lo remplazo
			seek(arc,filesize(arc)-1);//voy al final
			truncate(arc);//bajo en 1 el tamaño del archivo
			seek(arc,pos);//voy de nuevo donde estaba el coso eliminado ahora remplazado
		end;
		leer(arc,ave);
	end;
	close(arc);
end;
			
			
		
		
		
