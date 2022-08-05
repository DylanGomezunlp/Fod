{Sconecta 5 máquinas entre sí y todas las
máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
cuánto tiempo estuvo abierta.
 Debe realizar un procedimiento que reciba los archivos
detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
tiempo_total_de_sesiones_abiertas.
Notas:
- Cada archivo detalle está ordenado por cod_usuario y fecha.
- Un usuario puede iniciar más de una sesión el mismo día en la misma o en diferentes
máquinas.
- El archivo maestro debe crearse en la siguiente ubicación física: /var/log.}

program eje4;
const 
	valoralto = 9999;
	DIMF = 5;
type
	tLog = record
		cod:integer;
		fecha:integer;
		tiempo:integer;
	end;
	
	tLog_M = record
		cod:integer;
		fecha:integer;
		tiempoTot:integer;
	end;
	
	tMaestro = file of tLog_M;
	tDetalle = file of tLog;
	tMaquinas = array [1..DIMF] of tDetalle;
	tRegistros = array [1..DIMF] of tLog;

procedure leer (var det:tDetalle, var log:tLog);
begin
	if not(eof(det)) then
		read(det,log)
	else
		log.cod:= valoralto;
end;


procedure minimo(var min:tLog, var maquinas:tMaquinas, var registros:tRegistros);
var
	i,indicemin:byte;
begin
	indicemin:=0;
	min.cod:=valoralto;
	for i:=1 to DIMF do 
		if registros[i].cod <> valoralto then
			if registros[i].fecha < min.fecha and registros[i].cod < min.cod then begin
				min:= registros[i];
				indicemin:=i;
			end;
	end;
	if indicemin<>0 and then
		leer(maquinas[indicemin], registros[indicemin]);
end;

procedure merge(var maquinas:tMaquina, var registros:tRegistros);
var
	i:byte
	min:tLog;
	nom:string;
	maestro:tMaestro;
	tiempoTot:integer;
	logM:tLog_M
	codAct:integer;
	fechaAct:integer;
begin
	for i:=1 to DIMF do begin
		reset(maquinas[i]);
		leer(maquinas[i],registros[i]);
	end;
	assign(maestro, '/var/log maestro');
	rewrite(maestro);
	minimo(min,maquinas,registros);
	while min.cod <> valoralto then begin
		tiempoTot:=0;
		codAct:= min.cod;
		while min.cod = codAct do begin
			fechaAct:=min.fecha;
			tiempoTot:=0
			while min.cod = codAct and min.fecha = fechaAct do begin
				tiempoTot:=tiempoTot + min.tiempo;
				minimo(min,maquinas,registros);
			end;
			logM.cod := codAct;
			logM.fecha:= fechaAct;
			logM.tiempo:= tiempoTot;
			write(maestro,logM);
		end;
	end;
	for i:=1 to DIMF do
		close(maquinas[i]);
	close(maestro);
end;
			
	
	
	
	
	
	
	
	
	
	


	
