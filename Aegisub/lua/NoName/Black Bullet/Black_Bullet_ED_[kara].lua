--Black Bullet 01 ED
--Karaoke by Amberdrake
--LVS

ass.load("Black Bullet ED.ass")
local function infade_bord(ctx, ms, line)
	for si, syl in ipairs(line.syls) do
		if ms >= line.start_time-line.infade+50*syl.i-50 and ms < line.start_time-line.infade+50*syl.i+200 and syl.text ~= "" then
			local pct = math.inrange(line.start_time-line.infade+50*syl.i-50, line.start_time-line.infade+50*syl.i+200, ms)
			local alpha = math.interpolate(0, 1 , pct)
			text = g2d.create_image("RGBA", syl.width+20, syl.height+20)
			local tctx = text:get_context()
			tctx:path_add_text(5, 0, syl.text, ass.unpack_font(line.styleref))
			tctx:set_line_width(5)
			tctx:set_source(g2d.create_color(16/255, 6/255, 133/255, 1))
			tctx:stroke()
			text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(2)))
			text:set_matrix(g2d.create_matrix()
			:translate(syl.x-5, syl.y)
			)
			ctx:set_source(text)
			ctx:masked_paint(alpha)
		end
	end
end
local function infade(ctx, ms, line)
	for si, syl in ipairs(line.syls) do
		if ms >= line.start_time-line.infade+50*syl.i-50 and ms < line.start_time-line.infade+50*syl.i+200 and syl.text ~= "" then
			ctx:path_add_text(syl.x, syl.y, syl.text, ass.unpack_font(line.styleref))
			local cx, cy = syl.x + syl.width/2, syl.y + syl.height/2
			local gradient_width = 0.75
			local gradient_progress = (1 + gradient_width) * math.inrange(line.start_time-line.infade+50*syl.i-50, line.start_time-line.infade+50*syl.i+200, ms)
			ctx:set_source(
			g2d.create_rgradient(cx,cy,0, cx,cy,math.distance(syl.width/2,syl.height/2))
			:add_color(-gradient_width + gradient_progress,1, 1, 1, 1)
			:add_color(gradient_progress,1, 1, 1, 0)
			)
			ctx:fill()
			ctx:path_clear()
		end
	end
end
local function placeholder_bord(ctx, ms, line)
	if line.style == "ED_romanji" or line.style == "ED_kanji" then
		for si, syl in ipairs(line.syls) do
			if ms >= line.start_time-line.infade+50*syl.i+200 and ms < syl.start_time and syl.text ~= "" then
				text = g2d.create_image("RGBA", syl.width+20, syl.height+20)
				local tctx = text:get_context()
				tctx:path_add_text(5, 0, syl.text, ass.unpack_font(line.styleref))
				tctx:set_line_width(5)
				tctx:set_source(g2d.create_color(16/255, 6/255, 133/255, 1))
				tctx:stroke()
				text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(2)))
				text:set_matrix(g2d.create_matrix()
				:translate(syl.x-5, syl.y)
				)
				ctx:set_source(text)
				ctx:paint()
			end
		end
	end
end
local function placeholder(ctx, ms, line)
	if line.style == "ED_romanji" or line.style == "ED_kanji" then
		for si, syl in ipairs(line.syls) do
			if ms >= line.start_time-line.infade+50*syl.i+200 and ms < syl.start_time and syl.text ~= "" then
				ctx:path_add_text(syl.x, syl.y, syl.text, ass.unpack_font(line.styleref))
				ctx:set_source(g2d.create_color(1, 1, 1, 1))
				ctx:fill()
				ctx:path_clear()
			end
		end
	end
