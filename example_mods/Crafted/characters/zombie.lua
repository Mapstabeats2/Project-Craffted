--change values here
local path = 'icons/zombie icon'
local iconOffset = {-110, 20}
local animAlive = 'alive'
local animTurnDead = 'turn dead'
local animDead = 'dead'
local animTurnAlive = 'turn alive'
local scale = 1
local FPS = 24
local iconPosY = 0
--do not change values here
FPS = FPS / 2
function onCreate()
	makeAnimatedLuaSprite('iconOpp', path, 640 + iconOffset[1] + getVar('iconBopIntensity') / 2, 0)
	addLuaSprite('iconOpp', true)
	setObjectCamera('iconOpp', 'hud')
end
function onCreatePost()
	iconPosY = getProperty('healthBar.y') - 75 + iconOffset[2]
	setObjectOrder('iconOpp', getObjectOrder('iconP2', 'uiGroup'), 'uiGroup')
	setProperty('iconOpp.y', iconPosY)
	setProperty('iconOpp.scale.x', scale)
	setProperty('iconOpp.scale.y', scale)
	
	addAnimationByPrefix('iconOpp', 'alive', animAlive, FPS, true)
	addOffset('iconOpp', 'alive', 0 - 20, 0)
	addAnimationByPrefix('iconOpp', 'turnDead', animTurnDead, FPS, false)
	addOffset('iconOpp', 'turnDead', 65 - 20, 75)
	addAnimationByPrefix('iconOpp', 'dead', animDead, FPS, true)
	addOffset('iconOpp', 'dead', 18 - 20, 59)
	addAnimationByPrefix('iconOpp', 'turnAlive', animTurnAlive, FPS, false)
	addOffset('iconOpp', 'turnAlive', 53 - 20, 67)
	playAnim('iconOpp', 'alive')
	
	setProperty('iconP2.visible', false)
end

local dead = false
local function changeIconPos()
	--setProperty('iconOpp.x', getProperty('healthBar.barCenter') + iconOffset[1])
	if not dead and (getProperty('healthBar.percent') >= 80) then
		playAnim('iconOpp', 'turnDead', true)
		dead = true
	elseif dead and (getProperty('healthBar.percent') < 80) then
		playAnim('iconOpp', 'turnAlive', true)
		dead = false
	end
end
function goodNoteHit() changeIconPos() end
function noteMissPress() changeIconPos() end
function noteMiss() changeIconPos() end


function onUpdate(elapsed)
	if getProperty('iconOpp.animation.finished') then
		if getProperty('iconOpp.animation.curAnim.name') == 'turnDead' then
			playAnim('iconOpp', 'dead')
		elseif getProperty('iconOpp.animation.curAnim.name') == 'turnAlive' then
			playAnim('iconOpp', 'alive')
		end
	end
end

--https://gamebanana.com/questions/41871
--thanks E12345

function onBeatHit()
	scaleObject('iconP1', 1, 1)
	scaleObject('iconP2', 1, 1)
	if curBeat % 2 == 0 then
		setProperty('iconOpp.y', iconPosY + getVar('iconBopIntensity'))
	else
		setProperty('iconOpp.y', iconPosY - getVar('iconBopIntensity'))
	end
end
