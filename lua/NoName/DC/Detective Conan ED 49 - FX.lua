include("karaskel.lua")

script_name = "Detective Conan ED 49 - FX "
script_version = "1.2"
script_author = "ALKOON"

function fx_conan(subs)
	aegisub.progress.set(0)
       aegisub.set_undo_point(script_name)
	aegisub.progress.task("Getting header data..")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Applying Script")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect... (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and not l.comment  then
		        karaskel.preproc_line(subs, meta, styles, l)
if l.actor =="1" then
		        do_fx1(subs, meta, l)
else
		        do_fx2(subs, meta, l)
end
		        l.comment = true
		        subs[i] = l
		else
		        i = i + 1
		end
		ai = ai + 1

	end
            aegisub.progress.set(100)
       aegisub.set_undo_point(script_name)	
end

function t(estilos)
	return "\\t(" ..estilos.. ")"
end

function tt(t1,t2,acel)
	if not t2 and not acel then
		return "" ..math.floor(t1).. ","
	elseif not acel then
		return "" ..math.floor(t1).. "," ..math.floor(t2).. ","
	else
		return "" ..math.floor(t1).. "," ..math.floor(t2).. ","..acel..","
	end
end


 
                  function frames(starts, ends, frame_time)
	if type(starts) ~= "number" or type(ends) ~= "number" or type(frame_time) ~= "number" or frame_time <= 0 then
		error("number, number and number expected", 2)
	end

	local cur_start_time, i, n = starts, 0, math.ceil((ends - starts) / frame_time)
	local function next_frame()
		if cur_start_time >= ends then
			return nil
		end
		local return_start_time = cur_start_time
		local return_end_time = return_start_time + frame_time <= ends and return_start_time + frame_time or ends
		cur_start_time = return_end_time
		i = i + 1
		return return_start_time, return_end_time, i, n
	end
	return next_frame     
                  end