end
local function fx_bord(ctx, ms, line)
	if line.style == "ED_romanji" or line.style == "ED_kanji" then
		for si, syl in ipairs(line.syls) do
			if ms >= syl.start_time and ms < syl.end_time and syl.text ~= "" then
				text = g2d.create_image("RGBA", syl.width+20, syl.height+20)
				local tctx = text:get_context()
				tctx:path_add_text(10, 10, syl.text, ass.unpack_font(line.styleref))
				tctx:set_line_width(5)
				local pct = math.inrange(syl.start_time, syl.end_time, ms)
				local ang = math.rad(math.interpolate(1, 180, math.inrange(syl.start_time, syl.end_time, ms)))
				local sc = math.sin(ang)/4
				local gradient_width = 1
				local gradient_progress = (1 + gradient_width) * math.inrange(syl.start_time, syl.end_time, ms)
				tctx:set_source(g2d.create_color(16/255, 6/255, 133/255, 1))
				tctx:stroke()
				text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(2)))
				text:set_matrix(g2d.create_matrix()
				:translate(syl.x-10, syl.y-10)
				:scale(1, 1+sc)
				:translate(0, -syl.height/18)
				:scale(1, 1)
				)
				ctx:set_source(text)
				ctx:paint()
			end
		end
	end
end
local function fx(ctx, ms, line)
	if line.style == "ED_romanji" or line.style == "ED_kanji" then
		for si, syl in ipairs(line.syls) do
			if ms >= syl.start_time and ms < syl.end_time and syl.text ~= "" then
				text = g2d.create_image("RGBA", syl.width+20, syl.height+20)
				local tctx = text:get_context()
				tctx:path_add_text(10, 10, syl.text, ass.unpack_font(line.styleref))
				local pct = math.inrange(syl.start_time, syl.end_time, ms)
				local ang = math.rad(math.interpolate(1, 180, math.inrange(syl.start_time, syl.end_time, ms)))
				local sc = math.sin(ang)/4
				local gradient_width = 1
				local gradient_progress = (1 + gradient_width) * math.inrange(syl.start_time, syl.end_time, ms)
				tctx:set_source(
				g2d.create_lgradient(10, 0, syl.width+10, 0)
				:add_color(-gradient_width + gradient_progress, 1, 1, 1, 1)
				:add_color(-gradient_width/2 + gradient_progress, 88/255, 154/255, 248/255, 1)
				:add_color(gradient_progress, 1, 1, 1, 1)
				)
				tctx:fill()
				text = g2d.create_pattern(text)
				text:set_matrix(g2d.create_matrix()
				:translate(syl.x-10, syl.y-10)
				:scale(1, 1+sc)
				:translate(0, -syl.height/18)
				:scale(1, 1)
				)
				ctx:set_source(text)
				ctx:paint()
			end
		end
	end
end
local function placeholder_bord2(ctx, ms, line)
	if line.style == "ED_romanji" or line.style == "ED_kanji" then
		for si, syl in ipairs(line.syls) do
			if ms >= syl.end_time and ms < line.end_time + line.outfade + 50*syl.i - 300 and syl.text ~= "" then
				text = g2d.create_image("RGBA", syl.width+20, syl.height+20)
				local tctx = text:get_context()
				tctx:path_add_text(5, 0, syl.text, ass.unpack_font(line.styleref))
				tctx:set_line_width(5)
				tctx:set_source(g2d.create_color(16/255, 6/255, 133/255, 1))
				tctx:stroke()
				text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(2)))
				text:set_matrix(g2d.create_matrix()
				:translate(syl.x-5, syl.y)
				)
				ctx:set_source(text)
				ctx:paint()
			end
		end
	end
end
local function placeholder2(ctx, ms, line)
	if line.style == "ED_romanji" or line.style == "ED_kanji" then
		for si, syl in ipairs(line.syls) do
			if ms >= syl.end_time and ms < line.end_time + line.outfade + 50*syl.i - 300 and syl.text ~= "" then
				ctx:path_add_text(syl.x, syl.y, syl.text, ass.unpack_font(line.styleref))
				ctx:set_source(g2d.create_color(1, 1, 1, 1))
				ctx:fill()
				ctx:path_clear()
			end
		end
	end
