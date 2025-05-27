
function onCreate()
    
    

    --CUSTOM BOPPING

    --setOnScripts('natural_bump_toggle', false)
    --characterBopper(6)
    setOnScripts('pos_speed', 5)
    setOnScripts('offset_radius', 5)

    setProperty('boyfriend.danceEveryNumBeats', 3)

    --STOPPPPPPPP DANCING
    --setProperty('dad.danceEveryNumBeats', 3)
    --setProperty('dad.danceEveryNumBeats', 999999999999999999999999999999999999999)

    makeLuaSprite('camColorBox')
	makeGraphic('camColorBox', screenWidth, screenHeight, '000000')
	addLuaSprite('camColorBox', true)
	setObjectCamera('camColorBox', 'hud')
	setObjectOrder('camColorBox', 0)

	setProperty('camColorBox.alpha', 1)

    setProperty('dad.x', getProperty('dad.x') - 150)
end


function onCreatePost()
    if seenCutscene then
        makeLuaText('skipTxt', 'Press SPACE to skip', 1280, 0, 550)
        if buildTarget ~= 'windows' and buildTarget ~= 'mac' and buildTarget ~= 'linux' then
            setTextString('skipTxt', 'Tap me to skip')
        end
        setTextFont('skipTxt', 'Minecraftia.ttf')
        setTextColor('skipTxt', '0xffffff')
        setTextSize('skipTxt', 24)
        setTextBorder('skipTxt', 0, '0xffffff')
        addLuaText('skipTxt')
        setTextAlignment('skipTxt', 'center')
        setObjectCamera('skipTxt', 'hud')
    end
    
end

function onSongStart()
	-- Inst and Vocals start playing, songPosition = 0
    doTweenAlpha('camColorBoxTwn', 'camColorBox', 0, 6, 'linear')

    nc_set_target('opp', 580, -360)
    nc_snap_target('opp')
    nc_snap_zoom('g', 1.8)
    
	nc_set_target('plr', 900, 400)
    nc_focus('plr', 6, 'quadInOut', true)
    nc_zoom('game', 1, 6, 'quadInOut')

    
end


--Thx LarryFrosty from Psych Ward
function onBeatHit()
    if not stringStartsWith(getProperty('gf.animation.name'), 'sad') then
        if curBeat % 2 == 0 then
            playAnim('gf', 'danceLeft', true)
        else
            playAnim('gf', 'danceRight', true)
        end
    end
    
end

--[[funny bop
function onBeatHit()
    if curBeat % 2 == 0 and not stringStartsWith(getProperty('gf.animation.name'), 'sing') and not getProperty('gf.stunned') then
        callMethod('gf.dance', {})
    end
end
]]
function onStepHit()
    --[[
    if not (stringStartsWith(getProperty('dad.anim.curSymbol.name'), 'left') 
        or stringStartsWith(getProperty('dad.anim.curSymbol.name'), 'down')
        or stringStartsWith(getProperty('dad.anim.curSymbol.name'), 'up')
        or stringStartsWith(getProperty('dad.anim.curSymbol.name'), 'right') ) and not getProperty('dad.stunned') then
        if curStep % 12 == 0 then
            playAnim('dad', 'danceLeft', true)
        elseif curStep % 12 == 6 then
            playAnim('dad', 'danceRight', true)
        end
    end
    ]]

    --ACTUAL EVENTS
    if curStep == 232 then
        nc_lock(false, false)
        triggerEvent('nc_reload_targets', '', '')
        doTweenX('zombieAppears', 'dad', 150, 0.01, 'cubicOut')
    end
    if curStep == 240 then
        triggerEvent('nc_reload_targets', '', '')
        nc_zoom('game', 0.8, 2, 'circOut')
    end
	if curStep == 960 then 
		cameraFade('game', '000000', 19, true)
	end
    if curStep == 1140 then 
		cameraFade('hud', '000000', 1.3, true)
	end
end

--max zoom 0.6







skipped = false

local function skip()

    skipped = true


    setProperty('skipTxt.alpha', 0)

    callMethod('setSongTime', {19000})
    cancelTween('camColorBoxTwn')
    setProperty('camColorBox.alpha', 0)

    nc_lock(false, false)
    nc_snap_target('plr')
    nc_snap_zoom('g', 1)
        --[[
        setPropertyFromClass('Conductor', 'songPosition', 19000) 
        setPropertyFromClass('flixel.FlxG', 'sound.music.time', getPropertyFromClass('Conductor', 'songPosition'))
        setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition'))
        ]]
end

local mouseX = 0
local mouseY = 0

function onUpdatePost(elapsed)
	-- End of "update"
	-- Also gets called while in the game over screen

    --thx flain from Psych Ward
    local mouseX = getMouseX('hud')
    local mouseY = getMouseY('hud')
    
    
    if keyboardJustPressed('SPACE') and not getProperty('startingSong') and not skipped then
        skip()
    elseif mouseX >= 640 - 250 and mouseX <= 640 + 250 and mouseY >= 550 - 30 and mouseY <= 550 + 30 + 30 and mousePressed('left') and not getProperty('startingSong') and not skipped then
        skip()
    elseif not skipped and getSongPosition() >= 19000 then
        skipped = true
        setProperty('skipTxt.alpha', 0)
    end
    
    
    

end