function do_fx1(subs, meta, line)
 
           local sp = " {\\bord1\\p3\\shad0\\1c&HD8D7D4&} m 520 255 l 522 260 l 540 267 l 540 273 l 522 280 l 520 285 m 517 229 l 520 234 l 538 239 l 539 245 l 522 254 l 520 259 m 511 203 l 514 208 l 533 211 l 535 217 l 519 227 l 518 233 m 503 178 l 507 183 l 526 184 l 528 189 l 513 202 l 512 207 m 492 155 l 496 158 l 515 157 l 518 163 l 504 177 l 504 182 m 479 132 l 483 135 l 502 132 l 505 138 l 493 153 l 494 158 m 463 111 l 468 114 l 487 109 l 490 114 l 480 130 l 481 135 m 446 92 l 451 94 l 469 87 l 473 92 l 464 109 l 466 114 m 426 74 l 431 76 l 448 67 l 453 71 l 446 89 l 448 94 m 405 59 l 410 60 l 426 50 l 431 53 l 426 72 l 429 77 m 382 46 l 387 47 l 402 35 l 408 38 l 405 57 l 408 61 m 358 36 l 363 36 l 377 22 l 383 25 l 382 44 l 385 48 m 333 28 l 338 27 l 351 12 l 356 14 l 357 33 l 362 37 m 307 22 l 313 21 l 323 5 l 329 7 l 332 26 l 337 29 m 281 20 l 286 18 l 295 1 l 301 2 l 306 20 l 311 23 m 255 20 l 260 18 l 267 0 l 273 0 l 280 18 l 285 20 m 229 23 l 234 20 l 239 2 l 245 1 l 254 18 l 259 20 m 203 29 l 208 26 l 211 7 l 217 5 l 227 21 l 233 22 m 178 37 l 183 33 l 184 14 l 189 12 l 202 27 l 207 28 m 155 48 l 158 44 l 157 25 l 163 22 l 177 36 l 182 36 m 132 61 l 135 57 l 132 38 l 138 35 l 153 47 l 158 46 m 111 77 l 114 72 l 109 53 l 114 50 l 130 60 l 135 59 m 92 94 l 94 89 l 87 71 l 92 67 l 109 76 l 114 74 m 74 114 l 76 109 l 67 92 l 71 87 l 89 94 l 94 92 m 59 135 l 60 130 l 50 114 l 53 109 l 72 114 l 77 111 m 46 158 l 47 153 l 35 138 l 38 132 l 57 135 l 61 132 m 36 182 l 36 177 l 22 163 l 25 157 l 44 158 l 48 155 m 28 207 l 27 202 l 12 189 l 14 184 l 33 183 l 37 178 m 22 233 l 21 227 l 5 217 l 7 211 l 26 208 l 29 203 m 20 259 l 18 254 l 1 245 l 2 239 l 20 234 l 26 219 m 20 285 l 18 280 l 0 273 l 0 267 l 18 260 l 20 255 m 23 311 l 20 306 l 2 301 l 1 295 l 18 286 l 20 281 m 29 337 l 26 332 l 7 329 l 5 323 l 21 313 l 22 307 m 37 362 l 33 357 l 14 356 l 12 351 l 27 338 l 28 333 m 48 385 l 44 382 l 25 383 l 22 377 l 36 363 l 36 358 m 61 408 l 57 405 l 38 408 l 35 402 l 47 387 l 46 382 m 77 429 l 72 426 l 53 431 l 50 426 l 60 410 l 59 405 m 94 448 l 89 446 l 71 453 l 67 448 l 76 431 l 74 426 m 114 466 l 109 464 l 92 473 l 87 469 l 94 451 l 92 446 m 135 481 l 130 480 l 114 490 l 109 487 l 114 468 l 111 463 m 158 494 l 153 493 l 138 505 l 132 502 l 135 483 l 132 479 m 182 504 l 177 504 l 163 518 l 157 515 l 158 496 l 155 492 m 207 512 l 202 513 l 189 528 l 184 526 l 183 507 l 178 503 m 233 518 l 227 519 l 217 535 l 211 533 l 208 514 l 203 511 m 259 520 l 254 522 l 245 539 l 239 538 l 234 520 l 229 517 m 285 520 l 280 522 l 273 540 l 267 540 l 260 522 l 255 520 m 311 517 l 306 520 l 301 538 l 295 539 l 286 522 l 281 520 m 337 511 l 332 514 l 329 533 l 323 535 l 313 519 l 307 518 m 362 503 l 357 507 l 356 526 l 351 528 l 338 513 l 333 512 m 385 492 l 382 496 l 383 515 l 377 518 l 363 504 l 358 504 m 408 479 l 405 483 l 408 502 l 402 505 l 387 493 l 382 494 m 429 463 l 426 468 l 431 487 l 426 490 l 410 480 l 405 481 m 448 446 l 446 451 l 453 469 l 448 473 l 431 464 l 426 466 m 466 426 l 464 431 l 473 448 l 469 453 l 451 446 l 446 448 m 481 405 l 480 410 l 490 426 l 487 431 l 468 426 l 463 429 m 494 382 l 493 387 l 505 402 l 502 408 l 483 405 l 479 408 m 504 358 l 504 363 l 518 377 l 515 383 l 496 382 l 492 385 m 512 333 l 513 338 l 528 351 l 526 356 l 507 357 l 503 362 m 518 307 l 519 313 l 535 323 l 533 329 l 514 332 l 511 337 m 520 281 l 522 286 l 539 295 l 538 301 l 520 306 l 517 311 m 268 20 b 411 17 524 136 520 271 b 522 411 406 520 269 521 b 127 519 19 408 20 269 b 21 135 127 19 268 20 m 345 270 b 345 275 366 288 382 299 b 430 328 484 356 494 323 b 498 307 505 293 504 270 b 505 247 498 233 494 217 b 484 184 430 212 382 241 b 366 252 345 265 345 270 m 323 217 b 327 221 351 215 370 211 b 424 198 482 179 466 149 b 457 135 452 120 435 105 b 420 88 405 83 391 74 b 361 58 342 116 329 170 b 325 189 319 213 323 217 m 270 195 b 275 195 288 174 299 158 b 328 110 356 56 323 46 b 307 42 293 35 270 36 b 247 35 233 42 217 46 b 184 56 212 110 241 158 b 252 174 265 195 270 195 m 217 217 b 221 213 215 189 211 170 b 198 116 179 58 149 74 b 135 83 120 88 105 105 b 88 120 83 135 74 149 b 58 179 116 198 170 211 b 189 215 213 221 217 217 m 195 270 b 195 265 174 252 158 241 b 110 212 56 184 46 217 b 42 233 35 247 36 270 b 35 293 42 307 46 323 b 56 356 110 328 158 299 b 174 288 195 275 195 270 m 217 323 b 213 319 189 325 170 329 b 116 342 58 361 74 391 b 83 405 88 420 105 435 b 120 452 135 457 149 466 b 179 482 198 424 211 370 b 215 351 221 327 217 323 m 270 345 b 265 345 252 366 241 382 b 212 430 184 484 217 494 b 233 498 247 505 270 504 b 293 505 307 498 323 494 b 356 484 328 430 299 382 b 288 366 275 345 270 345 m 323 323 b 319 327 325 351 329 370 b 342 424 361 482 391 466 b 405 457 420 452 435 435 b 452 420 457 405 466 391 b 482 361 424 342 370 329 b 351 325 327 319 323 323 "

          local sp1 = " {\\bord0\\p3\\shad0\\1c&H3F3C37&\\be1} m 520 255 l 522 260 l 540 267 l 540 273 l 522 280 l 520 285 m 517 229 l 520 234 l 538 239 l 539 245 l 522 254 l 520 259 m 511 203 l 514 208 l 533 211 l 535 217 l 519 227 l 518 233 m 503 178 l 507 183 l 526 184 l 528 189 l 513 202 l 512 207 m 492 155 l 496 158 l 515 157 l 518 163 l 504 177 l 504 182 m 479 132 l 483 135 l 502 132 l 505 138 l 493 153 l 494 158 m 463 111 l 468 114 l 487 109 l 490 114 l 480 130 l 481 135 m 446 92 l 451 94 l 469 87 l 473 92 l 464 109 l 466 114 m 426 74 l 431 76 l 448 67 l 453 71 l 446 89 l 448 94 m 405 59 l 410 60 l 426 50 l 431 53 l 426 72 l 429 77 m 382 46 l 387 47 l 402 35 l 408 38 l 405 57 l 408 61 m 358 36 l 363 36 l 377 22 l 383 25 l 382 44 l 385 48 m 333 28 l 338 27 l 351 12 l 356 14 l 357 33 l 362 37 m 307 22 l 313 21 l 323 5 l 329 7 l 332 26 l 337 29 m 281 20 l 286 18 l 295 1 l 301 2 l 306 20 l 311 23 m 255 20 l 260 18 l 267 0 l 273 0 l 280 18 l 285 20 m 229 23 l 234 20 l 239 2 l 245 1 l 254 18 l 259 20 m 203 29 l 208 26 l 211 7 l 217 5 l 227 21 l 233 22 m 178 37 l 183 33 l 184 14 l 189 12 l 202 27 l 207 28 m 155 48 l 158 44 l 157 25 l 163 22 l 177 36 l 182 36 m 132 61 l 135 57 l 132 38 l 138 35 l 153 47 l 158 46 m 111 77 l 114 72 l 109 53 l 114 50 l 130 60 l 135 59 m 92 94 l 94 89 l 87 71 l 92 67 l 109 76 l 114 74 m 74 114 l 76 109 l 67 92 l 71 87 l 89 94 l 94 92 m 59 135 l 60 130 l 50 114 l 53 109 l 72 114 l 77 111 m 46 158 l 47 153 l 35 138 l 38 132 l 57 135 l 61 132 m 36 182 l 36 177 l 22 163 l 25 157 l 44 158 l 48 155 m 28 207 l 27 202 l 12 189 l 14 184 l 33 183 l 37 178 m 22 233 l 21 227 l 5 217 l 7 211 l 26 208 l 29 203 m 20 259 l 18 254 l 1 245 l 2 239 l 20 234 l 26 219 m 20 285 l 18 280 l 0 273 l 0 267 l 18 260 l 20 255 m 23 311 l 20 306 l 2 301 l 1 295 l 18 286 l 20 281 m 29 337 l 26 332 l 7 329 l 5 323 l 21 313 l 22 307 m 37 362 l 33 357 l 14 356 l 12 351 l 27 338 l 28 333 m 48 385 l 44 382 l 25 383 l 22 377 l 36 363 l 36 358 m 61 408 l 57 405 l 38 408 l 35 402 l 47 387 l 46 382 m 77 429 l 72 426 l 53 431 l 50 426 l 60 410 l 59 405 m 94 448 l 89 446 l 71 453 l 67 448 l 76 431 l 74 426 m 114 466 l 109 464 l 92 473 l 87 469 l 94 451 l 92 446 m 135 481 l 130 480 l 114 490 l 109 487 l 114 468 l 111 463 m 158 494 l 153 493 l 138 505 l 132 502 l 135 483 l 132 479 m 182 504 l 177 504 l 163 518 l 157 515 l 158 496 l 155 492 m 207 512 l 202 513 l 189 528 l 184 526 l 183 507 l 178 503 m 233 518 l 227 519 l 217 535 l 211 533 l 208 514 l 203 511 m 259 520 l 254 522 l 245 539 l 239 538 l 234 520 l 229 517 m 285 520 l 280 522 l 273 540 l 267 540 l 260 522 l 255 520 m 311 517 l 306 520 l 301 538 l 295 539 l 286 522 l 281 520 m 337 511 l 332 514 l 329 533 l 323 535 l 313 519 l 307 518 m 362 503 l 357 507 l 356 526 l 351 528 l 338 513 l 333 512 m 385 492 l 382 496 l 383 515 l 377 518 l 363 504 l 358 504 m 408 479 l 405 483 l 408 502 l 402 505 l 387 493 l 382 494 m 429 463 l 426 468 l 431 487 l 426 490 l 410 480 l 405 481 m 448 446 l 446 451 l 453 469 l 448 473 l 431 464 l 426 466 m 466 426 l 464 431 l 473 448 l 469 453 l 451 446 l 446 448 m 481 405 l 480 410 l 490 426 l 487 431 l 468 426 l 463 429 m 494 382 l 493 387 l 505 402 l 502 408 l 483 405 l 479 408 m 504 358 l 504 363 l 518 377 l 515 383 l 496 382 l 492 385 m 512 333 l 513 338 l 528 351 l 526 356 l 507 357 l 503 362 m 518 307 l 519 313 l 535 323 l 533 329 l 514 332 l 511 337 m 520 281 l 522 286 l 539 295 l 538 301 l 520 306 l 517 311 m 268 20 b 411 17 524 136 520 271 b 522 411 406 520 269 521 b 127 519 19 408 20 269 b 21 135 127 19 268 20 m 345 270 b 345 275 366 288 382 299 b 430 328 484 356 494 323 b 498 307 505 293 504 270 b 505 247 498 233 494 217 b 484 184 430 212 382 241 b 366 252 345 265 345 270 m 323 217 b 327 221 351 215 370 211 b 424 198 482 179 466 149 b 457 135 452 120 435 105 b 420 88 405 83 391 74 b 361 58 342 116 329 170 b 325 189 319 213 323 217 m 270 195 b 275 195 288 174 299 158 b 328 110 356 56 323 46 b 307 42 293 35 270 36 b 247 35 233 42 217 46 b 184 56 212 110 241 158 b 252 174 265 195 270 195 m 217 217 b 221 213 215 189 211 170 b 198 116 179 58 149 74 b 135 83 120 88 105 105 b 88 120 83 135 74 149 b 58 179 116 198 170 211 b 189 215 213 221 217 217 m 195 270 b 195 265 174 252 158 241 b 110 212 56 184 46 217 b 42 233 35 247 36 270 b 35 293 42 307 46 323 b 56 356 110 328 158 299 b 174 288 195 275 195 270 m 217 323 b 213 319 189 325 170 329 b 116 342 58 361 74 391 b 83 405 88 420 105 435 b 120 452 135 457 149 466 b 179 482 198 424 211 370 b 215 351 221 327 217 323 m 270 345 b 265 345 252 366 241 382 b 212 430 184 484 217 494 b 233 498 247 505 270 504 b 293 505 307 498 323 494 b 356 484 328 430 299 382 b 288 366 275 345 270 345 m 323 323 b 319 327 325 351 329 370 b 342 424 361 482 391 466 b 405 457 420 452 435 435 b 452 420 457 405 466 391 b 482 361 424 342 370 329 b 351 325 327 319 323 323 "

