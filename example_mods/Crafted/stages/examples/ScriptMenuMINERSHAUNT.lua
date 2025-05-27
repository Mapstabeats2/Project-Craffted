local buttons = {
    {name = 'menu_play', x = 50, y = 530, animIdle = 'play', onClick = function() startPlay() end},
    {name = 'menu_credits', x = 368, y = 550, animIdle = 'credits', onClick = function() showCredits() end},
    {name = 'menu_options', x = 640, y = 550, animIdle = 'options', onClick = function() openOptions() end},
    {name = 'menu_quit', x = 912, y = 550, animIdle = 'quit', onClick = function() exitGame() end},
    {name = 'menu_skins', x = 905, y = 50, animIdle = 'skins', onClick = function() openSkinsMenu() end},
    {name = 'menu_twitter', x = 1130, y = 50, animIdle = 'twitter', onClick = function() openTwitter() end}
}

local images = {
    {name = "herobrine_mod_mauriwaka", text = "Director, Main composer,\nSFX designer, Herobrine VA,\nStory Boards, Charter and skin maker\n\nI didnt think I would achieve\nsuch a beautiful project,\nEverything is possible when\nyou work hard towards your goals.", nameTxt = "MauriWaka"},
    
    {name = "herobrine_mod_tinny", text = "Co-Director, Original creator,\nMain programmer, concept artist,\nStory Boards and Pixel Artist.\n\nproud of everyone who\nworked here yall did amazing", nameTxt = "_Tinny_"},
    
    {name = "herobrine_mod_bonettegmc", text = "Sprite Artist, cutscene animator,\nConcept Artist.\n\n\nmami salgo en la tele", nameTxt = "b0nette"},
    
    {name = "herobrine_mod_srwhite", text = "Cutscene animator.\n\n\n\nperoque gricura", nameTxt = "srwhiterealXD"},
    
    {name = "herobrine_mod_maximo", text = "Cutscene  animator, Pixel Artist,\nVisualizer and official gameplay maker,\n\n\nthis feels so... torture...", nameTxt = "MáximoS3ga"},
    
    {name = "herobrine_mod_goma", text = "Menu BG animator, Story Boards,\nand Memes creator.", nameTxt = "Fnaf_Gumball"},
    
    {name = "herobrine_mod_manuhx", text = "Composer.\n\n\n\nyo y los papus", nameTxt = "ManuHx"},
    
    {name = "herobrine_mod_gilberto", text = "Code assistance.\n\n\n\nSo uh, after 2 years this mod finally\ncoming out was worth it, honor working\nwith all the presents here who are my\nfriends.", nameTxt = "GilbertoTheCreator"},
    
    {name = "herobrine_mod_imjuangmc", text = "Herobrine Sprite Artist\nand Concept Artist.\n\n\nEl pepesito team", nameTxt = "ImJuanGMC"},
    
    {name = "herobrine_mod_fireveryhot", text = "Coder Menu, White note,\n and GameOver\n\n\nque alguien me quite\nel internet  :'v", nameTxt = "FireVeryHot"},
    
    {name = "herobrine_mod_asbel", text = "PORT Gameplay\n\n\n\neste truco solo\nse puede hacer una vez\nXD", nameTxt = "LiterallyAsbelin"},
    
    {name = "herobrine_mod_flasti", text = "Cutscene animator Lyric and end\n\n\n\nAnime en este Edit", nameTxt = "Flasticundo.2.0"},
        
    {name = "herobrine_mod_derick", text = "optimizador\n\n\n\nSaquen un mod de\nDerick X Fire\nXD\n\nno se que poner :v", nameTxt = "Derick"}
}

local jukeboxSongs = {
    {
title = "< Main Menu >",
composer = "Composed by MauriWska",
track = "FreakyMenu"},
{
title = "< Torture >",
composer = "Composed by MauriWska",
track = "TortureOst"},
{
title = "< Torture (instrumental version) >",
composer = "Composed by MauriWska (ft. manhux)",
track = "TortureInst"},
{
title = "< Game Over (Torture Mix) >",
composer = "Composed by MauriWska (ft. manhux)",
track = "gameOverTORTURE"},
{
title = "< HotChocolate >",
composer = "Composed by ???",
track = "hotchocolate"}
}

