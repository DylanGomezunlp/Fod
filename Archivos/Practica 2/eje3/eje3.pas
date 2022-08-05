program ejercicio3;
const
	DIMF=30;
type
	cadena = string[20];
	subrango= 1..DIMF;
	producto = record
		cod:integer;
		nom:cadena;
		desc:cadena;
		stockD:integer;
		stockM:integer;
		precio:real;
	end;
	pDet = record
		cod:integer;
		cant:integer;
	end;
		
	maestro = file of producto;
	detalle = file of pDet;
	sucursales = array[subrango] of detalle;
	
	arreglo_act = array [subrango] of pDet;
	




procedure minimo (var reg_det: arreglo_act; var min:pDet; var deta:sucursales);
var 
	i: integer;
	minCod:integer;
	minPos:integer;
begin
      { busco el mínimo elemento del 
        vector reg_det en el campo cod,
        supongamos que es el índice i }
    minPos := 1;
    minCod:=32767;
    for i:= 1 to DIMF do begin    	
		if(reg_det[i].cod < minCod)then begin
			min := reg_det[i];
			minCod := reg_det[i].cod;
			minPos := i;
		end;
	end;
	leer(deta[minPos], reg_det[minPos]);
	
end;     
	
procedure actualizar_maestro(var a:maestro; var detalles:sucursales);
var
	i:integer;
	min:pDet;
	regm:producto;
	reg_det: arreglo_act;
	totalvendido: integer;
	codact: integer;
begin
	for i:= 1 to DIMF do begin
		reset( detalles[i] );
		leer( detalles[i], reg_det[i]);
	end;
	
	reset(a);
	minimo(reg_det, min, detalles); {busco el detalle minimo}
	while (min.cod <> VALOR_ALTO) do begin
		totalvendido := 0;
		codact := min.cod;
		while(codact = min.cod ) do begin
			totalvendido:= totalvendido + min.cantV;
			minimo (reg_det, min, detalles);
		end;
		
		read(a, regm);
		while(regm.cod <> codact)do 
			read(a, regm);
		regm.stock := regm.stock - totalvendido;
		
		seek(a, filepos(a)-1);
		write(a, regm);
	end;    
	for i:= 1 to DIMF do begin
		close(detalles[i]);
	end;
	close(a);
end;


procedure exportar_txt(var a:archivo_maestro; var txt:Text);
var
	regm:producto;
begin
	rewrite(txt);
	reset(a);
	while(not eof(a))do begin
		read(a,regm);
		if(regm.stock < regm.stockMin)then
			with regm do
				writeln(txt,'Producto: ', nombre,' ',descripcion,' - stock disponible: ', stock,' - $', precio:2:2,'.');  	
	end;
	close(a);
	close(txt);
end;	