local l = table.copy(line)
 

          local fsz =  string.format("\\fscx%d\\fscy%d", 40, 40)

          for i = 1, line.kara.n do  
          local x, y = line.center, line.middle


	
          if i == 1 then
  
                                 
		l.text = string.format("{\\an5"..fsz.."\\move(%d,%d,%d,%d)\\t(\\frz35)\\t(\\frz0)\\p1}", line.left , y-45, line.left,y) .. sp
 
		l.layer = 1
		l.start_time = line.start_time -250
		l.end_time = line.start_time   
		subs.append(l) 

		l.text = string.format("{\\an5"..fsz.."\\move(%d,%d,%d,%d)\\t(\\frz35)\\t(\\frz0)\\p1}", line.left-12 , y-45, line.left-12,y) .. sp1
 
		l.layer = 0
		l.start_time = line.start_time -250
		l.end_time = line.start_time   
		subs.append(l) 
		---------------------------------------------------\\\---------------------------------------------------
		---------------------------------------------------\\\---------------------------------------------------
 
		l.text = string.format("{\\an5\\move(%d,%d,%d,%d)"..fsz.."\\t(\\frz360)\\p1}", line.right , y , line.right, 950) .. sp
 
		l.layer = 1
		l.start_time = line.end_time  
		l.end_time = line.end_time   + 600 
		subs.append(l) 

		l.text = string.format("{\\an5\\move(%d,%d,%d,%d)"..fsz.."\\t(\\frz360)\\p1}", line.right-12 , y , line.right-12, 950) .. sp1
 
		l.layer = 0
		l.start_time = line.end_time  
		l.end_time = line.end_time   + 600 
		subs.append(l) 
          end
          end

          for i = 1, line.kara.n do
          local syl = line.kara[i]
          local x = syl.center + line.left 
          local y1 = line.middle

		 if syl.text_stripped ~= "" then
		
      durz= 90*(math.ceil(syl.duration/500)+1)
		else
                                          durz= 0
		end

 		l.start_time = line.start_time+ syl.start_time
		l.end_time = line.start_time + syl.end_time 
		l.text = string.format("{\\an5\\move(%d,%d,%d,%d)"..fsz.."\\t(\\frz-%d)\\p1}", x-syl.width/2+2,y1 ,x +syl.width/2+2,y1, durz) .. sp
 
		l.layer = 1
		subs.append(l) 

 		l.start_time = line.start_time+ syl.start_time
		l.end_time = line.start_time + syl.end_time 
		l.text = string.format("{\\an5\\move(%d,%d,%d,%d)"..fsz.."\\t(\\frz-%d)\\p1}", x-12-syl.width/2+2,y1-8 ,x -12+syl.width/2+2,y1-8, durz) .. sp1
 
		l.layer = 0
		subs.append(l) 
 
        end


          for i = 1, line.kara.n do
          local cn = 0  
          for c in unicode.chars(line.text_stripped) do 
          cn = cn + 1 
          end	
          local ci = 0
      
          local syl = line.kara[i]
          local x = syl.center + line.left 
          local y = line.middle

                
                if i==1 then modi_tiempo=0 end

                
                function sil()
                
                silaba = ""..syl.text_stripped..""
                
                return silaba
                
                end

                local x=syl.center + line.left
                local y=line.middle

                posicion_anterior=0

                longsil=string.len(sil())

                modt=0

                modtend=0


                for char in unicode.chars(sil()) do

                tam_caracter,tam_caractery=aegisub.text_extents(line.styleref,char)

                xx=line.left + syl.left +tam_caracter/2+posicion_anterior


                ci = ci + 1
                iniEnf=line.start_time+syl.start_time+modt-20

                finEnf=line.start_time+syl.end_time-(syl.duration/3.8)+modt  
                duracion=finEnf-iniEnf