local randomTexts = {
    "tehcnoblade never dies",
    "MineCraft is live",
    "FIRE x MINECRAFT",
    "XDDXDXDDDXD",
    "Hi!",
    "port lua is so hard!",
    "Derick or black?",
    "Dont click me!",
    "Derick X Fire"
}

local mousePreviouslyPressed = false
local menu = true
local play = false

local fireMenuLimits = {
    xMin = -10,
    xMax = 10,
    yMin = -10,
    yMax = 10
}
local mouseX = 0
local mouseY = 0

local zoomDirection = 1
local maxSize = 24
local minSize = 18
local zoomAccumulator = minSize
local zoomSpeed = 0.2

local isActive = {false, false, false}
local activeIndex = nil
local selectedDifficulty = nil
local mouseOverSprite4 = false
local mouseOverSprite5 = false
local mouseOverSprite6 = false
local mousePressedNow = false

local currentIndex = 1
local startXcredi = 335
local startY = 130
local spacing = 430
local moving = false
local credits = false

local galleryPhotos = {}
local currentPhotoIndex = 1
local galleryEnabled = false

local photoPosX = screenWidth / 2
local photoPosY = screenHeight / 2

local currentSongIndex = 1
local jukeboxCode = false

local back = false
local backplay = false
local backcredits = false

function onCreatePost()
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', true)
end

function onCreate()
setProperty('skipCountdown', true)
playMusic('freakyMemu', 1, true)

