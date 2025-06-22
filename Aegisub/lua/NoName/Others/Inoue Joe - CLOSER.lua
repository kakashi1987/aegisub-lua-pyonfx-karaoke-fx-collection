include("karaskel.lua")
include("zheolib.lua")

script_name = "Inoue Joe - CLOSER"
script_description = "Fx lua"
script_author = "ASEDARK to lua KFDS"
script_version = "1"

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
	aegisub.progress.task("fx_KFDS")
end


function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 25
if i==1 then
tiempo=0
end
function AutoTimer(TipoDeLinea,Intervalo,Tag,ValorInicialTag,AumentoTag,MasYMenos) 
local RESULTADO_01 = 0
RESULTADO_01=""
local RESULTADO_02 = 0
RESULTADO_02=""
local DIRECCION =1

if TipoDeLinea == TE1 then
DURACION =(line.start_time-800)/Intervalo
end

if TipoDeLinea == TE2 then
DURACION =(line.start_time+syl.start_time)/Intervalo
end

if TipoDeLinea == TE4 then
DURACION =(l.duration)/Intervalo
end

local count = math.ceil(DURACION) 
if math.random(0,5) == 0 then 
DIRECCION = -DIRECCION
end
function sil()
silaba = ""..syl.text_stripped..""
return silaba
end
for char in unicode.chars(sil()) do
if char == ' ' or char == '' then
l.text = "{}"
else


l = table.copy(line)
for i = 0,45 do
l.text = "{"..an(5)..move(x+30,y,x,y,0,400)..fad(400,0)..color(3,'&HFFFFFF&')..bord(0)..fry-(360)..t(0,400)..fry(0))..RangeColor(1,'&HFFFFFF&','&HD6FF6B&',768).."}"..char
l.start_time=line.start_time -400+tiempo
l.end_time=line.start_time+tiempo
l.layer=0
subs.append(l)
end


l = table.copy(line)
l.text = "{"..an(5)..move(x,y,x+20,y)..color(1,'&HFFFFFF&')..alpha(1,'&HFF&')..color(3,'&HFFFFFF&')..fscx(160)..fscy(160)..bord(2)..blur(10)..shad(2)..color(4,'&H000000&')..t(bord(0)..blur(0))..t(fscx(100)..fscy(100)..frz(0)).."}"..sil() 
l.start_time=line.start_time+syl.start_time
l.end_time=l.end_time+syl.start_time
l.layer=1
subs.append(l)


l = table.copy(line)
for j = 0,14 do
valpha={'11','22','33','44','55','66','77','88','99','110','121'}
rand_alpha= valpha[math.random(1,11)]
l.text = "{"..an(5)..move(x,y+j*4,x+j*2,y+j*4)..color(1,'&HFFFFFF&')..bord(0)..shad(0)..fscx(160)..fscy(160)..alfa(1,rand_alpha)..t(fscx(100)..fscy(100)..frz(0)).."}"..sil()
l.start_time=line.start_time+syl.start_time+(syl.duration/14)*j
l.end_time=l.end_time+syl.start_time
l.layer=2
subs.append(l)
end


l = table.copy(line)
for i = 0,45 do
l.text = "{"..an(5)..move(x,y,x+20,y)..color(1,'&HF57E66&')..bord(0)..color(3,'&HFFFFFF&')..RangeColor(1,'&HD6FF6B&','&HFFFFFF&',768).."}"..sil() 
l.start_time=line.start_time+syl.end_time
l.end_time=l.end_time+syl.end_time
l.layer=3
subs.append(l)
end


l = table.copy(line)
l.text = "{"..org(x,y)..an(5)..move(x,y,x-200,y)..fad(0,800)..color(1,'&HFFFFFF&')..color(3,'&HFFFFFF&')..bord(1)..blur(5)..t(fry(360)..fscx(0)..fscy(0)).."}"..char
l.start_time=line.start_time+syl.start_time
l.end_time=l.end_time+syl.start_time+300+tiempo
l.layer=4
subs.append(l)
tiempo=tiempo+(700/line.kara.n)


end
end

aegisub.register_macro("Inoue Joe - CLOSER", "", fx_KFDS)
aegisub.register_filter("Inoue Joe - CLOSER ", "", 2000, fx_KFDS)