--[[0000]]

                if char == "" or char == " " then l.text = "{}" else

                
               if x <= 640 then
                
               m = - syl.i*40  - 150
                
               else
                
               m =     -line.width + syl.i*40  - 150*2
                
               end
                                           local l = table.copy(line)
                                           l.text = string.format("{\\move(%d,%d,%d,%d)\\fad(150,0)\\an5\\bord1\\shad0\\be1\\1c&HFFFFFF&}%s",xx, y, xx, y, char)
                                           l.start_time=line.start_time + m
                                           l.end_time= iniEnf 
                                           l.layer = 2
                                           subs.append(l)

	                          local l = table.copy(line)
	                          l.start_time =    finEnf
	                          l.end_time = line.end_time  +150 
	                          l.layer = 1
	                          l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,110)\\an5\\bord1\\shad0\\be1\\1c&HFFFFFF&}%s",xx, y, xx, y, char)
	                          subs.append(l)

                
               if line.effect == "2" then 
                
               cc = "\\1c&H2A638B&" 
                
               elseif line.effect == "1" then
                
               cc = "\\1c&HD6CCB2&"
                               elseif line.effect == "3" then 
                
               cc = "\\1c&HD4A09C&"
                
               end

                
                local dur = syl.duration 
                
                l.start_time=iniEnf  
                
                l.end_time=finEnf   	
                
                l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\an5\\bord1\\be1\\shad0\\1c&Hffffff&\\t(0,"..dur/(2)..","..cc.."\\shad0.5\\fscy120\\fscx130)\\t("..dur/(2)..","..dur..",\\1c&Hffffff&\\shad0\\fscy100\\fscx100)}%s",xx,y+3,xx,y, char)
                
                l.layer=7
                
                subs.append(l)	



                                 if syl.duration <= 75 then
                
                	modt=modt+100/(longsil*2)
                
                elseif syl.duration <= 100 then
                
                	modt=modt+250/(longsil*2)
                
                elseif syl.duration <= 250 then
                
                	modt=modt+500/(longsil*2)
                
                elseif syl.duration <= 1100 then
                
                	modt=modt+700/(longsil*2)
                
                elseif syl.duration < 2000  then
                
                	modt=modt+800/(longsil*2)
                
                elseif syl.duration >= 3000 then
                
                	modt=modt+1100/(longsil*2)
                
                else
                
                	modt=modt+1200/(longsil*2)
                
                end

                
                 modt=modt+syl.duration/10

                
                 posicion_anterior=posicion_anterior+tam_caracter

                end
 
               end
         end
