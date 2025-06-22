-- Karaoke Effect by Spyne21 - Vsfilter

function shape.split(shape, len)
	if type(shape) ~= "string" or (type(len) ~= "number" and type(len) ~= "nil") then
		error("string and optional number expected", 2)
	end

	--Split curves
	local function find_curve_points(buffer, b_points, p1, p2, last_len)
		local p12 = p1 + (p2-p1) / 2
		local point1, point12, point2 = math.bezier(p1, b_points), math.bezier(p12, b_points), math.bezier(p2, b_points)
		local len1, len2 = math.distance(point12[1]-point1[1], point12[2]-point1[2]), math.distance(point2[1]-point12[1], point2[2]-point12[2])
		if (len1+len2) - last_len > 0.01 then
			return find_curve_points( find_curve_points(buffer, b_points, p1, p12, len1) , b_points, p12, p2, len2)
		else
			if #buffer == 0 then
				buffer = buffer .. string.format("%d %d l ", math.round(point1[1]), math.round(point1[2]))
			end
			return buffer .. string.format("%d %d ", math.round(point2[1]), math.round(point2[2]))
		end
	end
	local function evaluate_curve(x1, y1, x2, y2, x3, y3, x4, y4)
		return find_curve_points("", {
			{tonumber(x1), tonumber(y1)},
			{tonumber(x2), tonumber(y2)},
			{tonumber(x3), tonumber(y3)},
			{tonumber(x4), tonumber(y4)}
		}, 0, 1, 0):sub(1,-2)
	end
	do
		local hit
		--Add 'b' to extend curves
		repeat
			shape, hit = shape:gsub("(" ..  string.rep("%-?%d+%s+", 2) .. "b" .. string.rep("%s+%-?%d+", 6) .. ")(%s+%-?%d+)", "%1 b%2", 1)
		until hit == 0
		--Curves to lines
		repeat
			shape, hit = shape:gsub(string.rep("(%-?%d+)%s+", 2) .. "b" .. string.rep("%s+(%-?%d+)", 6), evaluate_curve, 1)
		until hit == 0
	end

	--Split lines
	if len then
		--Collect shape points
		local points = {}
		for typ, x, y in shape:gmatch("(m?)%s*(%-?%d+)%s+(%-?%d+)") do
			table.insert(points, {typ = typ, x = x, y = y})
		end
		--Build new shape
		shape = ""
		for pi = 1, #points do
			local point = points[pi]
			if pi == 1 or point.typ == "m" then
				shape = shape .. string.format("m %d %d ", point.x, point.y)
			else
				local pre_point = points[pi-1]
				if pre_point.typ == "m" then
					shape = shape .. "l "
				end
				--Split lines
				local cur_len = math.distance( point.x - pre_point.x, point.y - pre_point.y )
				if cur_len > len then
					local offset = math.mod(cur_len, len) == 0 and len or math.mod(cur_len, len)
					for i = offset, cur_len, len do
						local pct = i / cur_len
						local x = math.round( pre_point.x + (point.x-pre_point.x) * pct )
						local y = math.round( pre_point.y + (point.y-pre_point.y) * pct )
						shape = shape .. string.format("%d %d ", x, y)
					end
				else
					shape = shape .. string.format("%d %d ", point.x, point.y)
				end
			end
		end
		shape = shape:sub(1,-2)
	end

	--Return
	return shape
end

function roumaji(line, l)
	for ci, char in ipairs(line.chars) do
		if char.text~=" " then
			--Getting text shape
			local text_shape = convert.text_to_shape(char.text, line.styleref)
			--Flatten text shape
			text_shape = shape.split( text_shape,16)
			local color = "&HFFFFFF&"
			local color_3c = "&H000000&"
			max_frame=40
			-- Définition du compteur de de fadout
			u_in=0
			u_out=0			
			for s, e, i, n in utils.frames(line.start_time-line.infade/2, line.end_time+line.outfade/2, max_frame) do
				l.start_time = s
				l.end_time = e
				-- Partie Fad-in/out
				fad=300
				maxu=math.ceil(fad/max_frame)
				if i<math.ceil(fad/max_frame) then
					alpha = utils.interpolate(u_in/maxu, "&HFF&", "&H00&")
					u_in=u_in+1
				elseif i>(n-math.ceil(fad/max_frame)) then
					alpha = utils.interpolate(u_out/maxu, "&H00&", "&HFF&")
					u_out=u_out+1
				else
					alpha="&H00&"
				end
				local fs=0
				l.layer=0
				-- Partie changement de couleur
				if s>=(line.start_time+char.start_time) and s<(line.start_time+char.start_time+char.duration/2) then
					color_3c = utils.interpolate(math.sin((s - (line.start_time+char.start_time)) / char.duration * math.pi), "&H000000&", "&HFFFFFF&")
					fs=utils.interpolate(math.sin((s - (line.start_time+char.start_time)) / char.duration * math.pi), 0, 25)
					l.layer=fs
				end
				if s>=(line.start_time+char.start_time+char.duration/2) and s<=(line.start_time+char.end_time) then
					color_3c = utils.interpolate(math.sin((s - (line.start_time+char.start_time+char.duration/2)) / char.duration * math.pi), "&HFFFFFF&", "&H000000&")
					fs=utils.interpolate(math.sin((s - (line.start_time+char.start_time+char.duration/2)) / char.duration * math.pi), 25, 0)
					l.layer=fs
				end
				-- Partie déformation du texte
				local frame_pct = i / n
				local deformed_text_shape = shape.filter(text_shape,
				function(x,y)
					local x_add = 0
					local y_add =math.sin(x/(line.height/4)+frame_pct*50)*10
					return x + x_add, y + y_add
				end)
				l.text = string.format("{\\an7\\bord2\\shad0\\blur2\\1c%s\\3c%s\\alpha%s\\fscx%s\\fscy%s\\pos(%.3f,%.3f)\\p4}%s"
				,color,color_3c,alpha,fs+100,fs+100,char.left-fs/8, line.top-fs/2+math.sin(char.left/(line.width/10)+frame_pct*20)*10,deformed_text_shape)
				io.write_line(l)
			end
		end
	end
end

for li, line in ipairs(lines) do
	roumaji( line, table.copy(line) )
	io.progressbar(li / #lines)
end