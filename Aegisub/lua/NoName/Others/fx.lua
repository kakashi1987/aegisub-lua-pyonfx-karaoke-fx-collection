include("zheolib.lua")
include("karaskel.lua")

script_name = "LUA FX"
script_description = "FX"
script_author = "Riuuzaki"
script_version = "1.0"

function fx_lua(subs)
	aegisub.progress.task("ESPERA MIENTRAS SE APLICA EL EFECTO")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Creando FX")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("(%d/%d)", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment and
				(l.style == "OP-Romaji") then
				karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else
			i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("PROCESO TERMINADO")
	aegisub.progress.set(100)
	aegisub.set_undo_point("fx_lua")
	end
	
	function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 50
if i ==1 then
tiempo=0
end

function sil()
silaba = ""..syl.text_stripped..""
		return silaba
		end	
		
if syl.inline_fx == "rojo" then
colortres = "&H8687F1&"
elseif syl.inline_fx == "nor" then
colortres = "&H2D6A01&"
elseif syl.inline_fx == "verde" then
colortres = "&HE5FCBF&"
elseif syl.inline_fx == "nara" then
colortres = "&HADC8FF&"
elseif syl.inline_fx == "ama" then
colortres = "&HFFFFFF&"
elseif syl.inline_fx == "azul" then
colortres = "&H742D00&"
elseif syl.inline_fx == "rosa" then
colortres = "&H36016C&"
elseif syl.inline_fx == "mora" then
colortres = "&H730067&"
elseif syl.inline_fx == "az" then
colortres = "&H676200&"
elseif syl.inline_fx == "gris" then
colortres = "&H000000&"

end

		
		
if syl.inline_fx == "rojo" then
coloruno = "&H1306A3&" 
elseif syl.inline_fx == "nor" then
coloruno = "&H6ED083&" 
elseif syl.inline_fx == "verde" then
coloruno = "&H85920A&"
elseif syl.inline_fx == "nara" then
coloruno = "&H226AFC&"
elseif syl.inline_fx == "ama" then
coloruno = "&H05DFDD&"
elseif syl.inline_fx == "azul" then
coloruno = "&HE57C3E&"
elseif syl.inline_fx == "rosa" then
coloruno = "&H700CD9&"
elseif syl.inline_fx == "mora" then
coloruno = "&HFB2BEF&"
elseif syl.inline_fx == "az" then
coloruno = "&HDDC83C&&"
elseif syl.inline_fx == "gris" then
coloruno = "&H8A6951&"

end


if line.actor == 'diferente' then

l = table.copy(line)
l.text ="{"..an(5)..pos(x,y)..bord(3)..blur(5)..shad(2)..color(3,'&HFFFFFF&')..color(1,'&HFFFFFF&')..color(4,'&HFFFFFF&')..alfa(1,20)..alfa(3,50)..alfa(3,50)..t(fscy(180)..fscx(120)).."}"..sil()
l.start_time=line.start_time + syl.start_time
l.end_time=l.start_time + syl.duration
l.layer = 2
subs.append(l)

l = table.copy(line)
l.text ="{"..an(5)..move(x,y-50,x,y)..bord(5)..be(1)..blur(2).."}"..sil()
l.start_time=line.start_time - 400
l.end_time=line.start_time+syl.start_time
l.layer = 0
subs.append(l)

l = table.copy(line)
l.text ="{"..an(5)..move(x,y,x-100,y)..bord(5)..be(1)..blur(2)..fad(0,500).."}"..sil()
l.start_time=line.start_time + syl.start_time+syl.duration
l.end_time=l.start_time + 500
l.layer = 0
subs.append(l)

 
 else
		
--fx inicial		
		
l = table.copy(line)
l.text ="{"..an(5)..pos(x,y)..shad(0)..bord(5)..fry(-90)..be(5)..blur(3)..t(fry(0)).."}"..sil()
l.start_time=line.start_time - 300
l.end_time=line.start_time+syl.start_time+(syl.duration/2)
l.layer = 0
subs.append(l)

--move derecha

l = table.copy(line)
l.text ="{"..an(5)..shad(0)..blur(3)..bord(5)..color(1,coloruno)..color(3,colortres)..move(x,y,x-(syl.width/2),y-46)..fad(0,200).."}"..sil()
l.start_time=line.start_time+syl.start_time+(syl.duration/2)
l.end_time=l.start_time+syl.duration
l.layer = 0
subs.append(l)