end



function do_fx2(subs, meta, line)

          for i = 1, line.kara.n do
          local syl = line.kara[i]
          local x = syl.center + line.left 
          local y = line.middle
          local l = table.copy(line)
 
 if line.actor =="4" then

	 	local shap2 = "{\\p1}m 0 0 b 2 -2 5 -2 7 0 b 8 2 8 4 7 6 b 5 7 2 7 0 6 b -1 4 -1 1 0 0  "	
 	 	local shap = "{\\p1}m 0 0 b 2 -2 5 -2 7 0 b 8 2 8 4 7 6 b 5 7 2 7 0 6 b -1 4 -1 1 0 0  "		
		local px1 =line.left+syl.left
		local px2 =line.left+syl.right

	  	local y1, y2 = y-syl.height/2.5, y+syl.height/2.5
	  	local x1, x2 = px1, px2

                                    loops = syl.height
	  	local crclx = 360/loops 
	  	local radx = (x2-x1) /2
	  	local rady = (y2-y1) /2 

	  	for j=1, loops do

		     	local l=table.copy(line)
	                      	local csx = math.cos((crclx*j)*(math.pi/350))*radx
	                       	local sny = math.sin((crclx*j)*(math.pi*2/350))*rady
	                       	local posx, posy  = x+csx, y+sny 
	                       	local rand =  math.random(-45,45)

                    		local xx  = math.cos(math.rad(j*15))*math.random(-25,35)
                    		local yy  = math.sin(math.rad(j*15))*math.random(-25,35)

                                         	local alfa =string.format("alpha&H%02X&",20)  
            	  	     	local sizft = (j/loops)
	  	     	l.start_time=line.start_time+syl.start_time- ((j/loops)-1)*syl.duration 
	  	     	l.end_time=line.start_time+syl.start_time - ((j/loops)-1)*syl.duration + 750
	  	     	tt = l.end_time - l.start_time
                                                      fs1 = 50
                                                      fss = 20
                                                      tfr = ((400)-1)*sizft
	  	     	local textfx = string.format("{\\an5\\shad0\\fad(0,150)\\bord0\\blur1\\1c&H645EE3&\\fscx%d\\fscy%d}",fs1,fs1)
	  	     	l.text= string.format("{\\t(\\1c&HBCE0FE&)\\t(\\fr"..tfr..")\\t(%d,%d,\\fscx%d\\fscy%d\\blur6)\\move(%f.01,%f.01,%f.01,%f.01,%d,%d)}",0,syl.duration+100,fss,fss,posx,posy,posx,posy-50, tt-600,tt+600) .. shap
                                         	l.text = textfx .. l.text 
            	  	     	l.layer = 1
	  	       	subs.append(l)
	  	     	l.start_time=line.start_time+syl.start_time- ((j/loops)-1)*syl.duration 
	  	     	l.end_time=line.start_time+syl.start_time - ((j/loops)-1)*syl.duration + 850
	  	     	tt = l.end_time - l.start_time
                                                      fs1 = 50
                                                      fss = 20
                                                      tfr = ((400)-1)*sizft
	  	     	local textfx = string.format("{\\an5\\shad0\\fad(0,150)\\bord2.5\\blur2\\1c&H96D0FF&\\3c&H96D0FF&\\fscx%d\\fscy%d}",fs1,fs1)
	  	     	l.text= string.format("{\\t(\\fr"..tfr..")\\t(%d,%d,\\fscx%d\\fscy%d\\bord0.5\\blur5.5)\\move(%f.01,%f.01,%f.01,%f.01,%d,%d)}",0,syl.duration+100,fss,fss,posx,posy,posx,posy-50, tt-600,tt+600) .. shap
                                         	l.text = textfx .. l.text 
            	  	     	l.layer = 0
	  	     	subs.append(l)	
 	       
		     	local l=table.copy(line)
	                      	local csx = math.cos((crclx*j)*(math.pi/350))*radx
	                       	local sny = math.sin((crclx*j)*(math.pi*2/350))*rady
	                       	local posx, posy  = x+csx, y-sny 
	                       	local rand =  math.random(-45,45)

                    		local xx  = math.cos(math.rad(j*15))*math.random(-25,35)
                    		local yy  = math.sin(math.rad(j*15))*math.random(-25,35)

                                         	local alfa =string.format("alpha&H%02X&",20)  
            	  	     	local sizft = (j/loops)
	  	     	l.start_time=line.start_time+syl.start_time- ((j/loops)-1)*syl.duration 
	  	     	l.end_time=line.start_time+syl.start_time - ((j/loops)-1)*syl.duration + 750
	  	     	tt = l.end_time - l.start_time
                                                      fs1 = 50
                                                      fss = 20
                                                      tfr = ((400)-1)*sizft
	  	     	local textfx = string.format("{\\an5\\shad0\\fad(0,150)\\bord0\\blur1\\1c&H645EE3&\\fscx%d\\fscy%d}",fs1,fs1)
	  	     	l.text= string.format("{\\t(\\1c&HBCE0FE&)\\t(\\fr"..tfr..")\\t(%d,%d,\\fscx%d\\fscy%d\\blur7)\\move(%f.01,%f.01,%f.01,%f.01,%d,%d)}",0,syl.duration+100,fss,fss,posx,posy,posx,posy+50, tt-600,tt+600) .. shap
                                         	l.text = textfx .. l.text 
            	  	     	l.layer = 1
	  	       	subs.append(l)

	  	     	l.start_time=line.start_time+syl.start_time- ((j/loops)-1)*syl.duration 
	  	     	l.end_time=line.start_time+syl.start_time - ((j/loops)-1)*syl.duration + 850
	  	     	tt = l.end_time - l.start_time
                                                      fs1 = 50
                                                      fss = 20
                                                      tfr = ((400)-1)*sizft
	  	     	local textfx = string.format("{\\an5\\shad0\\fad(0,150)\\bord2.5\\blur2\\1c&H96D0FF&\\3c&H96D0FF&\\fscx%d\\fscy%d}",fs1,fs1)
	  	     	l.text= string.format("{\\t(\\fr"..tfr..")\\t(%d,%d,\\fscx%d\\fscy%d\\bord0.5\\blur5)\\move(%f.01,%f.01,%f.01,%f.01,%d,%d)}",0,syl.duration+100,fss,fss,posx,posy,posx,posy+50, tt-600,tt+600) .. shap
                                         	l.text = textfx .. l.text 
            	  	     	l.layer = 0
	  	     	subs.append(l)	
 
                      	end
 