--       ================ MENU PRINCIPAL ================
    makeAnimatedLuaSprite('FireMenu', 'menu/BonFire', 0, 0)
    addAnimationByPrefix('FireMenu', 'idle', 'fire', 12, true)
    scaleObject('FireMenu', 1.4, 1.4)
    setProperty('FireMenu.scale.x', 1.45)
    setProperty('FireMenu.scale.y', 1.45)
    setObjectCamera('FireMenu', 'other')
    setProperty('FireMenu.alpha', 1)
    addLuaSprite('FireMenu')
    playAnim('FireMenu', 'idle', true)
    
    makeLuaSprite('logo', 'menu/miners_haunt_logo', 55, 75)
    setObjectCamera('logo', 'other')
    scaleObject('logo', 0.6, 0.6)
    setProperty('logo.alpha', 1)
    addLuaSprite('logo')
    
    local randomText = randomTexts[getRandomInt(1, #randomTexts)]
    makeLuaText('textsplash', randomText, 770, 10, 180)
    setTextAlignment('textsplash', 'center')
    addLuaText('textsplash')
    setTextFont('textsplash', 'Minecraftia-Regular.ttf')
    setProperty('textsplash.angle', -30)
    setProperty('textsplash.alpha', 1)
    setObjectCamera('textsplash', 'other')
    setTextColor('textsplash', 'FFFF00')
    setTextSize('textsplash', minSize)

    for _, button in ipairs(buttons) do
        makeAnimatedLuaSprite(button.name, 'menu/mainmenu/' .. button.name, button.x, button.y)
        addAnimationByPrefix(button.name, 'idle', button.animIdle .. 'idle', 24, true)
        addAnimationByPrefix(button.name, 'select', button.animIdle .. 'select', 24, true)
        setObjectCamera(button.name, 'other')
        setProperty(button.name .. '.alpha', 1)
        addLuaSprite(button.name)
        playAnim(button.name, 'idle', true)
    end
    
    makeLuaSprite('borde', 'menu/marco', 0, 0)
    setObjectCamera('borde', 'other')
    setProperty('borde.alpha', 1)
    addLuaSprite('borde')
    
--       ================ TWITTER X MENU ================
    makeLuaSprite('bgt', '', 0, 0)
    makeGraphic('bgt', screenWidth, screenHeight, '000000')
    scaleObject('bgt', 1, 1)
    addLuaSprite('bgt')
    setObjectCamera('bgt', 'other')
    setProperty('bgt.alpha', 0)
    
    makeLuaSprite('X', 'menu/TeamX', 0, 0)
    setObjectCamera('X', 'other')
    setProperty("X.x", photoPosX - (getProperty("X.width") / 2))
    setProperty("X.y", photoPosY - (getProperty("X.height") / 2))
    setProperty('X.alpha', 0)
    addLuaSprite('X')
    
--       ================ SKINS MENU ================
    makeLuaSprite('ski', 'menu/skinInf', 0, 0)
    setObjectCamera('ski', 'other')
    setProperty("ski.x", photoPosX - (getProperty("ski.width") / 2))
    setProperty("ski.y", photoPosY - (getProperty("ski.height") / 2))
    setProperty('ski.alpha', 0)
    addLuaSprite('ski')
    
--       ================ PLAY MENU ================
    makeLuaSprite('hero', 'menu/hero', 0, 0)
    setObjectCamera('hero', 'other')
    setProperty('hero.scale.x', 1.2)
    setProperty('hero.scale.y', 1.2)
    setProperty('hero.alpha', 0)
    addLuaSprite('hero')
    
    makeLuaSprite('bghero', 'menu/bg', 0, 0)
    setObjectCamera('bghero', 'other')
    setProperty('bghero.alpha', 0)
    addLuaSprite('bghero')
    
    local startX = 102
    for i = 1, 3 do
        makeAnimatedLuaSprite('sprite' .. i, 'menu/difficultythingie', startX + (132 * (i - 1)), 393)
        addAnimationByPrefix('sprite' .. i, 'idle','normal', 24, true)
        addAnimationByPrefix('sprite' .. i, 'active','selected', 24, true)
        setObjectCamera('sprite' .. i, 'other')
        setProperty('sprite' .. i .. '.alpha', 0)
        scaleObject('sprite' .. i, 1.1, 1.1)
        addLuaSprite('sprite' .. i)
        playAnim('sprite' .. i, 'idle', true)
    end
    
    makeAnimatedLuaSprite('sprite4','menu/mainmenu/menu_play',80, 590)
    addAnimationByPrefix('sprite4', 'normal', 'playidle', 24, true)
    addAnimationByPrefix('sprite4', 'hover', 'playselect', 24, true)
    setObjectCamera('sprite4', 'other')
    setProperty('sprite4.color', getColorFromHex('BFBFBF'))
    setProperty('sprite4.alpha', 0)
    addLuaSprite('sprite4')
    playAnim('sprite4', 'normal', true)
    
    makeAnimatedLuaSprite('sprite5','menu/mainmenu/menu_gallery',600, 590)
    addAnimationByPrefix('sprite5', 'normal', 'galleryidle', 24, true)
    addAnimationByPrefix('sprite5', 'hover', 'galleryselect', 24, true)
    setObjectCamera('sprite5', 'other')
    setProperty('sprite5.alpha', 0)
    addLuaSprite('sprite5')
    playAnim('sprite5', 'normal', true)
    
    makeAnimatedLuaSprite('sprite6','menu/mainmenu/menu_jukebox',960, 590)
    addAnimationByPrefix('sprite6', 'normal', 'jukeboxidle', 24, true)
    addAnimationByPrefix('sprite6', 'hover', 'jukeboxselect', 24, true)
    setObjectCamera('sprite6', 'other')
    setProperty('sprite6.alpha', 0)
    addLuaSprite('sprite6')
    playAnim('sprite6', 'normal', true)
    
--       ================ CREDITOS PTM ================
    makeLuaSprite('bg', 'credits/bg', 0, 0)
    setObjectCamera('bg', 'other')
    setProperty('bg.alpha', 0)
    addLuaSprite('bg')

    for i, img in ipairs(images) do
        makeLuaSprite(img.name, 'credits/ocs/' .. img.name, startXcredi + (i - 1) * spacing, startY)
        setObjectCamera(img.name, 'other')
        setProperty(img.name .. '.alpha', 0)
        addLuaSprite(img.name)
    end

    makeLuaSprite('page', 'credits/page', 50, 150)
    setObjectCamera('page', 'other')
    setProperty('page.alpha', 0)
    scaleObject('page', 1.35, 1.35)
    addLuaSprite('page')

    makeLuaText('cre', 'CREDITS', 400, screenWidth / 2 - 200, 24)
    setTextAlignment('cre', 'center')
    setObjectCamera('cre', 'other')
    setTextFont('cre', 'Minecraftia-Regular.ttf')
    addLuaText('cre')
    setProperty('cre.alpha', 0)
    setTextSize('cre', 25)

    makeLuaText('nameTxtcredi', images[currentIndex].nameTxt, 600, -80, 210)
    setTextAlignment('nameTxtcredi', 'center')
    setObjectCamera('nameTxtcredi', 'other')
    setTextFont('nameTxtcredi', 'Minecraftia-Regular.ttf')
    addLuaText('nameTxtcredi')
    setTextColor('nameTxtcredi', '000000')
    setTextBorder('nameTxtcredi', 0, '000000')
    setTextSize('nameTxtcredi', 20)
    setProperty('nameTxtcredi.alpha', 0)

    makeLuaText('imageText', images[currentIndex].text, 600, -80, 257)
    setTextAlignment('imageText', 'center')
    setObjectCamera('imageText', 'other')
    setTextFont('imageText', 'Minecraftia-Regular.ttf')
    addLuaText('imageText')
    setTextColor('imageText', '000000')
    setTextBorder('imageText', 0, '000000')
    setTextSize('imageText', 12)
    setProperty('imageText.alpha', 0)

    makeLuaText('hoverText','-SPECIAL THANKS-', 600, screenWidth / 2 - 300, 625)
    setTextAlignment('hoverText', 'center')
    setObjectCamera('hoverText', 'other')
    setTextFont('hoverText', 'Minecraftia-Regular.ttf')
    addLuaText('hoverText')
    setTextColor('hoverText', '555555')
    setTextSize('hoverText', 19)
    setProperty('hoverText.alpha', 0)
    
    makeLuaSprite('ST', 'credits/SpecialThanks', 0, 0)
    setObjectCamera('ST', 'other')
    addLuaSprite('ST')
    setProperty('ST.alpha', 0)
    
--       ================ GALLERY ================
    makeLuaText('gal', 'GALLERY', 400, screenWidth / 2 - 200, 24)
    setTextAlignment('gal', 'center')
    setObjectCamera('gal', 'other')
    setTextFont('gal', 'Minecraftia-Regular.ttf')
    addLuaText('gal')
    setProperty('gal.alpha', 0)
    setTextSize('gal', 25)

    for i = 0, 27 do
    local photoName = "concept" .. i
    galleryPhotos[i + 1] = photoName
    makeLuaSprite(photoName, "menu/gallery/" .. photoName, 0, 0)
    setObjectCamera(photoName, 'other')
    setProperty(photoName .. ".alpha", 0)
    addLuaSprite(photoName)
    setProperty(photoName .. ".x", photoPosX - (getProperty(photoName .. ".width") / 2))
    setProperty(photoName .. ".y", photoPosY - (getProperty(photoName .. ".height") / 2))
    end
    setProperty(galleryPhotos[currentPhotoIndex] .. ".alpha", 0)
    
--       ================ JUKEBOX MENU ================
    makeLuaSprite('box', 'menu/jukebox/box', 0, 0)
    setObjectCamera('box', 'other')
    setProperty('box.alpha', 0)
    addLuaSprite('box')

    makeLuaText("now", "Now Playing:", 800, 400, 265)
    setTextAlignment("now", "center")
    setTextSize("now", 32)
    setObjectCamera("now", "other")
    setProperty('now.alpha', 0)
    addLuaText("now")
    
    makeLuaText("songTitleText", jukeboxSongs[currentSongIndex].title, 800, 400, 340)
    setTextAlignment("songTitleText", "center")
    setTextSize("songTitleText", 32)
    setObjectCamera("songTitleText", "other")
    addLuaText("songTitleText")
    setProperty('songTitleText.alpha', 0)

    makeLuaText("composerText", jukeboxSongs[currentSongIndex].composer, 800, 400, 410)
    setTextAlignment("composerText", "center")
    setTextSize("composerText", 27)
    setObjectCamera("composerText", "other")
    addLuaText("composerText")
    setProperty('composerText.alpha', 0)
    
    makeLuaSprite('borde2', 'menu/marco', 0, 0)
    setObjectCamera('borde2', 'other')
    addLuaSprite('borde2')
    setProperty('borde2.alpha', 0)
    
    playMusic(jukeboxSongs[currentSongIndex].track, 1, true)
    
-- backboton
    makeAnimatedLuaSprite('backboton','menu/mainmenu/backbutton',1150, 0)
    addAnimationByPrefix('backboton', 'normal', 'idle', 24, true)
    addAnimationByPrefix('backboton', 'hover', 'select', 24, true)
    setObjectCamera('backboton', 'other')
    setProperty('backboton.alpha', 0)
    addLuaSprite('backboton')
    playAnim('backboton', 'normal', true)
    
-- raton
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', false)
    makeLuaSprite('customCursor', 'cursor', 0, 0)
    addLuaSprite('customCursor', true)
    setObjectCamera('customCursor', 'other')
end


function onUpdatePost()
    if zoomDirection == 1 then
        zoomAccumulator = zoomAccumulator + zoomSpeed
        if zoomAccumulator >= maxSize then
            zoomDirection = -1
        end
    elseif zoomDirection == -1 then
        zoomAccumulator = zoomAccumulator - zoomSpeed
        if zoomAccumulator <= minSize then
            zoomDirection = 1
        end
    end
    
    mouseX = getMouseX('other')
    mouseY = getMouseY('other')

    setProperty('customCursor.x', mouseX)
    setProperty('customCursor.y', mouseY)

    setTextSize('textsplash', math.floor(zoomAccumulator))
    
    local mouseX, mouseY = getMouseX('other'), getMouseY('other')
    local mousePressedNow = mousePressed('left')
    
    moveFireMenu(mouseX, mouseY)
    
--       ================ CODIGO MENU ================
    if menu then
    for _, button in ipairs(buttons) do
        local sprite = button.name
        local x, y = getProperty(sprite .. '.x'), getProperty(sprite .. '.y')
        local width, height = getProperty(sprite .. '.width'), getProperty(sprite .. '.height')
        
        if mouseX >= x and mouseX <= x + width and mouseY >= y and mouseY <= y + height then
            if getProperty(sprite .. '.animation.curAnim.name') ~= 'select' then
                playAnim(sprite, 'select', true)
                playSound('scrollMenu')
            end
            
            if mousePressedNow and not mousePreviouslyPressed then
                button.onClick()
                playSound('cancelMenu')
            end
        else
            if getProperty(sprite .. '.animation.curAnim.name') ~= 'idle' then
                playAnim(sprite, 'idle', true)
            end
        end
    end
    end
    
    local mouseX, mouseY = getMouseX('other'), getMouseY('other')
    local mousePressedNow = mousePressed('left')
    
--       ================ CODIGO PLAY ================
    if play then
    for i = 1, 3 do
        local x, y = getProperty('sprite' .. i .. '.x'), getProperty('sprite' .. i .. '.y')
        local width, height = getProperty('sprite' .. i .. '.width'), getProperty('sprite' .. i .. '.height')

        if mouseX >= x and mouseX <= x + width and mouseY >= y and mouseY <= y + height then
            if mousePressedNow and not mousePreviouslyPressed then
                if not isActive[i] then
                    for j = 1, 3 do
                        isActive[j] = false
                        playAnim('sprite' .. j, 'idle', true)
                    end
                    isActive[i] = true
                    activeIndex = i
                    selectedDifficulty = i
                    playAnim('sprite' .. i, 'active', true)
                    setProperty('sprite4.color', getColorFromHex('FFFFFF'))
                else
                    isActive[i] = false
                    activeIndex = nil
                    selectedDifficulty = nil
                    playAnim('sprite' .. i, 'idle', true)
                    setProperty('sprite4.color', getColorFromHex('BFBFBF'))
                end
            end
        end
    end
    
-- play
local x, y = getProperty('sprite4.x'), getProperty('sprite4.y')
local width, height = getProperty('sprite4.width'), getProperty('sprite4.height')

if mouseX >= x and mouseX <= x + width and mouseY >= y and mouseY <= y + height then
    playAnim('sprite4', 'hover', true)

    if not mouseOverSprite4 then
        playSound('scrollMenu')
        mouseOverSprite4 = true
    end

    if mousePressedNow and not mousePreviouslyPressed then
        if selectedDifficulty ~= nil then
            if selectedDifficulty == 1 then
                startSong('Torture', 0)
            elseif selectedDifficulty == 2 then
                startSong('Torture', 1)
            elseif selectedDifficulty == 3 then
                startSong('Torture', 2)
            end
        else
            playSound('cancelMenu')
        end
    end
else
    playAnim('sprite4', 'normal', true)
    mouseOverSprite4 = false
end

-- gallery
x, y = getProperty('sprite5.x'), getProperty('sprite5.y')
width, height = getProperty('sprite5.width'), getProperty('sprite5.height')

if mouseX >= x and mouseX <= x + width and mouseY >= y and mouseY <= y + height then
    playAnim('sprite5', 'hover', true)

    if not mouseOverSprite5 then
        playSound('scrollMenu')
        mouseOverSprite5 = true
    end

    if mousePressedNow and not mousePreviouslyPressed then
        playSound('confirmMenu')
    gallery()
    end
else
    playAnim('sprite5', 'normal', true)
    mouseOverSprite5 = false
end

-- box
x, y = getProperty('sprite6.x'), getProperty('sprite6.y')
width, height = getProperty('sprite6.width'), getProperty('sprite6.height')

if mouseX >= x and mouseX <= x + width and mouseY >= y and mouseY <= y + height then
    playAnim('sprite6', 'hover', true)

    if not mouseOverSprite6 then
        playSound('scrollMenu')
        mouseOverSprite6 = true
    end

    if mousePressedNow and not mousePreviouslyPressed then
        playSound('confirmMenu')
    jukebox()
    end
else
    playAnim('sprite6', 'normal', true)
    mouseOverSprite6 = false
end
end
mousePreviouslyPressed = mousePressedNow

--       ================ CODIGO CREDITS ================
    if credits then
        if not moving then
            if keyJustPressed('right') and currentIndex < #images then
                moving = true
                currentIndex = currentIndex + 1
                updatePositions(-spacing)
                updateText()
            end

            if keyJustPressed('left') and currentIndex > 1 then
                moving = true
                currentIndex = currentIndex - 1
                updatePositions(spacing)
                updateText()
            end
        end

        if isMouseOverText('hoverText') then
            setTextColor('hoverText', 'FFFFFF')
            if mouseClicked('left') then
                onHoverTextClick()
            end
        else
            setTextColor('hoverText', '555555')
        end
    end
    
--       ================ CODIGO GALLERY ================
    if galleryEnabled then
    if keyJustPressed("right") and currentPhotoIndex < #galleryPhotos then
        setProperty(galleryPhotos[currentPhotoIndex] .. ".alpha", 0)
        currentPhotoIndex = currentPhotoIndex + 1
        setProperty(galleryPhotos[currentPhotoIndex] .. ".alpha", 1)
    end

    if keyJustPressed("left") and currentPhotoIndex > 1 then
        setProperty(galleryPhotos[currentPhotoIndex] .. ".alpha", 0)
        currentPhotoIndex = currentPhotoIndex - 1
        setProperty(galleryPhotos[currentPhotoIndex] .. ".alpha", 1)
    end
    end
    
--       ================ CODIGO JUKEBOX ================
    if jukeboxCode then
    if keyJustPressed("left") then
        navigateJukebox(-1)
    elseif keyJustPressed("right") then
        navigateJukebox(1)
    end
    end

--       ================ Back Menu ================
if back then
    if keyPressed('back') or (getMouseX('camHUD') > 1150 and getMouseX('camHUD') < 1280) and (getMouseY('camHUD') > 0 and getMouseY('camHUD') < 126 and mousePressed('left')) then
    backmenu()
    playAnim('backboton', 'hover', true)
    else
    playAnim('backboton', 'normal', true)
end
end

--       ================ Back Play ================
if backplay then
    if keyPressed('back') or (getMouseX('camHUD') > 1150 and getMouseX('camHUD') < 1280) and (getMouseY('camHUD') > 0 and getMouseY('camHUD') < 126 and mousePressed('left')) then
    startPlay()
end
end

--       ================ Back Credits ================
if backcredits then
    if keyPressed('back') or (getMouseX('camHUD') > 1150 and getMouseX('camHUD') < 1280) and (getMouseY('camHUD') > 0 and getMouseY('camHUD') < 126 and mousePressed('left')) then
    showCredits()
end
end

end

function moveFireMenu(mouseX, mouseY)
    local screenWidth = getPropertyFromClass('flixel.FlxG', 'width')
    local screenHeight = getPropertyFromClass('flixel.FlxG', 'height')
    local centerX = screenWidth / 2
    local centerY = screenHeight / 2

    local offsetX = (mouseX - centerX) / centerX
    local offsetY = (mouseY - centerY) / centerY

    local newX = math.clamp(offsetX * fireMenuLimits.xMax, fireMenuLimits.xMin, fireMenuLimits.xMax)
    local newY = math.clamp(offsetY * fireMenuLimits.yMax, fireMenuLimits.yMin, fireMenuLimits.yMax)

    setProperty('FireMenu.x', newX)
    setProperty('FireMenu.y', newY)
    
    setProperty('hero.x', newX)
    setProperty('hero.y', newY)
    
    setProperty('box.x', newX)
    setProperty('box.y', newY)
end

function math.clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

function updatePositions(offset)
    for i, img in ipairs(images) do
        local targetX = getProperty(img.name .. '.x') + offset
        doTweenX('move' .. i, img.name, targetX, 0.2, 'linear')
    end
    runTimer('unlockMovement', 0.2)
end

function updateText()
    setTextString('imageText', images[currentIndex].text)
    setTextString('nameTxtcredi', images[currentIndex].nameTxt)
end

function onTimerCompleted(tag)
    if tag == 'unlockMovement' then
        moving = false
    end
    if tag == 'backOn' then
        back = true
        setProperty('backboton.alpha', 1)
    end
end

function isMouseOverText(textName)
    local mouseX, mouseY = getMouseX('other'), getMouseY('other')
    local textX, textY = getProperty(textName .. '.x'), getProperty(textName .. '.y')
    local textWidth = getProperty(textName .. '.width')
    local textHeight = getProperty(textName .. '.height')

    return mouseX >= textX and mouseX <= textX + textWidth and mouseY >= textY and mouseY <= textY + textHeight
end

function navigateJukebox(direction)
    currentSongIndex = currentSongIndex + direction
    if currentSongIndex < 1 then
        currentSongIndex = #jukeboxSongs
    elseif currentSongIndex > #jukeboxSongs then
        currentSongIndex = 1
    end
    setTextString("songTitleText", jukeboxSongs[currentSongIndex].title)
    setTextString("composerText", jukeboxSongs[currentSongIndex].composer)

    if jukeboxSongs[currentSongIndex].track then
        playMusic(jukeboxSongs[currentSongIndex].track, 1, true)
    else
        stopMusic()
    end
end

--       ================ Todas las Funciones ================

function startSong(songName, difficulty)
    debugPrint('Iniciando la canción: ' .. songName .. ' en dificultad ' .. difficulty)
    loadSong(songName, difficulty)
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', false)
end


function startPlay()
for _, button in ipairs(buttons) do
setProperty(button.name .. '.alpha', 0)
end
setProperty('FireMenu.alpha', 0)
setProperty('logo.alpha', 0)
setProperty('textsplash.alpha', 0)
setProperty('borde.alpha', 0)

setProperty('hero.alpha', 1)
setProperty('bghero.alpha', 1)
setProperty('refe.alpha', 1)
setProperty('sprite1.alpha', 1)
setProperty('sprite2.alpha', 1)
setProperty('sprite3.alpha', 1)
setProperty('sprite4.alpha', 1)
setProperty('sprite5.alpha', 1)
setProperty('sprite6.alpha', 1)
setProperty('backboton.alpha', 1)

-- gallery
setProperty(galleryPhotos[currentPhotoIndex] .. ".alpha", 0)
setProperty('gal.alpha', 0)
galleryEnabled = false

-- jukebox
setProperty('box.alpha', 0)
setProperty('songTitleText.alpha', 0)
setProperty('composerText.alpha', 0)
setProperty('now.alpha', 0)
setProperty('borde2.alpha', 0)
jukeboxCode = false

menu = false
play = true
back = true
backplay = false
end

function showCredits()
for _, button in ipairs(buttons) do
setProperty(button.name .. '.alpha', 0)
end
setProperty('FireMenu.alpha', 0)
setProperty('logo.alpha', 0)
setProperty('textsplash.alpha', 0)
setProperty('borde.alpha', 0)

setProperty('bg.alpha', 1)
for i, img in ipairs(images) do
setProperty(img.name .. '.alpha', 1)
end
setProperty('page.alpha', 1)
setProperty('cre.alpha', 1)
setProperty('nameTxtcredi.alpha', 1)
setProperty('imageText.alpha', 1)
setProperty('hoverText.alpha', 1)
setProperty('ST.alpha', 0)
setProperty('backboton.alpha', 1)

menu = false
credits = true
back = true
backcredits = false
end

function openTwitter()
setProperty('bgt.alpha', 0.7)
setProperty('X.alpha', 1)
setProperty('textsplash.alpha', 0)
menu = false
runTimer('backOn', 0.5)
end

function openOptions()
runHaxeCode([[
import backend.MusicBeatState;
import options.OptionsState;
var pauseMusic = new flixel.sound.FlxSound();
try {
var pauseSong:String = getPauseSong();
if(pauseSong != null) pauseMusic.loadEmbedded(Paths.music(pauseSong), true, true);
}
catch(e:Dynamic) {}
pauseMusic.volume = 0;
pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));
MusicBeatState.switchState(new options.OptionsState());
if(ClientPrefs.data.pauseMusic != 'None')
{
FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.pauseMusic)),pauseMusic.volume);
FlxTween.tween(FlxG.sound.music,{volume: 1}, 0.8);
FlxG.sound.music.time = pauseMusic.time;
}
OptionsState.onPlayState = true;
]])
end

