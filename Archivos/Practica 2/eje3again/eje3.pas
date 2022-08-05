{3 - Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
Además, se deberá informar en un archivo de texto: nombre de producto,
descripción, stock disponible y precio de aquellos productos que tengan 
stock disponible por debajo del stock mínimo.}

program eje3;
const
	valoralto = 99999;
	DIMF = 30;
type
	tProducto = record
		cod:integer;
		nom:string;
		des:string;
		stock_D:integer;
		stock_M:integer;
		precio:real;
	end;
	
	tRegDet = record
		cod:integer;
		cantV:integer;
	end;
	
	tDetalle = file of tRegDet;
	tMaestro = file of tProducto;
	
	tSucursales = array[1..DIMF] of tDetalles;
	tReg = array[1..DIMF] of tRegDet;

procedure leer(var det:tDetalle, r:tRegDet);
begin
	if not(eof(det)) then
		read(det,r)
	else
		r.cod := valoralto;
end

procedure minimo (var sucursales:tSucursales, var registros:tReg, var min: tReg);
var
	i,indiceMin:byte;
begin
	indiceMin := 0;
	min.cod:= valoralto;
	for i:= 1 to DIMF do 
		if registros[i].cod <> valoralto then 
			if registros[i].cod < min.cod then begin
				min := registros[i];
				indiceMin:= i;
			end;
	if indiceMin <> 0 then begin
		leer(sucursales[indiceMin], registros[indiceMin]);
	end;
end;

procedure actualizar (var sucursales:tSucursales, var registros: tReg, var mae: tMaestro);
var
	min: tReg;
	i: integer;
	aString:string;
	prod:tProducto;
	cantVendida:integer;
	codActual:integer;
begin
	reset(mae);
	for i:=1 to DIMF do begin
		str(i,aString);
		assign(sucursales[i], 'detalle'+aString);
		reset(sucursales[i];
		leer(sucursales[i],registros[i]);
	end;
	minimo(sucursales, registros,min);
	while min.cod <> valoralto do begin
		codAct:=min.cod;
		cantVendida:= 0;
		while min.cod = codAct do begin
			cantVendida:= cantVendida + min.cantVendida;
			minimo(sucursales, registros,min);
		end;
		read(mae, prod);
		while prod.cod <> codAct do begin
			read(mae, prod);
		end;
		seek(mae, filepos(mae)-1);
		prod.stockD := prod.stockD - cantV;
		write(mae,prod);
	end;
	close(mae);
	for i:=1 to DIMF do begin
		close(sucursales[i]);
	end;
end;
			
			
procedure Lista (var mae:tMaestro);
var
	txt: Text;
	producto:tProducto;
begin
	assign(txt, 'menor a disponible.txt');
	rewrite(txt);
	read(mae,producto);
	while not eof(mae) do begin
		if producto.stock_D < producto.stock_M then
			write(txt, ' ', producto.stock_D, producto.stock_M,  producto.precio, producto.cod, producto.des, producto.nom);
	end;
	close(txt);
	close(mae);
end;
			
			
			
			
			
			
			
			
			
	
		
				
	
	
