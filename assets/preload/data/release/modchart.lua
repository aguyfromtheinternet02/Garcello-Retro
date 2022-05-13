local followXOffset = 700

function start (song)
    hudX = getHudX()
    hudY = getHudY()
	
	WhiteBG = makeSprite('WhiteBG','whitebg', true)
	BlackBG = makeSprite('BlackFade','blackbg', true)
	WhiteFade = makeSprite('WhiteBG','whitefade', false)
	BlackFade = makeSprite('BlackFade','blackfade', false)
	Fading = makeSprite('Fading','fading', true)
	
	setActorX(200,'whitebg')
	setActorY(500,'whitebg')
	setActorAlpha(0,'whitebg')
	setActorScale(4,'whitebg')
	
	setActorX(200,'blackbg')
	setActorY(500,'blackbg')
	setActorAlpha(1,'blackbg')
	setActorScale(4,'blackbg')

	setActorX(30,'fading')
	setActorY(427,'fading')
	setActorAlpha(0,'fading')
	setActorScale(2,'fading')
	
	setActorX(200,'blackfade')
	setActorY(500,'blackfade')
	setActorAlpha(0,'blackfade')
	setActorScale(4,'blackfade')
	
	setActorX(200,'whitefade')
	setActorY(500,'whitefade')
	setActorAlpha(0,'whitefade')
	setActorScale(4,'whitefade')
	
	setActorAlpha(0,'boyfriend')
	setActorAlpha(0,'dad')
	setActorY(-600,'dad')
	setActorAlpha(0,'girlfriend')

	hide = true
	
	setHudPosition(0, 1000)
end

function update (elapsed)
	local currentBeat = (songPos / 1000)*(bpm/60)
	hudX = getHudX()
    hudY = getHudY()
	
	if zoom then
		setCamZoom(2)
	end
	
	if hide then
		for i=0,7 do
			setActorAlpha(0,i)
		end
	end
	
	if swayingsmall then
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat)), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 10 * math.cos((currentBeat)) + 10, i)
		end
	end
	if swayingmedium then
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*1)), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 10 * math.cos((currentBeat + i*1)) + 10, i)
		end
	end
	if swayinglarge then
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*1)), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*1)) + 10, i)
		end
	end
end

function beatHit (beat)
	if camerabeat then
		setCamZoom(1)
	end
end

function stepHit (step)
	if step == 16 then
		tweenFadeIn('girlfriend',1,0.6)
		setHudPosition(0, 0)
		hide = false
	end
	if step == 48 then
		tweenFadeIn('boyfriend',1,0.6)
		for i=4,7 do
			tweenFadeIn(i,1, 0.6)
		end
	end
	if step == 80 then
		tweenFadeIn('dad',1,1.5)
		tweenPosYAngle('dad', 0, 0, 2, 'dad')
		for i=0,3 do
			tweenFadeIn(i,1, 0.6)
		end
	end
	if step == 112 then
		tweenFadeOut(BlackBG,0,0.6)
	end
--	if step == 150 then
--		tweenFadeIn(Fading,1,0.6)
--	end
	if step == 262 then
		tweenFadeIn(BlackBG,1,0.01)
		tweenFadeIn(WhiteFade,1,0.01)
		zoom = true
		showOnlyStrums = true
		for i=0,7 do
			tweenFadeOut(i,0,0.2)
		end
	end
	if step == 263 then
		tweenFadeOut(WhiteFade,0,0.2)
	end
	if step == 272 then
		zoom = false
		camerabeat = true
		tweenFadeOut(BlackBG,0,0.01)
		tweenFadeIn(WhiteFade,1,0.01)
		swayingsmall = true
		setHudPosition(0,0)
		for i=0,7 do
			tweenFadeIn(i,1, 0.01)
		end
	end
	if step == 273 then
		tweenFadeOut(WhiteFade,0,0.6)
	end
	if step == 902 then
		tweenFadeIn(BlackBG,1,0.2)
		camerabeat = false
		for i=0,7 do
			tweenFadeOut(i,0, 0.2)
		end
	end
	if step == 912 then
		tweenFadeOut(BlackBG,0,0.01)
		tweenFadeIn(WhiteFade,1,0.01)
		camerabeat = true
		swayingsmall = false
		swayingmedium = true
		for i=0,7 do
			tweenFadeIn(i,1, 0.01)
		end
	end
	if step == 913 then
		tweenFadeOut(WhiteFade,0,0.2)
	end
end