function exitGame()
    exitSong()
end

function openSkinsMenu()
setProperty('bgt.alpha', 0.7)
setProperty('ski.alpha', 1)
setProperty('textsplash.alpha', 0)
setProperty('backboton.alpha', 1)
menu = false
back = true
end

function onHoverTextClick()
setProperty('bg.alpha', 0)
for i, img in ipairs(images) do
setProperty(img.name .. '.alpha', 0)
end
setProperty('page.alpha', 0)
setProperty('cre.alpha', 0)
setProperty('nameTxtcredi.alpha', 0)
setProperty('imageText.alpha', 0)
setProperty('hoverText.alpha', 0)
setProperty('ST.alpha', 1)
credits = false
end

function gallery()
setProperty('bg.alpha', 1)
setProperty('gal.alpha', 1)
setProperty(galleryPhotos[currentPhotoIndex] .. ".alpha", 1)
galleryEnabled = true

setProperty('hero.alpha', 0)
setProperty('bghero.alpha', 0)
setProperty('refe.alpha', 0)
setProperty('sprite1.alpha', 0)
setProperty('sprite2.alpha', 0)
setProperty('sprite3.alpha', 0)
setProperty('sprite4.alpha', 0)
setProperty('sprite5.alpha', 0)
setProperty('sprite6.alpha', 0)
play = false
back = false
backplay = true
end