end
local function TL_bord(ctx, ms, line)
	if line.style == "ED_TL" then
		for si, syl in ipairs(line.syls) do
			if ms >= line.start_time-line.infade+50*syl.i+200 and ms < line.end_time + line.outfade + 50*syl.i - 300 and syl.text ~= "" then
				text = g2d.create_image("RGBA", syl.width+20, syl.height+20)
				local tctx = text:get_context()
				tctx:path_add_text(5, 0, syl.text, ass.unpack_font(line.styleref))
				tctx:set_line_width(5)
				tctx:set_source(g2d.create_color(16/255, 6/255, 133/255, 1))
				tctx:stroke()
				text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(2)))
				text:set_matrix(g2d.create_matrix()
				:translate(syl.x-5, syl.y)
				)
				ctx:set_source(text)
				ctx:paint()
			end
		end
	end
end
local function TL(ctx, ms, line)
	if line.style == "ED_TL" then
		for si, syl in ipairs(line.syls) do
			if ms >= line.start_time-line.infade+50*syl.i+200 and ms < line.end_time + line.outfade + 50*syl.i - 300 and syl.text ~= "" then
				ctx:path_add_text(syl.x, syl.y, syl.text, ass.unpack_font(line.styleref))
				ctx:set_source(g2d.create_color(1, 1, 1, 1))
				ctx:fill()
				ctx:path_clear()
			end
		end
	end
end
local function outfade_bord(ctx, ms, line)
	for si, syl in ipairs(line.syls) do
		if ms >= line.end_time + line.outfade + 50*syl.i - 300 and ms < line.end_time + line.outfade + 50*syl.i - 50 and syl.text ~= "" then
			local pct = math.inrange(line.end_time + line.outfade + 50*syl.i - 300, line.end_time + line.outfade + 50*syl.i - 50, ms)
			local alpha = math.interpolate(1, 0 , pct)
			text = g2d.create_image("RGBA", syl.width+20, syl.height+20)
			local tctx = text:get_context()
			tctx:path_add_text(5, 0, syl.text, ass.unpack_font(line.styleref))
			tctx:set_line_width(5)
			tctx:set_source(g2d.create_color(16/255, 6/255, 133/255, 1))
			tctx:stroke()
			text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(2)))
			text:set_matrix(g2d.create_matrix()
			:translate(syl.x-5, syl.y)
			)
			ctx:set_source(text)
			ctx:masked_paint(alpha)
		end
	end
end
local function outfade(ctx, ms, line)
	for si, syl in ipairs(line.syls) do
		if ms >= line.end_time + line.outfade + 50*syl.i - 300 and ms < line.end_time + line.outfade + 50*syl.i - 50 and syl.text ~= "" then
			ctx:path_add_text(syl.x, syl.y, syl.text, ass.unpack_font(line.styleref))
			local cx, cy = syl.x + syl.width/2, syl.y + syl.height/2
			local gradient_width = 0.75
			local gradient_progress = (1 + gradient_width) * math.inrange(line.end_time + line.outfade + 50*syl.i - 300, line.end_time + line.outfade + 50*syl.i - 50, ms)
			ctx:set_source(
			g2d.create_rgradient(cx,cy,0, cx,cy,math.distance(syl.width/2,syl.height/2))
			:add_color(-gradient_width + gradient_progress,1, 1, 1, 0)
			:add_color(gradient_progress,1, 1, 1, 1)
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
		infade_bord(ctx, ms, line)
		infade(ctx, ms, line)
		placeholder_bord(ctx, ms, line)
		placeholder(ctx, ms, line)
		fx_bord(ctx, ms, line)
		fx(ctx, ms, line)
		placeholder_bord2(ctx, ms, line)
		placeholder2(ctx, ms, line)
		TL_bord(ctx, ms, line)
		TL(ctx, ms, line)
		outfade_bord(ctx, ms, line)
		outfade(ctx, ms, line)
	end
end