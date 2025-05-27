--Script Made By Icaro lee from Psych Ward (Vanilla (V-Slice) HUD)

altenativeHelth = 1.0 --This is basically another Health thing
offset = 26

sDir = {"singLEFT", "singDOWN", "singUP", "singRIGHT"};

function onCreatePost()
	for i = 0, getProperty("unspawnNotes.length") - 1 do
        setPropertyFromGroup("unspawnNotes", i, "noAnimation", true)
        --setPropertyFromGroup("unspawnNotes", i, "noMissAnimation", true)
	end

    setProperty("camZoomingDecay", 3)
	
	makeLuaSprite('healthStuffobj', "", 0.015)
    setProperty("healthStuffobj.visible", false)
    addLuaSprite('healthStuffobj', false)




	setProperty("healthBar.x", getProperty("healthBarBG.x") + 4)
	setProperty("healthBar.y", getProperty("healthBarBG.y") + 4)

	setProperty("healthBar.width", getProperty("healthBarBG.width") - 8)

	setProperty('healthBar.numDivisions', 1000)
end

function onUpdatePost(elapsed)
	altenativeHelth = saygex(altenativeHelth, getProperty('health'), gaysex(elapsed * 40, 0, 1))
    local percent = 1 - straightsex(altenativeHelth, 0, 2) / 2

    setProperty('iconP1.x', getProperty('healthBar.x') + (getProperty('healthBar.width') * percent) + (150 * getProperty('iconP1.scale.x') - 150) / 2 - offset)
    setProperty('iconP2.x', getProperty('healthBar.x') + (getProperty('healthBar.width') * percent) - (150 * getProperty('iconP2.scale.x')) / 2 - offset * 2)
    if luaSpriteExists('iconOpp') then
        setProperty('iconOpp.x', getProperty('healthBar.x') + (getProperty('healthBar.width') * percent) - (150 * getProperty('iconP2.scale.x')) / 2 - offset * 2)
    end
    
end


function opponentNoteHit(i, note, noteType, isSustain)
    if noteType == "No Animation" then
        return Function_Continue
    end

    if getPropertyFromGroup('notes', i, 'gfNote') then -- "why you don't put "gfSection" instead BECAUSE THIS FUCKING GFSECTION DON'T LET THIS SHIT SING ANIM
        Opponent = "gf"
    else
        Opponent = "dad"
    end

    if getPropertyFromGroup("notes", i, "animSuffix") == "-alt" then
        OppAltAnim = "-alt"
    else
        OppAltAnim = ""
    end

    if not isSustain then
        playAnim(Opponent, sDir[note+1]..OppAltAnim, true)
    end

    setProperty(Opponent..".holdTimer", 0)
end

function goodNoteHit(i, note, noteType, isSustain)
    if noteType == "No Animation" then
        return Function_Continue
    end

	if getPropertyFromGroup('notes', i, 'gfNote') then -- "why you don't put "gfSection" instead BECAUSE THIS FUCKING GFSECTION DON'T LET THIS SHIT SING ANIM
        Player = "gf"
    else
        Player = "boyfriend"
    end

    if getPropertyFromGroup("notes", i, "animSuffix") == "-alt" then
        PlyrAltAnim = "-alt"
    else
        PlyrAltAnim = ""
    end

	if not isSustain then
		playAnim(Player, sDir[note+1]..PlyrAltAnim, true)
	end

    setProperty(Player..".holdTimer", 0)
end



-- custom function stuff

function saygex(a,b,ratio) --//not stolen from flixel.math.FlxMath
    return a + ratio * (b - a);
end

function gaysex(value, min, max)
    return math.max(min, math.min(max, value));
end

function straightsex(value, min, max)
    local lowerBound = (min ~= nil and value < min) and min or value;
    return (max ~= nil and lowerBound > max) and max or lowerBound;
end