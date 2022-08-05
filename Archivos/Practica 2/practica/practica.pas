program practica;
const
	DIMF = 5
	valoralto = 999999
type
	tProd = record
		cod:integer;
		cant_V:integer;
	end;
	tDiario = record
		cod:integer;
		nom:string;
		des:string;
		stockAct:integer;
	end;
	tMae = file of tDiario;
	tDet = file of tProd;
	
	
	tCtrDet = record;
		det: tDet;
		rDet: tProd;
	end;
	
	tDetalles = array [1..DIMF] of tCtrDet;

procedure leerDet(var d:tDet, var p:tProd);
begin
	if not (eof(d)) then
		read(d,p);
	else
		p.cod := valoralto;
end;

procedure minimo(var CtrDet: tDetalles, var min:tProd);
var
	i,incideMin:byte;
begin
	indiceMin:=1
	for i:=2 to DIMF do 
		if CtrDet[i].rDet.cod < CtrDet[indiceMin].rDet.cod then
			indiceMin := i;
	min = CtrDet[indiceMin].Rdet;
	if min.cod <> valoralto then
		leer(CtrDet[inciceMin].det, CtrDet[inciceMin].Rdet);
end

procedure merge (var CtrDet:tDetalles);
var
	mae:tMae;
	prod:tDiario;
	codAct:integer;
	i:byte;
	min:tProd;
begin
	assign(mae,'maestro');
	reset(mae);
	read(mae,prod);
	for i:=1 to DIMF do begin
		reset(CtrDet[i].det);
		leerDet(CtrDet[i].det, CtrDet[i].rDet);
	end;
	minimo(CtrDet,min);
	while min.cod<>valoralto do begin
		codAct:= min.cod;
		while prod.cod <> codAct do read(mae, prod);
		while min.cod = codAct do begin
			prod.stock := prod.stock - min.cant;
			minimo(CtrDet, min);
			end;
		seek(mae,filepos(mae)-1);
		write(mae,prod);
		end;
	close(mae);
	for i:= 1 to DIMF do 
		close(CtrDet[i].det);
end;

var
	nomArch: string;
	detalle: tDetalles;
	i: byte;
begin
	for i:=1 to CD do begin
		write('Ingrese nombre de archivo de detalle ', i, ': ');
		readln(nomArch);
		assign(detalle[i].det, nomArch)
	end;
	actualizar(detalle)
end.











	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
