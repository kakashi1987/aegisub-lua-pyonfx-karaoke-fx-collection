include("karaskel.lua")
include("formaslib.lua")

script_name = "LUA FX"
script_description = "Mi primer FX"
script_author = "Cucho"
script_version = "0.1"

function fx_KFDS(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment then
			karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else
			i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("Finished!")
	aegisub.progress.set(100)
	aegisub.set_undo_point("fx_KFDS") ----> Con eso logras hacer funcionar el ctrl+z asi que cada vez que aplikes el FX puedes deshacerlos 
	end
--TERMINA FUNCION GENERADOR-
--COMIENZAN LOS EFECTOS-
--CONFIGURACION DE X-Y-
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 15 -----> Esto es a la distancia que quedara del la perte de arriba, la alineacion de izq y dre lo hacemos en aegisub
if i ==1 then
tiempo=0
end
--FX Inicial-
l = table.copy(line) --#Esto hará que se copien las lineas, SIEMPRE debe ir.
l.text = string.format("{\\an8\\pos(%d,%d)}%s",x,y,line.styleref.color1,syl.text_stripped) ---> Aqui pondran los comandos de su entrada.
l.start_time = line.start_time ------> Configuración del Tiempo Inicial del FX
l.end_time = line.start_time ------> Configuración del Tiempo Final del FX
l.layer=0 ----> Numero de capa
subs.append(l) --#Hace que termine el Bloque.
	
--#string.format:contenedor de FX,cuando utilicemos Tag de .ass debemos poner doble \\,%S esto es para que el efecto se aplique al texto
--#si lo que queremos es usar una imagen quitamos el %S,luego de %S viene la declaracion del FX.
--#lo complicado es colocar ciertos Tag como \pos \move  y algun otro numerico, le ponemos un %d ej. \\pos(%d,%d)
--#para los alfanumericos como \1c \2c \1a \4a \{p1},etc le colocamos un %s.
--#el orden en la composicion del FX seria: FX,Texto,Config FX.
--#luego de los efectos, viene la parte de registro de nuestra macro, para q salga en el menu de automation (
--#(saldra como JR-F FX!).

	
	
--SILABA ESTATICA-
l = table.copy(line)
l.text = string.format("{\\an8\\pos(%d,%d)}%s",x,y,line.styleref.color1,syl.text_stripped) ---> Aqui pondran los comandos.
l.start_time = line.start_time ------> Configuración del Tiempo Inicial del FX
l.end_time = line.start_time+syl.start_time------> Configuración del Tiempo Final del FX
l.layer=0  ----> Numero de capa
subs.append(l)
	
--Definición por nickle: Son silabas de "empalme" que se usan entre los efectos. Si te fijas, los efectos de la línea generalmente son en este orden: [entrada]-estático-animación-estático-[salida],
--¿que son esos estáticos?
--Simplemente son las silabas que no están activas en el momento

--FX DE SILABAS-
l = table.copy(line)
l.text = string.format("{\\an8\\pos(%d,%d)\\blur7}%s", x, y, line.styleref.color2, syl.text_stripped)
l.start_time=line.start_time+syl.start_time ------> Configuración del Tiempo Inicial del FX
l.end_time=l.start_time+syl.duration  ------> Configuración del Tiempo Final del FX
l.layer = 2   ----> Numero de capa
subs.append(l)
end
end	
--(Opcional)
--FIGURAS EN EL FX- (no es obligatorio que lleve esto pero se ve bien)
--Utilizaremos en este ejemplo la figura del Script '~Rimless~' de Nickle este es un poco avanzado

--color={"&H0000FF&","&H7E00C1&","&HD5A9EC&","&H6E00A8&"} ----> Configuracion de los Colores
--l = table.copy(line)
--for r=0,20 do -----> Cantidad de veces que saldra la figura 
--fs=math.random(50,90)
--alpha=ass_alpha(math.random(100,255))
--local pcolor=color[math.random(1,4)]  ----> Hara que se asigne a cada pasada del bucle un color aleatorio a la variable “pcolor”
--l.start_time=line.start_time+syl.start_time+math.random(0,syl.duration)
--l.end_time=l.start_time+math.random(300,700)
--l.text = string.format("{\\p1\\pos(%d,%d)\\fad(50,70)\\1c%s\\alpha%s\\an8\\be5\\bord0\\fscx%d\\fscy%d}m 0 0 m 10 20 b 16 20 20 16 20 10 b 20 4 16 0 10 0 b 2 0 0 6 0 10 b 0 16 4 20 10 20{\\p0}", -x+math.random(-50,50),y+math.random(-15,15),pcolor,alpha,fs,fs) -----> aqui van los comando de lo que hara la figura...  m 0 0 l 0 0 l 5 7 l 15 9 l 23 4 l 25 -5 l 22 -13 l 11 -17 l 1 -11 l 0 -1 Es el codigo del Dibujo si pegan el codigo en ASSDRAW podran ver que es una especie de octagono  :p 
--l.layer=1
--subs.append(l)
--end
--end
--end
	
--TERMINAN LOS EFECTOS-

--REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--
	aegisub.register_macro("FX C", "", fx_KFDS)
aegisub.register_filter("FX C", "", 2000, fx_KFDS) ----> "FX!"
	
--TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--
