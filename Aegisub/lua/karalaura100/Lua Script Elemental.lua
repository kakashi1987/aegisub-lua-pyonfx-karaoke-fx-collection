include("karaskel.lua")

script_name = "Lua Script Elemental"
script_description = "Lua Script Elemental"
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

			if syl.i == line.kara.n then
			fad_f = 300
			dur_f = 300
			else
			fad_f = 0
			dur_f = 0
			end

		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\fad(300,0)}%s",x,y,syl.text_stripped)
		l.start_time = line.start_time + 50*(syl.i-line.kara.n)
		l.end_time = line.start_time + syl.start_time
		l.layer = 0
		subs.append(l)

		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%s,%s)\\fscx120\\fscy120\\3c&HFFFFFF&\\blur2\\t(50,%d,\\fscx100\\fscy100\\3c%s\\blur0)\\fad(0,%s)}%s",x,y,syl.duration,line.styleref.color3,fad_f,syl.text_stripped)
		l.start_time = line.start_time + syl.start_time
		l.end_time = l.start_time + syl.duration + dur_f
		l.layer=2
		subs.append(l)

		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%s,%s)\\fad(0,300)}%s",x,y,syl.text_stripped)
		l.start_time = syl.duration + line.start_time + syl.start_time
		l.end_time = line.end_time + 50*(syl.i-line.kara.n)
		l.layer=0
		subs.append(l)
		
	end
end

temp = {}
function set_temp(ref,val)
		temp[ref] = val
		return val
end

aegisub.register_macro("Lua Script Elemental", "", generator_lua)