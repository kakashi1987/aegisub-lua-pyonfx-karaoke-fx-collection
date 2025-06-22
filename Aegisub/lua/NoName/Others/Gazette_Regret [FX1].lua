include("karaskel.lua")

script_name = ".::Gazette - ReGreT FX::."
script_description = "FX Gazette - Regret"
script_author = "Kirav751"
script_version = "1.1"

function fx_kirav751(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Ponindole Vida xD... (%d/%d)", ai, maxai))
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
	aegisub.progress.task("RoT_Fx")
	aegisub.progress.set(100)
	aegisub.set_undo_point("fx_kirav751")
end


function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 30
if i == 1 then
K=0
end

-----ENTRADA-----
l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d,0,600)\\fad(500,0)\\1c&H1D1D49&\\fry90\\frz90\\fscx120\\t(50,100,\\frx0\\fscy100\\frz0\\fry0\\fscx100)\\t(150,250,\\fscy100\\fscx100)}%s",x-50,y-math.random(-30,30),x,y,syl.text_stripped)
l.start_time = line.start_time-650
l.end_time = line.start_time+syl.start_time
l.layer=3
subs.append(l)

-----NI MIERDA----
l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\bord0\\t(\\bord1)}%s",x,y,line.styleref.color2,syl.text_stripped)
l.start_time = line.start_time+K
l.end_time = line.start_time+syl.start_time
l.layer=1
subs.append(l)
K=K+(1000/line.kara.n)


l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\shad0\\bord1}%s",x,y,syl.text_stripped)
l.start_time = line.start_time+syl.start_time+100
l.end_time = line.start_time+syl.start_time+10+syl.duration+20
l.layer=2
subs.append(l)

---ARRIBA----

l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,100)\\shad0\\bord1\\be5\\t(\\frz360)}%s",x,y,x,y+10,syl.text_stripped)
l.start_time = line.start_time+syl.start_time+10
l.end_time = line.start_time+syl.start_time+9+syl.duration+20
l.layer=3
subs.append(l)

----ABAJO----

l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\shad0\\bord1\\be5\\t(\\frz-360)}%s",x,y,x,y-10,syl.text_stripped)
l.start_time = line.start_time+syl.start_time+10
l.end_time = line.start_time+syl.start_time+9+syl.duration+20
l.layer=4
subs.append(l)




end
end

aegisub.register_macro(".::Gazette FX-1::.", "FX para Gazette - REGRET", fx_kirav751)
aegisub.register_filter(".::Gazette FX-1::.", "FX para Gazette - REGRET", 2000, fx_kirav751)