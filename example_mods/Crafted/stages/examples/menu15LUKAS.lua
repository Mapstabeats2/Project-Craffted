
--[[
    hey it's me arm4gedon this was pain to make
    chavales chavales le han cambiado la imagen a las arqueras ahora estan mas buenas me acabo de enamorar tu que opinas pero cuidadito que me pongo celoso
]]

local songs = {
    {
        'armageddon',
        'ff4583',
        'arm4gedon',
        110,
        {
            offset = {x = -200, y = -250},
            scale = {x = 0.38, y = 0.38},
            fps = 12
        },
        'Arm4GeDon',
        'Song by XRex ft. Pohsan & Arm4GeDon & AzCortinitas | Chart by 4cent | Art by 4KrazyMoon & Aldox | Code by Arm4GeDon & elfb34'
    },
    {
        'diesisiete',
        '8400ff',
        'juank',
        155,
        {
            offset = {x = -50, y = -170},
            scale = {x = 0.225, y = 0.225},
            fps = 12
        },
        'Joe',
        'Song by Pohsan | Chart by Arm4GeDon & Fattz | Art by 4KrazyMoon | Code by Arm4GeDon & elfb34 | JuanB7 left but hes still here'
    },
    {
        'cortibound',
        'ff7433',
        'azcurtai',
        148,
        {
            offset = {x = -100, y = -155},
            scale = {x = 0.8, y = 0.8},
            fps = 24
        },
        'AzCortinitas',
        'Song by Arm4GeDon | Chart by AzCortinitas & Fattz | Art by AzCortinitas | Code by Arm4GeDon & elfb34'
    },
    {
        'insanity',
        'e63825',
        'kevin',
        128,
        {
            offset = {x = -150, y = -221},
            scale = {x = 0.325, y = 0.325},
            fps = 12
        },
        '4KrazyMoon',
        'Song by Pohsan | Chart by Arm4GeDon & Fattz | Art by 4KrazyMoon | Code by Arm4GeDon & elfb34'
    },
    {
        'brigido',
        '5e34eb',
        'pohsan',
        190/2,
        {
            offset = {x = -175, y = -250},
            scale = {x = 0.35, y = 0.35},
            fps = 12
        },
        'Pohsan',
        'Song by Pohsan & Frank | Chart by RaspyFv & Fattz | Art by 4KrazyMoon | Code by Arm4GeDon & elfb34'
    },
    {
        'rsjpjoqa',
        'ffffff',
        'fb',
        195/2,
        {
            offset = {x = 0, y = -100},
            scale = {x = 0.55, y = 0.55},
            fps = 24
        },
        'elfb34',
        'Song by Arm4GeDon ft. Pohsan | Chart by Arm4GeDon & Fattz | Art by AzCortinitas | Code by Arm4GeDon & elfb34'
    },
    {
        'bodriotastico',
        'ff1f71',
        'mrlorenddbucky',
        176,
        {
            offset = {x = 0, y = -135},
            scale = {x = 0.5, y = 0.5},
            fps = 24
        },
        'mrlorendd',
        'Song by XRex | Chart by Arm4GeDon & Fattz | Art by mrlorendd, Bingle, JoaDash & ElPando | Code by Arm4GeDon & elfb34'
    },
    {
        'p1nkd4mncute',
        'ff47da',
        'maruu',
        157,
        {
            offset = {x = -150, y = -200},
            scale = {x = 0.325, y = 0.325},
            fps = 12
        },
        'XRex',
        'Song by XRex | Chart by Arm4GeDon & Fattz | Art by 4KrazyMoon | Code by Arm4GeDon & elfb34'
    },
    {
        'n-4-p',
        '121212',
        'jeff',
        115,
        {
            offset = {x = -200, y = -150},
            scale = {x = 1.1, y = 1.1},
            fps = 12
        },
        'Jeff the killer',
        'Song by Arm4GeDon ft. Pohsan | Chart by AzCortinitas | Art by 4KrazyMoon & JuanB7 | Code by Arm4GeDon & elfb34'
    },
    {
        'mamafukkers',
        '121212',
        'horror',
        123,
        {
            offset = {x = -100, y = -175},
            scale = {x = 0.45, y = 0.45},
            fps = 24
        },
        'Sans & Sans',
        'Song by Pohsan | Chart by Arm4GeDon & 4cent | Art by mseee | Code by Arm4GeDon & elfb34'
    },
    {
        'iphone',
        '345eeb',
        'avgn',
        180/2,
        {
            offset = {x = 0, y = -100},
            scale = {x = 1, y = 1},
            fps = 24
        },
        'Aldox',
        'Song by Pohsan ft. XRex | Chart by Arm4GeDon | Art by Aldox | Code by Arm4GeDon & elfb34'
    },
    --[[
    {
        'yonerhead',
        '121212',
        'dipsyk',
        195/2,
        {
            offset = {x = -150, y = -190},
            scale = {x = 0.32, y = 0.32},
            fps = 12
        },
        'mseee or dipsy all my fellas go watch guy of bald',
        'Song by Pohsan | Chart by nadie | Art by mseee | Code by Arm4GeDon & elfb34'
    }
        ]]
}
local unlockable = {
    {
        '15lucas',
        '121212',
        'ness',
        130,
        {
            offset = {x = -80, y = -75},
            scale = {x = 0.7, y = 0.7},
            fps = 12
        },
        'nes',
        'Song by Pohsan | Chart by Cory & Arm4GeDon | Art by AzCortinitas | Code by Arm4GeDon & elfb34'
    }
}
local basados = {'4KrazyMoon', 'Pohsan', 'Arm4GeDon'}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
local bgm = 'loopmenu'
function lerp(a,b,t) return a * (1-t) + b * t end
local menu = {
    makeSprite = function(tag, image, x, y)
        makeLuaSprite(tag, image, x, y)
        setObjectCamera(tag, 'other')
    end,
    makeAnimatedSprite = function(tag, image, x, y)
        makeAnimatedLuaSprite(tag, image, x, y)
        setObjectCamera(tag, 'other')
    end,
    makeText = function(tag, text, width, x, y)
        makeLuaText(tag, text, width, x, y)
        setObjectCamera(tag, 'other')
    end
}
function flash(duration, color, alpha, blend)
    local tag = '_flash'
    makeLuaSprite(tag)
    makeGraphic(tag, screenWidth, screenHeight, color or 'ffffff')
    setProperty(tag..'.alpha', alpha or 1)
    addLuaSprite(tag)
    doTweenAlpha(tag..'out', tag, 0, duration or 1)
    setBlendMode(tag, blend or 'alpha')
    setObjectCamera(tag, 'other')
    setObjectOrder(tag, getObjectOrder('border')-1)
