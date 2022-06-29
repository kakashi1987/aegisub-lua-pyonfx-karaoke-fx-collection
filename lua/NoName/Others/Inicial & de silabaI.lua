
include("karaskel.lua")
include("zheolib.lua")
script_name = "Efecto Inicial & de silabaI .. like brume&Blur "
script_description = "..Experimeto with..'be(0)'..'syl.width'.."
script_author = "alkoon"
script_version = "1.2"
script_method_effect  = "zheox.Modificado por : Universe"

function FX_LUA_2009(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and not l.comment  then  karaskel.preproc_line(subs, meta, styles, l)
		do_fx(subs, meta, l)
		maxi = maxi - 1
		subs.delete(i)
		else
		i = i + 1
		end
		ai = ai + 1
               end
end

function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 30

function sil()
		silaba = ""..syl.text_stripped..""
	return silaba
		end
if i == 1 then universe =  -100
end

--><><><><><><><><><><--
--# EFECTO INICIAL (1) #--
--><><><><><><><><><><--
--[[ 
l = table.copy(line)
ajuste = 3
mitad_sil = syl.width/2
for j = 0,  syl.width+ajuste do
l.start_time = line.start_time + syl.start_time- 2000+universe+j*50/400
l.end_time  = l.start_time
l.text = "{"..an(5)..move(x+rand(10),y+rand(10),x,y)..be(30)..bord(0)..fscx(500)..fscy(200)..fad(300,0)..RangeColor(1, j/(syl.width+ajuste), 'BC9F79', 'E3CEB2')..clip(x-(mitad_sil)-4+j*3, 0, x-(mitad_sil)+8+j*3, 100)..t(alpha"00"..fscxy(100)..be(0)).."}"..sil()
l.layer=0
subs.append(l)
end
]] --

--><><><><><><><><><><--
--# EFECTO INICIAL (2) #--
--><><><><><><><><><><--
            l = table.copy(line)
            ajuste = 0
            mitad_sil = syl.width/2
            for j = 0,  syl.width+ajuste do
            l.start_time=line.start_time -1000+universe+j*40/100
            l.end_time = line.start_time+universe

--l.start_time = line.start_time + syl.start_time- 1800+universe+j*40/100
--l.end_time  = line.start_time + syl.start _time 

            l.text = "{"..an(5)..move(x+rand(10)+15,y+rand(10)-14,x,y)..be(35)..alfa(1,'ff')..bord(0)..fscx(300)..fscy(150)..fad(300,0)..RangeColor(1, j/(syl.width+ajuste), 'BC9F79', 'F2E1CB')..clip(x-(mitad_sil)-4+j*2, 0, x-(mitad_sil)+8+j*2, 100)..t(be(2))..t(alpha"00"..fscxy(100)..be(0)).."}"..sil()
            l.layer=0     -----  >>>>>>>>>>>>>>>>>>>>>>>>>>>  -----   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   Other  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ---#..clip(x-(mitad_sil)-2+j*3, 0, x-(mitad_sil)+8+j*1, 100) #---
            subs.append(l)
            end

            l = table.copy(line)
            ajuste = 0
            mitad_sil =  syl.width/2
            for j = 0, syl.width+ajuste  do
            l.start_time=line.start_time+universe
            l.end_time = line.start_time + syl.start_time
            l.text = "{"..an(5)..move(x,y,x,y)..bord(0)..be(1)..RangeColor(1, j/(syl.width+ajuste), 'BC9F79', 'F2E1CB')..clip(x-(mitad_sil)-5+j*1, 0, x-(mitad_sil)+8+j*1, 100).."}"..sil()
            l.layer=0
            subs.append(l)
            end

	l = table.copy(line)
	ajuste = 3 
	mitad_sil =  syl.width/2
	for j = 0, syl.width+ajuste  do
	l.start_time=line.start_time+ syl.start_time  
	l.end_time=l.start_time + syl.end_time +j*40/100
--l.start_time=line.start_time+ syl.start_time 
--l.end_time = l.end_time + j*10
	l.text = "{"..an(5)..move(x,y,x+rand(15),y+rand(15)+15)..fad(0,200)..bord(0)..be(1)..RangeColor(1, j/(syl.width+ajuste), 'BC9F79', 'F2E1CB')..clip(x-(mitad_sil)-15+j*1, 0, x-(mitad_sil)+8+j*1, 100)..t(fscx(190)..fscy(120)..be(5))..t(fscx(300)..fscy(150)..be(15))..t(alfa(1,'ff')).."}"..sil()
	l.layer=0
	subs.append(l)
	end
	l = table.copy(line)
	ajuste = 3 
	mitad_sil =  syl.width/2
	for j = 0, syl.width+ajuste  do
	l.start_time=line.start_time+ syl.start_time  
	l.end_time=l.start_time + syl.end_time +j*40/100
--l.start_time=line.start_time+ syl.start_time 
--l.end_time = l.end_time + j*10
	l.text = "{"..an(5)..move(x,y,x+rand(8),y+rand(8)+15)..fad(0,200)..bord(0)..be(1)..RangeColor(1, j/(syl.width+ajuste), 'BC9F79', 'F2E1CB')..clip(x-(mitad_sil)-15+j*1, 0, x-(mitad_sil)+8+j*1, 100)..t(fscx(190)..fscy(120)..be(15))..t(fscx(200)..fscy(150)..be(40))..t(alfa(1,'ff')).."}"..sil()
	l.layer=0
	subs.append(l)
	end
             universe=universe+(500/line.kara.n)
      end
end

aegisub.register_filter("~ALKOON~", "", 2000, FX_LUA_2009)