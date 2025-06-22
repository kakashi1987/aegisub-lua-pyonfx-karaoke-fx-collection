include("karaskel.lua")
include("zheolib.lua")


script_name = "EFFECT LUA.4_01"
script_description = "Simple effect for lua.4"
script_author = "Zheo_ (FX'alkoon')"
script_modified = "Alkoon_ Sunday, June 07, 2009"

 

function fx_lua(subs)
	aegisub.progress.task("ESPERA MIESTRAS SE HACE EL FX...")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("APPLYING FX.. (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and  not l.comment  then
			karaskel.preproc_line(subs, meta, styles, l)
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
       if i == 1 then  univers = 0
end

-- ## Agradecimiento a Nande! (("zheolib.lua"))
function RandomColor()
    colores = {'0','1','2','3','4','5','6','7','8','9','10','11','a','b','c','d','e','f','g','h','i'}
       rand_color= ""
              for j = 0,5 do
              rand_color = rand_color .. colores[math.random(1,15)]
       end
   return rand_color
end

      --# FX beginning
       l = table.copy(line)
       l.text = "{"..fad(200,0)..an(5)..pos(x,y)..shad(1.5)..color(1,RandomColor())..blur(10)..bord(0.5)..color(3,RandomColor())..color(4,RandomColor()).."}"..sil()
       l.start_time=l.start_time - 100 + univers
       l.end_time = l.end_time+ univers
       l.layer=2
       subs.append(l)

                             --# FX song effecte
                             l = table.copy(line)
                             l.text = "{"..move(x,y,x,y)..pos(x,y)..shad(0)..fad(50,250)..color(3,'HFFFFFF')..an(5)..t(bord(3))..blur(6)..t(bord(7)..blur(14))..t(bord(10)..blur(22)).."}"..sil()
                             l.start_time = line.start_time + syl.start_time
                             l.end_time=l.start_time+syl.duration+100
                             l.layer=0
                             subs.append(l)
                             l = table.copy(line)
                             l.text = "{"..move(x,y,x,y)..pos(x,y)..shad(0)..fad(50,250)..color(3,'H000000')..an(5)..t(bord(4))..blur(4.5).."}"..sil()
                             l.start_time = line.start_time + syl.start_time
                             l.end_time=l.start_time+syl.duration+100
                             l.layer=1
                             subs.append(l)

       --# FX callings exiting 
       l = table.copy(line)
       l.text = "{"..fad(0,150)..an(5)..org(x,y+50)..move(x,y,250,150)..frz(0)..shad(1.5)..bord(0.5)..blur(10)..color(1,RandomColor())..color(3,RandomColor())..t(frz(100))..t(frz(300)..frx(150)..fry(50)..fs(25)).."}"..sil()
       l.start_time = l.end_time+ univers
       l.end_time = l.start_time+ univers+750
       l.layer=3
       subs.append(l)
       univers=univers+(100/line.kara.n)
    end
end

aegisub.register_macro("kara effect", "ENJOY", fx_lua)
aegisub.register_filter("~ALKOON~", "SIMPLE EFFECT", 2000, fx_lua)