function jukebox()
setProperty('box.alpha', 1)
setProperty('songTitleText.alpha', 1)
setProperty('composerText.alpha', 1)
setProperty('now.alpha', 1)
setProperty('borde2.alpha', 1)
setProperty('bg.alpha', 1)

play = false
jukeboxCode = true
back = false
backplay = true
end

function backmenu()
-- menu
for _, button in ipairs(buttons) do
setProperty(button.name .. '.alpha', 1)
end
setProperty('FireMenu.alpha', 1)
setProperty('logo.alpha', 1)
setProperty('textsplash.alpha', 1)
setProperty('borde.alpha', 1)
setProperty('backboton.alpha', 0)
menu = true

-- twitter
setProperty('bgt.alpha', 0)
setProperty('X.alpha', 0)

-- skins
setProperty('ski.alpha', 0)

-- play
setProperty('hero.alpha', 0)
setProperty('bghero.alpha', 0)
setProperty('refe.alpha', 0)
setProperty('sprite1.alpha', 0)
setProperty('sprite2.alpha', 0)
setProperty('sprite3.alpha', 0)
setProperty('sprite4.alpha', 0)
setProperty('sprite5.alpha', 0)
setProperty('sprite6.alpha', 0)
play = false

-- gallery
setProperty(galleryPhotos[currentPhotoIndex] .. ".alpha", 0)
setProperty('gal.alpha', 0)
galleryEnabled = false

-- jukebox
setProperty('box.alpha', 0)
setProperty('songTitleText.alpha', 0)
setProperty('composerText.alpha', 0)
setProperty('now.alpha', 0)
setProperty('borde2.alpha', 0)
jukeboxCode = false

-- creditos
setProperty('bg.alpha', 0)
for i, img in ipairs(images) do
setProperty(img.name .. '.alpha', 0)
end
setProperty('page.alpha', 0)
setProperty('cre.alpha', 0)
setProperty('nameTxtcredi.alpha', 0)
setProperty('imageText.alpha', 0)
setProperty('hoverText.alpha', 0)
setProperty('ST.alpha', 0)
credits = false
back = false
end

function onStartCountdown()
    return Function_Stop
end

function onPause()
    return Function_Stop
end