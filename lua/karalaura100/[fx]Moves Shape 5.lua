include("karaskel.lua")

script_name = "moves shape 5"
script_description = "moves shape 5"
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

		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\fad(300,0)}%s",x,y,syl.text_stripped)
		l.start_time = line.start_time + 50*(syl.i-line.kara.n)
		l.end_time = line.start_time + syl.start_time
		l.layer = 0
		subs.append(l)

		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%s,%s)\\fscx120\\fscy120\\3c&HFFFFFF&\\blur2\\t(50,%d,\\fscx100\\fscy100\\3c%s\\blur0)\\fad(0,300)}%s",x,y,syl.duration+300,line.styleref.color3,syl.text_stripped)
		l.start_time = line.start_time + syl.start_time
		l.end_time = l.start_time + syl.duration + 300
		l.layer=2
		subs.append(l)
		
		l = table.copy(line)
		bucle = 1
		for n=1,bucle do
			local shape = "m 28 40 b 56 40 56 0 28 0 b 0 0 0 40 28 40 m 28 1 b 55 1 55 39 28 39 b 1 39 1 1 28 1"
			local shape2 = "m 34 82 b 24 80 15 79 5 79 l 0 99 b 8 104 19 108 28 111 b 28 117 28 122 30 128 b 21 132 10 136 2 142 l 7 161 l 7 161 b 17 161 26 160 36 158 b 38 164 42 169 46 175 b 39 183 33 191 28 200 l 43 214 b 51 209 59 203 66 196 b 71 200 76 204 83 206 b 82 216 81 226 82 236 l 101 241 b 106 232 109 224 112 215 b 119 216 126 217 133 216 b 136 225 141 233 146 242 l 165 237 b 165 227 165 218 162 208 b 167 206 172 203 177 199 b 184 205 193 210 202 216 l 215 202 b 210 193 205 186 198 179 b 203 174 206 168 209 161 b 218 163 228 163 238 163 l 243 145 b 235 140 226 136 217 133 b 218 125 217 116 216 109 b 225 106 234 102 243 97 l 238 80 b 228 79 218 80 208 81 b 206 76 202 70 198 65 b 204 58 210 49 214 41 l 200 27 b 191 33 184 39 177 45 b 171 40 166 37 159 34 b 160 24 161 14 160 5 l 143 0 b 137 9 133 18 130 27 b 123 26 116 25 109 26 b 106 17 103 9 98 0 l 79 4 b 79 14 79 23 81 33 b 75 36 70 39 64 44 b 56 37 49 31 41 26 l 26 40 b 31 49 37 57 44 64 b 40 69 37 75 34 82 m 45 120 b 45 16 199 17 199 120 b 199 225 45 225 45 120 m 103 102 l 93 98 l 86 113 l 96 118 b 96 151 138 151 144 128 b 151 103 123 84 103 102 m 107 119 b 107 101 135 101 135 119 b 135 139 107 139 107 119"
			local size_shape = math.random(12,18)
			local sign = (-1) ^ math.random(2)
			local color = _G.ass_color(_G.HSV_to_RGB(math.random(360),0.4,1))
			
			l.text = string.format("{\\an5\\pos(%s,%s)\\1c%s\\3c%s\\fscx%s\\fscy%s\\alpha&H44&\\t(\\fr%s)\\fad(50,250)\\p1}%s{\\p0}",x-20,y+math.random(-30,30),color,color,size_shape,size_shape,0.2*300*sign,shape2)
			l.start_time = line.start_time + syl.start_time
			l.end_time = l.start_time + 1000
			l.layer = 1
			subs.append(l)
		end
	end
end

temp = {}
function set_temp(ref,val)
		temp[ref] = val
		return val
end

aegisub.register_macro("moves shape 5", "", generator_lua)