--move izquierda

l = table.copy(line)
l.text ="{"..an(5)..shad(0)..blur(3)..bord(5)..color(1,coloruno)..color(3,colortres)..move(x,y,x+(syl.width/2),y-46)..fad(0,200).."}"..sil()
l.start_time=line.start_time+syl.start_time+(syl.duration/2)
l.end_time=l.start_time+syl.duration
l.layer = 0
subs.append(l)




-- calavera
		
l = table.copy(line)
l.text = "{"..an(5)..clip(x-syl.width/2,y-syl.height/2,x+syl.width/2,y)..fscxy(150)..color(3,coloruno)..bord(3)..color(1,'&HFFFFFF&')..t(move(x-(syl.width/2),y+100,x,y+(syl.height/2))..clip(x,)).."}"..p(2,'m -32 -28 b -31 -34 -24 -32 -26 -27 l -15 -17 b -14 -21 -5 -27 0 -26 b 7 -27 14 -22 15 -17 l 26 -26 b 24 -32 31 -34 31 -28 b 38 -26 33 -19 29 -23 l 16 -13 b 20 -13 24 -13 28 -11 b 24 -10 20 -10 16 -10 b 17 -4 12 2 11 2 l 29 21 b 37 17 38 27 31 27 b 29 35 21 29 25 24 l 8 5 b 4 8 -4 8 -7 5 b -8 7 -9 9 -10 12 b -4 19 4 19 10 12 b 9 10 8 7 7 5 b 7 5 8 5 8 5 l 8 5 b 9 7 10 10 11 12 b 14 23 4 25 0 25 b -5 25 -14 23 -11 12 b -10 9 -9 7 -8 5 l -26 23 b -21 29 -29 35 -32 27 b -38 27 -37 17 -30 20 l -11 2 b -12 2 -17 -4 -16 -10 b -21 -10 -25 -10 -27 -11 b -23 -13 -20 -13 -16 -13 l -29 -23 b -33 -19 -38 -26 -32 -28 m 0 -2 b -1 -2 -2 -1 -2 1 b -1 3 1 3 2 1 b 2 -1 1 -2 0 -2 m -3 -7 b -3 -12 -10 -13 -12 -8 b -13 -5 -11 -3 -9 -2 b -6 -1 -3 -4 -3 -7 m 12 -8 b 10 -13 3 -12 3 -7 b 3 -4 6 -1 9 -2 b 11 -3 13 -5 12 -8 ')
l.start_time=line.start_time+syl.start_time
l.end_time=line.start_time+syl.start_time+(syl.duration/2)
l.layer = 0
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..fscxy(150)..color(3,coloruno)..bord(3)..color(1,'&HFFFFFF&')..move(x,y+(syl.height/2),x+(syl.width/2),y+100).."}"..p(2,'m -32 -28 b -31 -34 -24 -32 -26 -27 l -15 -17 b -14 -21 -5 -27 0 -26 b 7 -27 14 -22 15 -17 l 26 -26 b 24 -32 31 -34 31 -28 b 38 -26 33 -19 29 -23 l 16 -13 b 20 -13 24 -13 28 -11 b 24 -10 20 -10 16 -10 b 17 -4 12 2 11 2 l 29 21 b 37 17 38 27 31 27 b 29 35 21 29 25 24 l 8 5 b 4 8 -4 8 -7 5 b -8 7 -9 9 -10 12 b -4 19 4 19 10 12 b 9 10 8 7 7 5 b 7 5 8 5 8 5 l 8 5 b 9 7 10 10 11 12 b 14 23 4 25 0 25 b -5 25 -14 23 -11 12 b -10 9 -9 7 -8 5 l -26 23 b -21 29 -29 35 -32 27 b -38 27 -37 17 -30 20 l -11 2 b -12 2 -17 -4 -16 -10 b -21 -10 -25 -10 -27 -11 b -23 -13 -20 -13 -16 -13 l -29 -23 b -33 -19 -38 -26 -32 -28 m 0 -2 b -1 -2 -2 -1 -2 1 b -1 3 1 3 2 1 b 2 -1 1 -2 0 -2 m -3 -7 b -3 -12 -10 -13 -12 -8 b -13 -5 -11 -3 -9 -2 b -6 -1 -3 -4 -3 -7 m 12 -8 b 10 -13 3 -12 3 -7 b 3 -4 6 -1 9 -2 b 11 -3 13 -5 12 -8 ')
l.start_time=line.start_time+syl.start_time+(syl.duration/2)
l.end_time=line.start_time+syl.start_time+syl.duration
l.layer = 0
subs.append(l)	

