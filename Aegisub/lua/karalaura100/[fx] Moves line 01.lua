include("karaskel.lua")

script_name = "Moves Line 01"
script_description = "Moves Line 01"
script_author = "KaraLaura"
script_version = "1.0"

function generator_lua(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and not l.comment then
			karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("Finished!")
	aegisub.progress.set(100)
	aegisub.set_undo_point("KaraLaura")
end

function do_fx(subs, meta, line)
	for i = 1, line.kara.n do
		local syl = line.kara[i]
		local x = syl.center + line.left
		local y = line.middle

		ratio = 3*meta.res_y/4
		arc = line.kara[line.kara.n].center - line.kara[1].center
		theta_i =180*arc/(ratio*math.pi)
		theta_f = 270 + theta_i/2
		arc_relative = math.pi*ratio*theta_f/180
		theta_relative = math.rad((arc_relative+line.kara[syl.i].center-line.kara[1].center)*180/(math.pi*ratio))
		delay = 2000

		l = table.copy(line)
		l.text = string.format("{\\an8\\mover(%s,%s,%s,%s,%s,%s,%s,%s[,0,%s])\\fr%s\\t(0,%s,\\fr%s)\\t(%s,%s,\\3c&HFFFFFF&\\c&HFFFFFF&\\bord2\\blur3)\\t(%s,%s,\\3c%s\\1c&HFFFFFF&\\bord1\\blur0)\\t(%s,%s,\\alpha&HFF&)}%s",line.center,y-ratio,line.center,y-ratio,math.deg(theta_relative),math.deg(theta_relative)-2*theta_i,ratio,ratio,line.duration+2*delay,math.deg(theta_relative+math.pi/2),line.duration+2*delay,math.deg(theta_relative+math.pi/2)-2*theta_i,syl.start_time+delay,syl.start_time+delay+50,syl.start_time+delay+50,syl.start_time+delay+syl.duration,line.styleref.color1,line.duration+2*delay-800,line.duration+2*delay-300,syl.text_stripped)
		l.start_time = line.start_time - delay
		l.end_time = line.start_time + line.duration + 2*delay
		l.layer = 0
		subs.append(l)
		
	end
end

temp = {}
function set_temp(ref,val)
		temp[ref] = val
		return val
end

aegisub.register_macro("Moves Line 01", "", generator_lua)