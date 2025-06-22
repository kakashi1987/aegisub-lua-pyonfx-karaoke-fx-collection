--Kara no Kyoukai: Mirai Fukuin - Extra Chorus
--Karaoke by Amberdrake
--LVS

ass.load("J:\\AmberdrakeSubs\\Kara no Kyoukai BD\\work\\extra chorus\\knk_exch_[k-timed].ass")

local function kara(ctx, ms, line)
	if line.infade>1000 then
		line.infade=1000
	end
	if line.outfade>1000 then
		
		line.outfade=1000
	end
	local textcolor = g2d.create_color((76*1/255), (76*1/255), (76*1/255), 1)
	--inactive syls
	for si, syl in ipairs(line.syls) do
		if ms >= line.start_time and ms < line.end_time and syl.text ~= "" then
			ctx:path_add_text(syl.x, syl.y, syl.text, ass.unpack_font(line.styleref))
			ctx:set_source(textcolor)
			ctx:fill()
			ctx:path_clear()
		end
	end
	--active syls
	if line.style=="ED_romanji" or line.style=="ED_kanji" then
		maxj=8
		for j=2,maxj,0.5 do
			for si, syl in ipairs(line.syls) do
				if ms >= syl.start_time and ms < syl.end_time and syl.text ~= "" then
					local ang = math.rad(math.interpolate(1, 180, math.inrange(syl.start_time, syl.end_time, ms)))
					local sc = math.sin(ang)/j
					text = g2d.create_image("RGBA", syl.width, syl.height)
					local tctx = text:get_context()
					tctx:path_add_text(0, 0, syl.text, ass.unpack_font(line.styleref))
					tctx:set_line_width(1)
					local pct = math.sin((math.inrange(syl.start_time, syl.end_time, ms) * math.pi)/2)
					local alpha = math.interpolate(1, 0 , pct)
					local gradient_width = 0.25
					local gradient_progress = (1 + gradient_width) * math.inrange(syl.start_time, syl.end_time, ms)
					if line.style == "ED_romanji" then
						grad_start_x = syl.x
						grad_start_y = syl.y
						grad_end_x = syl.x
						grad_end_y = syl.y+syl.height
					end
					if line.style == "ED_kanji" then
						grad_start_x = syl.x
						grad_start_y = syl.y-60
						grad_end_x = syl.x
						grad_end_y = syl.y+syl.height-60
					end
					tctx:set_source(
					g2d.create_lgradient(syl.x, grad_start_y, grad_end_x, grad_end_y)
					:add_color(-gradient_width + gradient_progress,(76*1/255), (76*1/255), (76*1/255), alpha)
					:add_color(-gradient_width/2 + gradient_progress,(96*1/255), (96*1/255), (96*1/255), alpha)
					:add_color(gradient_progress,(76*1/255), (76*1/255), (76*1/255), alpha)
					)
					tctx:stroke()
					text = g2d.create_pattern(text)
					text:set_matrix(g2d.create_matrix()
					:translate(syl.width/2 + syl.x, syl.y)
					:scale(1+sc, 1+sc)
					:translate(-syl.width/2, 0)
					:scale(1, 1)
					)
					ctx:set_source(text)
					ctx:paint()
				end
			end
		end
	end
	--fadein
	for si, syl in ipairs(line.syls) do
		if ms >= line.start_time-line.infade and ms < line.start_time and syl.text ~= "" then
			ctx:path_add_text(syl.x, syl.y, syl.text, ass.unpack_font(line.styleref))
			local cx, cy = syl.x + syl.width/2, syl.y + syl.height/2
			local gradient_width = 0.75
			local gradient_progress = (1 + gradient_width) * math.inrange(line.start_time-line.infade, line.start_time, ms)
			ctx:set_source(
			g2d.create_rgradient(cx,cy,0, cx,cy,math.distance(syl.width/2,syl.height/2))
			:add_color(-gradient_width + gradient_progress,(76*1/255), (76*1/255), (76*1/255), 1)
			:add_color(gradient_progress,(76*1/255), (76*1/255), (76*1/255), 0)
			)
			ctx:fill()
			ctx:path_clear()
		end
	end
	--fadeout
	for si, syl in ipairs(line.syls) do
		if ms >= line.end_time and ms < line.end_time+line.outfade and syl.text ~= "" then
			ctx:path_add_text(syl.x, syl.y, syl.text, ass.unpack_font(line.styleref))
			local cx, cy = syl.x + syl.width/2, syl.y + syl.height/2
			local gradient_width = 0.75
			local gradient_progress = (1 + gradient_width) * math.inrange(line.end_time, line.end_time+line.outfade, ms)
			ctx:set_source(
			g2d.create_rgradient(cx,cy,0, cx,cy,math.distance(syl.width/2,syl.height/2))
			:add_color(-gradient_width + gradient_progress,(76*1/255), (76*1/255), (76*1/255), 0)
			:add_color(gradient_progress,(76*1/255), (76*1/255), (76*1/255), 1)
			)
			ctx:fill()
			ctx:path_clear()
		end
	end
end
function GetFrame(frame, frame_i)
	local ctx = frame:get_context()
	local ms = frame_i / VIDEO_FPS * 1000
	for li, line in ipairs(lines) do
		if ms >= line.start_time-line.infade and ms < line.end_time+line.outfade then
			kara(ctx, ms, line)
			
		end
	end
end