end
function beat(strength)
    setProperty('camOther.zoom', strength)
    doTweenZoom('camOtherZoom', 'camOther', 1, 0.5, 'quadOut')
end
local defaultX = (1280/2)-400/2
local globalPos = {x = defaultX, y = 150}
local curSelected = 1
local power = 500
local allow = true
local allowMove = true
local onNotice = false
local songBpm = 0
local _score, _rating = 0, 0
local dscore, drating = 0, 0

function onCreate()
    setProperty('camGame.alpha', 0)
    setProperty('camHUD.alpha', 0)
    playMusic(bgm, 1, true)
    local loaded = {}
    for i,v in pairs(songs) do
        local char = v[3]
        precacheMusic('preview/'..v[1])
        --[[
        if not loaded[char] then
            table.insert(loaded,char)
            precacheImage('characters/'..char)
        end
        ]]
    end
    for i,v in pairs(unlockable) do
        local char = v[3]
        precacheMusic('preview/'..v[1])
        --[[
        if not loaded[char] then
            table.insert(loaded,char)
            precacheImage('characters/'..char)
        end
        ]]
    end
end
addHaxeLibrary('FlxBackdrop', 'flixel.addons.display')
function onCreatePost()
    setPropertyFromClass('backend.Conductor', 'bpm', 0)
    --[[menu.makeSprite('bg', 'checkeredGrid2', 0, 40)
    initLuaShader('scroll')
    setSpriteShader('bg', 'scroll')
    setProperty('bg.antialiasing', false)
    setShaderFloat('bg', 'xSpeed', 0.2/2)
    setShaderFloat('bg', 'ySpeed', (0.2/3)/2)
    scaleObject('bg', 1.996879875,1.996879875)
    addLuaSprite('bg')]]

    runHaxeCode([[
        var back = new FlxBackdrop().loadGraphic(Paths.image('checkeredGrid2'));
        back.cameras = [game.camOther];
        back.scale.set(1.996879875, 1.996879875);
        back.velocity.set((0.2/2) * 1000, ((0.2/3)/2) * 1000);
        back.antialiasing = ClientPrefs.data.antialiasing;
        game.modchartSprites.set('bg', back);
    ]])

    addLuaSprite('bg')

    for i, v in pairs(songs) do
        local tag = 'portrait'..i
        menu.makeSprite(tag, checkFileExists('images/portraits/'..v[1]..'.png') and 'portraits/'..v[1] or 'portraits/placeholder', globalPos.x, globalPos.y)
        addLuaSprite(tag)
        --makeAnimatedLuaSprite('preload'..i, 'characters/'..v[3])
        --removeLuaSprite('preload'..i, true)
    end
    local finishedAll = false
    for _,song in pairs(songs) do
        if (callMethodFromClass("backend.Highscore", "songScores.get", {song[1]}) or 0) > 0 then
            finishedAll = true
        else
            finishedAll = false
            break
        end
    end
    if finishedAll then
        for i, song in pairs(unlockable) do
            songs[#songs+1] = song
            local tag = 'portrait'..#songs
            menu.makeSprite(tag, checkFileExists('images/portraits/'..song[1]..'.png') and 'portraits/'..song[1] or 'portraits/placeholder', globalPos.x, globalPos.y)
            addLuaSprite(tag)
            --makeAnimatedLuaSprite('preload'..i, 'characters/'..song[3])
            --removeLuaSprite('preload'..i, true)
        end
    end
    menu.makeAnimatedSprite('char', 'characters/'..songs[curSelected][3], 150, 1280)
    addAnimationByPrefix('char', 'idle', 'idle', 12, false)
    addLuaSprite('char')

    menu.makeSprite('borderU')
    makeGraphic('borderU', screenWidth, screenHeight/6.7, '000000')
    addLuaSprite('borderU')
    menu.makeSprite('borderD')
    makeGraphic('borderD', screenWidth, screenHeight/6.7, '000000')
    setProperty('borderD.y', screenHeight - getProperty('borderD.height'))
    setProperty('borderD.flipY', true)
    addLuaSprite('borderD')

    menu.makeText('name', '', screenWidth, 0, 635)
    setTextSize('name', 45)
    setTextAlignment('name', 'center')
    addLuaText('name')
    --setTextFont('name', 'demonized.ttf')

    menu.makeText('info', '', screenWidth, 15, 17)
    setTextSize('info', 25)
    setTextAlignment('info', 'left')
    addLuaText('info')

    menu.makeText('starring', 'Starring ', screenWidth, -15, 30)
    setTextSize('starring', 25)
    setTextAlignment('starring', 'right')
    addLuaText('starring')

    menu.makeText('title', 'FLOOR 1', screenWidth, 0, 15)
    setTextSize('title', 45)
    setTextAlignment('title', 'center')
    addLuaText('title')

    menu.makeText('credits1', '', screenWidth, 0, screenHeight)
    setTextSize("credits1", 15)
    setTextAlignment("credits1", 'center')
    addLuaText("credits1")
    setProperty('credits1.alpha', 0.5)

    menu.makeSprite('button', 'tobasement', 0, screenHeight - 135)
    scaleObject('button',0.6,0.6)
    setProperty('button.alpha', 0.5)
    addLuaSprite('button')

    initSaveData("15lukas")
    --setDataFromSave("15lukas", "gotNotice", false)
    if not getDataFromSave("15lukas", "gotNotice") and finishedAll then
        setDataFromSave("15lukas", "gotNotice", true)
        menu.makeSprite('notice', 'notice')
        addLuaSprite('notice', true)
        onNotice = true
        allowMove = false
    end
end

local sin1 = 0
local confirmed = false
local lerpName = 0
local finalName = ''
function onUpdatePost(elapsed)
    sin1 = sin1+elapsed
    --setPropertyFromClass('backend.Conductor', 'songPosition', getPropertyFromClass('flixel.FlxG', 'sound.music.time'))
    if allow then
        if allowMove then
            if keyJustPressed('left') then
                lerpName = 0
                playSound('scrollMenu')
                if not songs[curSelected-1] then
                    curSelected = #songs
                    globalPos.x = defaultX - power * (#songs - 1)
                else
                    curSelected = curSelected - 1
                    globalPos.x = globalPos.x + power
                end
            end
            if keyJustPressed('right') then
                lerpName = 0
                playSound('scrollMenu')
                if not songs[curSelected+1] then
                    curSelected = 1
                    globalPos.x = defaultX
                else
                    curSelected = curSelected + 1
                    globalPos.x = globalPos.x - power
                end
            end
        end
        for i, v in pairs(songs) do
            local tag = 'portrait'..i
            setProperty(tag..'.x', lerp(getProperty(tag..'.x'), globalPos.x + ((i-1) * power), 0.1 * (elapsed*75)))
        end
        if keyJustPressed('accept') then
            if onNotice then
                playSound('scrollMenu')
                setProperty('notice.alpha', 0)
                onNotice = false
                allowMove = true
            else
                if not confirmed then
                    flash(0.5, 'ffffff', 0.5, 'add')
                    musicFadeIn(1)     
                    playMusic('preview/'..songs[curSelected][1], 0, true)
                    setPropertyFromClass('backend.Conductor', 'bpm', songs[curSelected][1] == 'n-4-p' and 0 or songs[curSelected][4])
                    songBpm = songs[curSelected][1] == 'n-4-p' and 0 or songs[curSelected][4]
                    onTimerCompleted('beat')
                    beat(1.025)
                    confirmed = true
                    allowMove = false
                    globalPos.x = globalPos.x + 250
                    setTextString("credits1", songs[curSelected][7] or '')
                    doTweenY('credits1', 'credits1', screenHeight-25, 0.5, 'quadOut')
                    removeAllTextPartColor('credits1')
                    for _,credit in pairs(basados) do
                        setTextPartColor('credits1', 'ffff00', credit)
                    end
                    for i, v in pairs(songs) do
                        local tag = 'portrait'..i
                        if curSelected ~= i then
                            doTweenY(tag..'out', tag, 1000, 1, 'quadIn')
                        end
                    end
                    doTweenY('charTween', 'char', 250 + songs[curSelected][5].offset.y, 0.5, 'quadOut')
                    loadFrames('char', 'characters/'..songs[curSelected][3])
                    addAnimationByPrefix('char', 'idle', songs[curSelected][3] == 'avgn' and 'IDLE' or 'idle', songs[curSelected][5].fps or 12, songs[curSelected][3] == 'jeff' or songs[curSelected][3] == 'pohsan')
                    setProperty('char.x', 150 + songs[curSelected][5].offset.x)
                    scaleObject('char', songs[curSelected][5].scale.x, songs[curSelected][5].scale.y)
                    setProperty('char.flipX', (songs[curSelected][3] == 'fb' or songs[curSelected][3] == 'avgn'))
                else
                    setPropertyFromClass('backend.Conductor', 'bpm', 0)
                    songBpm = 0
                    flash(1, 'ffffff', 1, 'add')
                    allow = false
                    playSound('confirmMenu')
                    playMusic('nothing', 0, true)
                    setPropertyFromClass("flixel.FlxG", "sound.music.volume", 0)
                    beat(1.05)
                    for i, v in pairs(songs) do
                        local tag = 'portrait'..i
                        if curSelected ~= i then
                            doTweenY(tag..'out', tag, 1000, 1, 'quadIn')
                        else
                            setProperty(tag..'.color', getColorFromHex(songs[i][2]))
                            doTweenColor(tag..'c', tag, 'ffffff', 0.5)
                        end
                    end
                    doTweenY('borderUClose', 'borderU.scale', 5.8, 0.8, 'cubeIn')
                    doTweenY('borderDClose', 'borderD.scale', 5.8, 0.8, 'cubeIn')
                end
            end
        end
        doTweenColor('bgc', 'bg', songs[curSelected][2], 0.5)
        if keyJustPressed('back') then
            if confirmed then
                setPropertyFromClass('backend.Conductor', 'bpm', 0)
                songBpm = 0
                musicFadeIn(1)
                playMusic(bgm, 0, true)
                globalPos.x = globalPos.x - 250
                doTweenY('credits1', 'credits1', screenHeight, 0.25, 'quadIn')
                for i, v in pairs(songs) do
                    local tag = 'portrait'..i
                    if curSelected ~= i then
                        doTweenY(tag..'out', tag, 150, 0.8, 'quadOut')
                    end
                end
                allowMove = true
                confirmed = false
                doTweenY('charTween', 'char', 1280, 0.5, 'quadIn')
            else 
                allow = false
                exitSong()
            end
        end
    end
    setTextString('name', string.upper(songs[curSelected][1]))
    local function round(number, decimals)
        local power = 10^decimals
        return math.floor(number * power) / power
    end

    if (lerpName < #songs[curSelected][6]) then
        lerpName = lerpName + 0.3
    else
        lerpName = #songs[curSelected][6]
    end

    setTextString('starring', 'Starring '..formatName(songs[curSelected][6], math.ceil(lerpName)))
    addHaxeLibrary('Highscore', 'backend')
    local function round(number, decimals)
        local power = 10^decimals
        return math.floor(number*power)/power
    end
    _score = callMethodFromClass("backend.Highscore", "songScores.get", {songs[curSelected][1]}) or 0
    _rating = (callMethodFromClass("backend.Highscore", "songRating.get", {songs[curSelected][1]}) and round(callMethodFromClass("backend.Highscore", "songRating.get", {songs[curSelected][1]})*100, 2) or 0)
    dscore = math.floor(lerp(dscore, _score, 0.25))
    drating = round(lerp(drating, _rating, 0.25), 2)
    setTextString("info", 'Score: '..dscore..'\nAccuracy: '..drating..'%')
    if not confirmed then
        setProperty('button.alpha', math.abs(math.sin(sin1))-0.25)
        if keyJustPressed('down') then
            loadSong('Floor-Basement')
        end
    else
        sin1 = 0
        setProperty('button.alpha', 0)
    end
end

function formatName(name, num)
    return name:sub(0, num)
end

function onTweenCompleted(tag)
    if tag == 'borderUClose' then
        playSound('close')
        runTimer('selected', 1)
        cameraShake('camOther', 0.025/6, 0.1)
    end
end
function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'selected' then
        loadSong(songs[curSelected][1])
    end
    if tag == 'beat' then
        if songBpm > 0 then
            runTimer('beat', (60/songBpm))
            beat(1.025)
            playAnim('char', 'idle', false)
        end
    end
end
local xd = 0
function onUpdate(elapsed)
    xd = xd + elapsed
    local speed, power = 3, 7
    for i, v in pairs(songs) do
        local tag = 'portrait'..i
        setProperty(tag..'.offset.y', math.sin(xd + i * speed)*power)
        setProperty(tag..'.angle', math.sin(xd + i * speed/2)*power/8)
        if curSelected ~= i then
            setProperty(tag..'.scale.x', lerp(getProperty(tag..'.scale.x'), 0.75, 0.25 * (elapsed*75)))
            setProperty(tag..'.scale.y', lerp(getProperty(tag..'.scale.y'), 0.75, 0.25 * (elapsed*75)))
        else
            setProperty(tag..'.scale.x', lerp(getProperty(tag..'.scale.x'), 1, 0.25 * (elapsed*75)))
            setProperty(tag..'.scale.y', lerp(getProperty(tag..'.scale.y'), 1, 0.25 * (elapsed*75)))
        end
    end
    if confirmed and not allow then
        setProperty('bg.velocity.x', getProperty('bg.velocity.x')+450*elapsed)
        setProperty('bg.velocity.y', getProperty('bg.velocity.y')+450*elapsed)
    end
end
function onBeatHit()
    beat(1.025)
    playAnim('char', 'idle', false)
end
function onDestroy()
    runHaxeCode([[
        game.camGame.bgColor = 0xFF000000;
    ]])
end
function onStartCountdown()
    return Function_Stop
end