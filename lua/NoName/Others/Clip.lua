include("karaskel.lua")
include("zheolib.lua")

script_name = "Clip"
script_description = "Script Lua4"
script_author = "alquimista"
script_version = "2.0"

function fx_Clip(subs)
	aegisub.progress.task("ESPERA MIESTRAS SE HACE EL FX... (Sale a dar una vuelta D:)")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Aplicando tu FX D:")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Esto llevo trabajado (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment and
				(l.style == "Default") then
				karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else
			i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("Clip")
	aegisub.progress.set(100)
	aegisub.set_undo_point("Clip")
end


function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 25
function sil()
silaba = ""..syl.text_stripped..""
return silaba
end


--//Calcular la posicion inicial y final del clip
ajuste = 5
X1 = x - (syl.width / 2 + ajuste)
X2 = x + (syl.width / 2 + ajuste)
Y1 = 0
Y2 = y + line.height + ajuste
       
clip_start = clip(X1, Y1, X1 ,Y2)
clip_end = clip(X1, Y1, X2 ,Y2)
kf = (clip_start..t(clip_end))

        
l = table.copy(line)
l.text = "{"..kf..pos(x,y)..color(1,'0808A5').."}"..sil()
l.start_time = line.start_time + syl.start_time
l.end_time = l.start_time + syl.duration
l.layer = 3
subs.append(l)


l = table.copy(line)
l.text = "{"..pos(x,y)..color(1,'0808A5').."}"..sil()
l.start_time = line.start_time + syl.start_time + syl.duration
l.end_time = line.end_time
l.layer = 2
subs.append(l)    


l = table.copy(line)
l.text = "{"..pos(x,y)..color(1,'ffffff').."}"..sil()
l.start_time = line.start_time
l.end_time = l.end_time
l.layer= 1
subs.append(l)

end	
end

aegisub.register_macro("Clip", "", fx_Clip)
aegisub.register_filter("Clip", "", 2000, fx_Clip)