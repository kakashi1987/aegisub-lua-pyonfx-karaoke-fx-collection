﻿بسم الله الرحمن الرحيم
السلااام عليكم
^_^
هذا أول درس لوا أقوم بشرحه لكم
الرجاء أحتاج لبعض التركيز كي تفهمون

لنبدأ

هذا أول ما قد تكتبه... لا داعي لكتابه ولكن حفظاً للحقوق
أسمك الشخصي أو نكك
^_^
--Author : Abdullah Al-Farsi(G_NAZ)
--Released int the public domain

أما هنا بعض معلومات تظهر أثناء تطبيقك في الاوتوميشن في برنامج ايجي سب

name = "Lesson 1" أسم الملف أو أي أسم تريد... عليك كتابته بين علامتين التنصيص

description = "www.jnazh-karaoke.ahlamontada.net" الوصف... تضع وصفاً عن ما يفعله السكربت.. أو رابط موقعك للدعاية

==============م====================أما عن هذه الجمل... أنصحك أن تكتبها في كل سكربتٍ لك... ولا داعي أن تعرف ما هي


version, kind, configuration = 3, 'basic_ass', {} 


include("karaskel-adv.lua") 

function do_syllable(meta, styles, config, line, syl) 


	local result = {n=0} 


            function result.add() local l = copy_line(line); table.insert(result, l); return l end


	local x = line.centerleft + syl.center                   
	local y = 45                                                         
	local start_t = syl.start_time                                    
	local mid_t =  syl.start_time + syl.duration*5   
	local end_t = syl.end_time 		       
==============================================


        local l = result.add()أكتبها دائماً فوق الطبقة

	l.layer = 0 هذه الطبقة... ويفضل أن تكون مرقمة من الصفر إلى ما لا نهاية

لم أكتب أنا هنا وقت بداية نطق المغني... لأني أريد أن تظهر الجملة عند بدايتها... لا داعي بأن تقوم بذلك.. أنت وتفكيرك

        l.end_time = line.start_time + syl.start_time/10  ^^وقت نهاية نطق المغني... كلما قللنا رقم 10 يتأخر أختفاء الحروف...كم أحب ذلك

                                هنا يمكنك أن تكتب الأكواد التي تريدها بين القوسين ولكن عليك أن تظع شرطتان \\ وليست واحدة.. مفهووووووم؟
	l.text = string.format("{\\an5\\pos(%d,%d)\\1c&HD3EBA1&\\3c&HFCFDFC&}%s",x,y,syl.text_stripped)

=================================وها قد انتهينا من الطبقة الأولى==========================

	local l = result.add()كما قلت سابقاً... أكتبها دائماً فوق أي طبقة

	l.layer = 1     وها نحن نبدأ بالطبقة التالية ونرقمها بالرقم 1... يمكننا صنع آلاف الطبقات.. ولكن هل أنت متفيق لكتابة آلاف الطبقات؟! لا أعتقد ذلك

                  l.start_time = line.start_time + syl.start_time/10   وقت بداية نطق المغني... وكلما قللنا قيمة عشرة أو زدناها تتغير توقيت ظهور الحروف... لو قللناه سيتأخر ولو زدنا سيسرع في ظهوره حتى قبل غناء المغني... آخخ>< تخدر ذراعي

	l.end_time = line.start_time + syl.start_time/10 وهذا وقت نهاية نطق المغني... شرحتها قبلاً >_> أرجع قليلاً وستعرف

                                                                       هنا تكتب أكوادك الخاصة... وأنا كتبت أكوادي ^^ أليس رائعاً؟
	l.text = string.format("{\\an5\\pos(%d,%d)\\1c&HD3EBA1&\\t(\\fs80)\\3c&HFCFDFC&}%s",x,y,syl.text_stripped)

=================================انتهينا أخيراً من الطبقة الثانية==========================

	return resultبعد أن تنتهي من كتابة سكربتك... اكتب هذا

end النهاية... يجب أن تكتبها تتمكن من أغلاق السكربت


أنتهيت من شرح هذا الجزء من خطط العبقرية في شرح سكربتات لوا
^^وأعتقد أن الجمييع قد فهموا الدرس<<<في أحلامك... أي أسئلة؟؟ أرفعوا أيدكم

^(^إذا أردت المزيد من الدروس سجل في مدرستي
http://www.jnazh-karaoke.ahlamontada.net/index.htm

لا تتردد في أية أستفسار
مع تحياتي:- جنـــــــــــــازة
21\7\2008