end
                
function sil()
                silaba = ""..syl.text_stripped..""
                return silaba
                end
  
              

                posicion_anterior=0

                longsil=string.len(sil())

                modt=0

                modtend=0


                for char in unicode.chars(sil()) do

                tam_caracter = aegisub.text_extents(line.styleref,char)

                local x = line.left + syl.left +tam_caracter/2+posicion_anterior
                local y = line.middle


 
                iniEnf=line.start_time+syl.start_time+modt-20

                finEnf=line.start_time+syl.end_time-(syl.duration/3.8)+modt  
                duracion=finEnf-iniEnf
 
                if char == "" or char == " " then l.text = "{}" else
 
if line.actor =="2" then
 
                                           l.text = string.format("{\\move(%d,%d,%d,%d)\\fad(150,0)\\an5\\bord2\\shad0\\be2\\1c&HA4ADCA&\\t(1350,1550,\\1c&HDF9309&)}%s",x, y, x, y, char)
                                           l.start_time=line.start_time - 200
                                           l.end_time= iniEnf  
                                           l.layer = 2
                                           subs.append(l)


                                           if syl.inline_fx == "m" then
                                           c = "\\1c&HE6BF66&"
                                           else
                                           c = "\\1c&HA4ADCA&"
                                           end

                                    for start_t, end_t, i, n in frames(line.start_time + syl.start_time+modt-20, finEnf, 21.72 ) do
			l.start_time = start_t
			l.end_time = end_t 
			l.text = string.format("{\\an5"..c.."\\be2\\bord2\\shad0\\t(\\fscx140\\fscy140)\\pos(%.3f,%.3f)}",x+math.random(-3,3), y+math.random(-3,3) ) .. char
			l.layer=5
			subs.append(l)
		end       

