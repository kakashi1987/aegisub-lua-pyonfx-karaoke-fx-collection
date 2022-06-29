ass.load("J:\\AmberdrakeSubs\\Kara no Kyoukai BD\\work\\extra chorus\\knk_exch_[k-timed].ass")

local function kara(ctx, ms, line)
	local textcolor = g2d.create_color((76*1/255), (76*1/255), (76*1/255), 1)
	for si, syl in ipairs(line.syls) do
		if ms >= syl.start_time and ms < syl.end_time and syl.text ~= "" then
			local ang = math.rad(math.interpolate(1, 180, math.inrange(syl.start_time, syl.end_time, ms)))
			local sc = math.sin(ang)/2
			text = g2d.create_image("RGBA", syl.width, syl.height)
			local tctx = text:get_context()
			tctx:path_add_text(0, 0, syl.text, ass.unpack_font(line.styleref))
			tctx:set_line_width(1)
			tctx:set_source(textcolor)
			tctx:stroke()
			text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(1.5)))
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

function GetFrame(frame, frame_i)
	local ctx = frame:get_context()
	local ms = frame_i / VIDEO_FPS * 1000
	for li, line in ipairs(lines) do
		if ms >= line.start_time-line.infade and ms < line.end_time+line.outfade then
			kara(ctx, ms, line)
			
		end
	end
end