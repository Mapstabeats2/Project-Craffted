local allowStart=false
function onStartCountdown()
	if allowStart==false then
		setProperty('healthBar.visible', false)
		setProperty('healthBarBG.visible', false)
		setProperty('iconP1.visible', false)
		setProperty('iconP2.visible', false)
		return Function_Stop;
	end
	return Function_Continue;
end
local function exitMenu(isEnded) --thanks to Applehair for the fix!!!! (https://gamebanana.com/members/1773453)
	setProperty('boyfriendIdled', true);
	setProperty('keysPressed', {true,true,true});
	setProperty('ratingPercent', 0.41);
	if isEnded == true then
		exitSong()
	else
		endSong()
	end
end
local function keyPressed(key, isheld)
	if isheld == nil then isheld = false end
	if isheld == false then
		return getPropertyFromClass('flixel.FlxG', 'keys.justPressed.'..key)
	elseif isheld == true then
		return getPropertyFromClass('flixel.FlxG', 'keys.pressed.'..key)
	end
end
local curTab2 = 0
local curS2 = 0
local function switchTab(Tab, sel)
	curTab = 'none'
	curS = 0
	curTab2 = Tab
	curS2 = sel
	runTimer('switchToTab', 1, 1)
end

local obj2move = {}
local function moveCamHud(x, y)
	local vx = screenWidth
	local vy = screenHeight
	local chx = getProperty('camFollow.x')
	local chy = getProperty('camFollow.y')
	if chx == screenWidth or chx == -screenWidth then
		vx = 0
	end
	if chy == screenHeight or chy == -screenHeight then
		vy = 0
	end
	setProperty('pointer.visible', false)
	for i = 1, #(obj2move) do
		doTweenX('move obj x '..i, obj2move[i].tag, obj2move[i].x-vx*x, 1, 'sineinout')
		doTweenY('move obj y '..i, obj2move[i].tag, obj2move[i].y-vy*y, 1, 'sineinout')
	end
	doTweenX('MoveCamHud_X', 'camFollow', vx*x, 1, 'sineinout')
	doTweenY('MoveCamHud_Y', 'camFollow', vy*y, 1, 'sineinout')
end
local function fadeScreen(time)
	makeLuaSprite('BLACK', 'UI/menuBG', 0, 0)
	setObjectCamera('BLACK', 'other')
	addLuaSprite('BLACK', true)
	setProperty('BLACK.color', '000000')
	setProperty('BLACK.alpha', 0)
	runTimer('EndMENU', time)
	doTweenAlpha('FADEOUTT', 'BLACK', 1, time, 'linear')
end

local function makeGooseText(tag, txt, w, x, y, size, clr, clr2)
	if clr == nil then clr = 'ffffff' end
	if clr2 == nil then clr2 = '3b6cd5' end
	makeLuaText(tag, txt, w, x, y);
	setTextSize(tag, size);
	setTextFont(tag, 'Transport New Medium.otf');
	setTextColor(tag, clr)
	setTextBorder(tag, 0, clr2);
	setObjectCamera(tag, 'camHud')
	addLuaText(tag);
	if tag ~= 'pointer' then
		table.insert(obj2move, {tag = tag, x = x, y = y})
	end
end
local function makeGooseSprite(tag, file, x, y)
	makeLuaSprite(tag, file, x, y)
	setObjectCamera(tag, 'camHud')
	addLuaSprite(tag, true)
	table.insert(obj2move, {tag = tag, x = x, y = y})
end

local allowInput = true
local curS = 1
local curTab = 1
local menu = {}
local maint = {}
local sounds = {
	volume = 10,
	select = 'UI/ui_menu_main_select', 
	move = 'UI/ui_menu_main_toggle',
	switch = 'UI/ui_menu_main_switch',
	cancel = 'UI/ui_menu_main_select',
	}
local week1 = {'main-menu', 'Untitled Song', 'Trouble Maker', 'Town Menace', 'Ending', 'main-menu'}
local week2 = {'main-menu', 'Causing Trouble', 'TV Broadcast', 'Broom Breaker', 'main-menu'}
local freesongs = {
	'Untitled Song', 'Trouble Maker', 'Town Menace', 
	'Causing Trouble', 'TV Broadcast', 'Broom Breaker', 
	'Desktop', 'Problem Duo',
	'Untitled Remix', 'Trouble Seeker', 'Town Nuisance'
	}
local credits = {
	'Larnny: Director, Artist, Coder, Composer',
	'Haektn: Composed most of the V2 songs, Coding and chart for Problem Duo',
	'Hydro: Helped animating the new "Untitled Song" cutscene',
	'DodZonedOut: Composed "Trouble Maker"',
	'Begwhi02: Composed "Untitled Song"',
	'Corthon: Drew running BF sprites',
	'~ Special thanks to House House for creating Untitled Goose Game ~'
	}
function onCreate()
	maint = {
		x = (screenWidth/2)-92,
		y = (screenHeight/2)+48,
		gy = 35+20,
		w = 0,
		s = 35,
		al = 'left',
		clr = 'ffffff',
		clr2 = '3b6cd5'
	}
	menu = {
		[1] = { -- main menu
			{tag = 'Begin', x = maint.x, y = maint.y+maint.gy*0, w = maint.w, s = maint.s, 
				al = maint.al, clr = maint.clr, clr2 = maint.clr2,
				func = function()
					allowInput = false
					playSound(sounds.switch, sounds.volume)
					moveCamHud(1, 0)
					switchTab(2, 2)
					end
				},
			{tag = 'Freeplay', x = maint.x, y = maint.y+maint.gy*1, w = maint.w, s = maint.s, 
				al = maint.al, clr = maint.clr, clr2 = maint.clr2,
				func = function()
					allowInput = false
					playSound(sounds.switch, sounds.volume)
					moveCamHud(-1, 0)
					switchTab(3, 2)
					end
				},
			{tag = 'Credits', x = maint.x, y = maint.y+maint.gy*2, w = maint.w, s = maint.s, 
				al = maint.al, clr = maint.clr, clr2 = maint.clr2,
				func = function()
					allowInput = false
					playSound(sounds.switch, sounds.volume)
					moveCamHud(0, 1)
					switchTab(4, 1)
					end
				},
			{tag = 'Quit', x = maint.x, y = maint.y+maint.gy*3, w = maint.w, s = maint.s, 
				al = maint.al, clr = maint.clr, clr2 = maint.clr2,
				func = function()
					allowInput = false
					playSound(sounds.cancel, sounds.volume)
					exitMenu(true)
					end
				}
			},
		[2] = { -- week select
			{tag = 'back <', x = 40, y = 20, w = 0, s = 35, 
				al = 'left', clr = maint.clr, clr2 = maint.clr2,
				func = function()
					allowInput = false
					playSound(sounds.switch, sounds.volume)
					moveCamHud(-1, 0)
					switchTab(1, 1)
					end
				},
			{tag = 'Week 1', x = 340, y = 515, w = 210, s = 35, 
				al = 'left', clr = maint.clr, clr2 = maint.clr2,
				func = function()
					playSound(sounds.select, sounds.volume)
					setPropertyFromClass('PlayState', 'storyPlaylist', week1)
					fadeScreen(2)
					end
				},
			{tag = 'Week 2', x = 740, y = 515, w = 210, s = 35, 
				al = 'left', clr = maint.clr, clr2 = maint.clr2,
				func = function()
					playSound(sounds.select, sounds.volume)
					setPropertyFromClass('PlayState', 'storyPlaylist', week2)
					fadeScreen(2)
					end
				}
			},

		[3] = { -- freeplay
			{tag = 'back >', x = screenWidth-150, y = 20, w = 0, s = 35, 
				al = 'left', clr = maint.clr, clr2 = maint.clr2,
				func = function()
					allowInput = false
					playSound(sounds.switch, sounds.volume)
					moveCamHud(1, 0)
					switchTab(1, 2)
					end
				}
			},
		[4] = { -- credits
			{tag = 'back ^', x = 40, y = 20, w = 0, s = 35, 
				al = 'left', clr = maint.clr, clr2 = maint.clr2,
				func = function()
					allowInput = false
					playSound(sounds.switch, sounds.volume)
					moveCamHud(0, -1)
					switchTab(1, 3)
					end
				},
			{tag = 'Discord', x = screenWidth-175, y = 20, w = 0, s = 35, 
				al = 'left', clr = maint.clr, clr2 = maint.clr2,
				func = function()
						if (buildTarget == "linux") then
					    	os.execute("/usr/bin/xdg-open https://discord.gg/EyqnRXaaEp")
					  	else
					    	os.execute("start https://discord.gg/EyqnRXaaEp")
					    end
					end
				}
			}
		}
	local freegap = 20+25
	for i = 1, #(freesongs) do
		table.insert(menu[3], 
			{tag = freesongs[i], x = math.floor((screenWidth/2)-260/2), y = 200+freegap*(i-1), w = 260, s = 25, 
				al = 'left', clr = '2c2c2c', clr2 = 'f9f7f0',
				func = function()
					playSound(sounds.select, sounds.volume)
					setPropertyFromClass('PlayState', 'isStoryMode', false)
					loadSong(freesongs[i], 'hard')
					end
				}
			)
	end
	
	--debugPrint(getPropertyFromClass('Highscore', 'getScore()'))
	playMusic('MenuMusic', 1, true)

	makeLuaSprite('background', 'UI/menuBG', -200, -200)
	setObjectCamera('background', 'camGame')
	setScrollFactor('background', 0, 0)
	scaleObject('background', 2, 2)
	addLuaSprite('background', true)

	local chance = getRandomInt(0, 50)
	local Logofile = 'UI/logo'
	if chance == 5 then Logofile = 'UI/logo alt' end
	makeGooseSprite('logo', Logofile, 320, 140, menuObjs)

	makeGooseSprite('freeplaylist', 'UI/optionsList', ((screenWidth/2)-(900/2))-screenWidth, 70)

	makeGooseText('credits header', '~~ Credits ~~', screenWidth, 0, (50)+screenHeight, maint.s*2, nil, nil)

	for i = 1, #(credits) do
		makeGooseText('credits '..credits[i], credits[i], screenWidth, 0, (200+65*(i-1))+screenHeight, maint.s/1.25, nil, nil)
	end

	makeGooseText('freeplay header', '~~~ Freeplay ~~~', screenWidth, 0-screenWidth, 110, maint.s, '2c2c2c', 'f9f7f0')
	setTextFont('freeplay header', 'Transport New Light.otf')
	
	makeGooseText('pointer', '•', 0, -200, -200, maint.s, nil, nil)

	for i = 1, #(menu) do
		local a = 0
		local b = 0
		if i == 2 then a = screenWidth end
		if i == 3 then a = -screenWidth end
		if i == 4 then b = screenHeight end
		for k = 1, #(menu[i]) do
			--debugPrint(i, " ", a,' ', b)
			makeGooseText(i..' '..menu[i][k].tag, menu[i][k].tag, menu[i][k].w, menu[i][k].x+a, menu[i][k].y+b, menu[i][k].s, menu[i][k].clr, menu[i][k].clr2)
			if i == 3 and k > 1 then
				setTextFont(i..' '..menu[i][k].tag, 'Transport New Light.otf')
			end
		end
	end
	makeGooseSprite('notebook1', 'UI/notebook1', getProperty('2 Week 1.x'), getProperty('2 Week 1.y')-300-20)
	makeGooseSprite('notebook2', 'UI/notebook2', getProperty('2 Week 2.x'), getProperty('2 Week 2.y')-300-20)
	setProperty('2 Week 1.alpha', 0)
	setProperty('2 Week 2.alpha', 0)

	updatePointer()
end
function onUpdate()
	local b1 = 'up'
	local b2 = 'down'
	if keyPressed('SPACE', false) then
		restartSong()
	end
	
	if curTab == 2 then
		b1 = 'left'
		b2 = 'right'
		local function itemAscend(sel, item, y, text)
				if curS == sel and curTab == 2 then 
					cancelTween('CoolTween2'..item)
					doTweenY('CoolTween1'..item, item, y-30, 0.1, 'linear')
					cancelTween('CoolTween2'..text)
					doTweenAlpha('CoolTween1'..text, text, 1, 0.05, 'linear')
				elseif curS ~= sel and getProperty(item..'.y') ~= y then
					cancelTween('CoolTween1'..item)
					doTweenY('CoolTween2'..item, item, y, 0.1, 'linear')
					cancelTween('CoolTween1'..text)
					doTweenAlpha('CoolTween2'..text, text, 0, 0.05, 'linear')
				end
			end
			itemAscend(2, 'notebook1', getProperty('2 Week 1.y')-300-20, '2 Week 1')
			itemAscend(3, 'notebook2', getProperty('2 Week 2.y')-300-20, '2 Week 2')
	elseif curTab == 4 then
		b1 = 'left'
		b2 = 'right'
	else
		b1 = 'up'
		b2 = 'down'
	end

	if allowInput == true then
		local function optifine()
			updatePointer()

			playSound(sounds.move, sounds.volume)
		end
		if keyJustPressed(b1) then 
			if curS>1 then curS=curS-1 else curS=#(menu[curTab]) end 
			optifine()
			end
		if keyJustPressed(b2) then 
			if curS < #(menu[curTab]) then curS=curS+1 else curS=1 end
			optifine()
			end

		if keyPressed('ENTER', false) then
			menu[curTab][curS].func()
		end
	end
end
function onTimerCompleted(tag)
	if tag == 'switchToTab' then
		allowInput = true
		curTab = curTab2
		curS = curS2
		setProperty('pointer.visible', true)
		updatePointer()
		--debugPrint('switched')
	end
	if tag=='EndMENU' then exitMenu(false) end
end
function updatePointer()
	setTextColor('pointer', '0xff'..getProperty(curTab..' '..menu[curTab][curS].tag..'.color'))
	setTextSize('pointer', getProperty(curTab..' '..menu[curTab][curS].tag..'.size'))
	setTextBorder('pointer', 0, '0xff'..getProperty(curTab..' '..menu[curTab][curS].tag..'.borderColor'))
	setProperty('pointer.x', getProperty(curTab..' '..menu[curTab][curS].tag..'.x')-20)
	setProperty('pointer.y', getProperty(curTab..' '..menu[curTab][curS].tag..'.y'))
end