--calavera sombrero


l = table.copy(line)
l.text = "{"..an(5)..fscxy(150)..color(3,coloruno)..bord(3)..color(1,'&HFFFFFF&')..move(x-(syl.width/2),y+100,x,y+(syl.height/2)).."}"..p(2,'m -32 -28 b -31 -34 -24 -32 -26 -27 l -15 -17 b -14 -21 -5 -27 0 -26 b 7 -27 14 -22 15 -17 l 26 -26 b 24 -32 31 -34 31 -28 b 38 -26 33 -19 29 -23 l 16 -13 b 20 -13 24 -13 28 -11 b 24 -10 20 -10 16 -10 b 17 -4 12 2 11 2 l 29 21 b 37 17 38 27 31 27 b 29 35 21 29 25 24 l 8 5 b 4 8 -4 8 -7 5 b -8 7 -9 9 -10 12 b -4 19 4 19 10 12 b 9 10 8 7 7 5 b 7 5 8 5 8 5 l 8 5 b 9 7 10 10 11 12 b 14 23 4 25 0 25 b -5 25 -14 23 -11 12 b -10 9 -9 7 -8 5 l -26 23 b -21 29 -29 35 -32 27 b -38 27 -37 17 -30 20 l -11 2 b -12 2 -17 -4 -16 -10 b -21 -10 -25 -10 -27 -11 b -23 -13 -20 -13 -16 -13 l -29 -23 b -33 -19 -38 -26 -32 -28 m 0 -2 b -1 -2 -2 -1 -2 1 b -1 3 1 3 2 1 b 2 -1 1 -2 0 -2 m -3 -7 b -3 -12 -10 -13 -12 -8 b -13 -5 -11 -3 -9 -2 b -6 -1 -3 -4 -3 -7 m 12 -8 b 10 -13 3 -12 3 -7 b 3 -4 6 -1 9 -2 b 11 -3 13 -5 12 -8 ')
l.start_time=line.start_time+syl.start_time
l.end_time=line.start_time+syl.start_time+(syl.duration/2)
l.layer = 0
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..fscxy(150)..color(3,coloruno)..bord(3)..color(1,'&HFFFFFF&')..move(x,y+(syl.height/2),x+(syl.width/2),y+100).."}"..p(2,'m -32 -28 b -31 -34 -24 -32 -26 -27 l -15 -17 b -14 -21 -5 -27 0 -26 b 7 -27 14 -22 15 -17 l 26 -26 b 24 -32 31 -34 31 -28 b 38 -26 33 -19 29 -23 l 16 -13 b 20 -13 24 -13 28 -11 b 24 -10 20 -10 16 -10 b 17 -4 12 2 11 2 l 29 21 b 37 17 38 27 31 27 b 29 35 21 29 25 24 l 8 5 b 4 8 -4 8 -7 5 b -8 7 -9 9 -10 12 b -4 19 4 19 10 12 b 9 10 8 7 7 5 b 7 5 8 5 8 5 l 8 5 b 9 7 10 10 11 12 b 14 23 4 25 0 25 b -5 25 -14 23 -11 12 b -10 9 -9 7 -8 5 l -26 23 b -21 29 -29 35 -32 27 b -38 27 -37 17 -30 20 l -11 2 b -12 2 -17 -4 -16 -10 b -21 -10 -25 -10 -27 -11 b -23 -13 -20 -13 -16 -13 l -29 -23 b -33 -19 -38 -26 -32 -28 m 0 -2 b -1 -2 -2 -1 -2 1 b -1 3 1 3 2 1 b 2 -1 1 -2 0 -2 m -3 -7 b -3 -12 -10 -13 -12 -8 b -13 -5 -11 -3 -9 -2 b -6 -1 -3 -4 -3 -7 m 12 -8 b 10 -13 3 -12 3 -7 b 3 -4 6 -1 9 -2 b 11 -3 13 -5 12 -8 ')
l.start_time=line.start_time+syl.start_time+(syl.duration/2)
l.end_time=line.start_time+syl.start_time+syl.duration
l.layer = 0
subs.append(l)	



end
	

		
		end
		end		
		
		
		
		
aegisub.register_macro("FX", "", fx_lua)
aegisub.register_filter("FX", "", 2000, fx_lua)