elseif line.actor =="3" then
 
                                           l.text = string.format("{\\move(%d,%d,%d,%d)\\fad(150,0)\\an5\\bord2\\shad0\\be2\\1c&HDF9309&\\t(3250,3350,\\1c&HA4ADCA&)}%s",x, y, x, y, char)
                                           l.start_time=line.start_time - 200
                                           l.end_time= iniEnf  
                                           l.layer = 2
                                           subs.append(l)


                                           if syl.inline_fx == "m" then
                                           c = "\\1c&HA4ADCA&"
                                           else
                                           c = "\\1c&HE6BF66&" 
                                           end

                                    for start_t, end_t, i, n in frames(line.start_time + syl.start_time+modt-20, finEnf, 21.72 ) do
			l.start_time = start_t
			l.end_time = end_t 
			l.text = string.format("{\\an5\\fad(0,%d)"..c.."\\be2\\bord2\\shad0\\t(\\fscx140\\fscy140)\\pos(%.3f,%.3f)}", 100/n,x+math.random(-3,3), y+math.random(-3,3) ) .. char
			l.layer=5
			subs.append(l)
		end

elseif line.actor =="4" then

 
                                    c = "\\1c&H708CD1&"
 

                                           l.text = string.format("{\\move(%d,%d,%d,%d)\\fad(150,0)\\shad0\\4c&H053CBA&\\an5\\bord2\\be2"..c.."}%s",x, y, x, y, char)
                                           l.start_time=line.start_time - 200
                                           l.end_time= iniEnf  
                                           l.layer = 2
                                           subs.append(l)
 

                                    for start_t, end_t, i, n in frames(line.start_time + syl.start_time+modt-20, finEnf, 21.72 ) do
			l.start_time = start_t
			l.end_time = end_t 
			l.text = string.format("{\\an5\\fad(0,%d)"..c.."\\4c&H053CBA&\\be2\\bord2\\shad0\\t(\\fscx140\\fscy140)\\pos(%.3f,%.3f)}", 100/n,x+math.random(-3,3), y+math.random(-3,3) ) .. char
			l.layer=5
			subs.append(l)
		end       

        
     
end



                                 if syl.duration <= 75 then
                
                	modt=modt+100/(longsil*2)
                
                elseif syl.duration <= 100 then
                
                	modt=modt+250/(longsil*2)
                
                elseif syl.duration <= 250 then
                
                	modt=modt+500/(longsil*2)
                
                elseif syl.duration <= 1100 then
                
                	modt=modt+700/(longsil*2)
                
                elseif syl.duration < 2000  then
                
                	modt=modt+800/(longsil*2)
                
                elseif syl.duration >= 3000 then
                
                	modt=modt+1100/(longsil*2)
                
                else
                
                	modt=modt+1200/(longsil*2)
                
                end

                
                 modt=modt+syl.duration/10

                
                 posicion_anterior=posicion_anterior+tam_caracter

                end
 
               end
 



          end
end
aegisub.register_macro(script_name, "Detective Conan ED 49 - FX", fx_conan)