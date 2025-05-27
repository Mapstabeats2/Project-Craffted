--by cyn0x8 lil modified by ipe
--modified again by CheesyCap
-- global vars


locked_pos = false
pos_speed = 8

note_offset = true
offset_radius = 8
shake_fps = 24

locked_zoom = false
zoom_speed = 2

sectionEase = 'circOut'
freeze = false

natural_bump_toggle = true
-- internal vars

local min = math.min
local max = math.max
local function lerp(start, goal, alpha) return start + (goal - start) * alpha end
local function trim(s) return s:match("^%s*(.-)%s*$") end
local function get_cam(cam)
	cam = trim(cam):lower()
	return (cam == "h" or cam == "hud" or cam == "camhud") and "h" or "g"
end

local targets = {}
local cur = {x = 0, y = 0}
local offset = {{x = 0, y = 0}, {x = 0, y = 0}}
local shaking = {g = {x = 0, y = 0}, h = {x = 0, y = 0}, t = 0}
local zooms = {g = 1, h = 1}
local bumping = {mod = 4, a = {g = 1, h = 2}}

-- global functions

function set_target(tag, x, y)
	targets[trim(tag)] = {
		x = tonumber(x) or 0,
		y = tonumber(y) or 0
	}
end

function focus(tag, duration, ease, lock)
	local target = targets[trim(tag)]
	if target then
		if lock == false then
			locked_pos = lock
		end
		
		if not locked_pos then
			if lock == true then
				locked_pos = lock
			end
			defaultDuration = 1.25
			if songName == 'First Night' then
				defaultDuration = 3
			end

			duration = tonumber(duration) or defaultDuration
			if songName == 'Im Scary Guye' and curBeat >= 553 then
				duration = 3
			end
			
			ease = ease or sectionEase
			if duration <= 0.01 then
				cancelTween("ncfx")
				cancelTween("ncfy")
				setProperty("ncf.x", target.x)
				setProperty("ncf.y", target.y)
			else
				doTweenX("ncfx", "ncf", target.x, duration, ease)
				doTweenY("ncfy", "ncf", target.y, duration, ease)
			end
		end
	end
end

function snap_target(tag)
	local target = targets[trim(tag)]
	if target then
		cur = {
			x = target.x,
			y = target.y
		}
		

		cancelTween("ncfx")
		cancelTween("ncfy")
		setProperty("camGame.scroll.x", cur.x - screenWidth / 2)
		setProperty("camGame.scroll.y", cur.y - screenHeight / 2)
		setProperty("ncf.x", cur.x)
		setProperty("ncf.y", cur.y)
	end
end

function shake(cam, x, y, duration, ease)
	cam = get_cam(cam)
	duration = tonumber(duration) or 0
	ease = ease or "linear"
	
	x = tonumber(x)
	if x then
		shaking[cam].x = x * (getRandomInt(1, 2) * 2 - 3)
		
		cancelTween("ncs" .. cam .. "x")
		setProperty("ncs" .. cam .. ".x", x)
		
		if duration > 0.01 and x ~= 0 then
			doTweenX("ncs" .. cam .. "x", "ncs" .. cam, 0, duration, ease)
		end
	end
	
	y = tonumber(y)
	if y then
		shaking[cam].y = y * (getRandomInt(1, 2) * 2 - 3)
		
		cancelTween("ncs" .. cam .. "y")
		setProperty("ncs" .. cam .. ".y", y)
		
		if duration > 0.01 and y ~= 0 then
			doTweenY("ncs" .. cam .. "y", "ncs" .. cam, 0, duration, ease)
		end
	end
end

function bump(cam, amount)
	if natural_bump_toggle then
		cam = get_cam(cam)
		amount = tonumber(amount) or (cam == "h" and 2 or 1)
		
		zooms[cam] = zooms[cam] + amount * 0.015
	end
end

function bump_speed(modulo, amount_game, amount_hud)
	bumping = {
		mod = tonumber(modulo) or 4,
		a = {
			g = tonumber(amount_game) or 1,
			h = tonumber(amount_hud) or 2
		}
	}
end

function zoom(cam, amount, duration, ease, lock)

			
	cam = get_cam(cam)
	amount = max(tonumber(amount) or (cam == "g" and getProperty("defaultCamZoom") or 1), 0)
	duration = tonumber(duration) or 0
	ease = ease or "linear"

	if lock == false then
		locked_zoom = lock
	end
	
	if not locked_zoom then
		if lock == true then
			locked_zoom = lock
		end
		
		if duration <= 0.01 then
			cancelTween("ncz" .. cam)
			setProperty("ncz" .. cam .. ".x", amount)
		else
			doTweenX("ncz" .. cam, "ncz" .. cam, amount, duration, ease)
		end
	end
end

function snap_zoom(cam, amount)
	cam = get_cam(cam)
	amount = max(tonumber(amount) or (cam == "g" and getProperty("defaultCamZoom") or 1), 0)
	
	zooms[cam] = amount
	cancelTween("ncz" .. cam)
	setProperty("ncz" .. cam .. ".x", amount)
end

function lock_cam(pos, zoom)
	locked_pos = pos
	locked_zoom = zoom
end

function toggle_natural_bump(tag)
	natural_bump_toggle = tag
end

runHaxeCode([[
	createGlobalCallback("nc_snap_zoom", function(cam:String, amount:Float) {parentLua.call("snap_zoom", [cam, amount]);});
	createGlobalCallback("nc_snap_target", function(tag:String) {parentLua.call("snap_target", [tag]);});
	createGlobalCallback("nc_set_target", function(tag:String, x:Int, y:Int) {parentLua.call("set_target", [tag, x, y]);});
	createGlobalCallback("nc_lock", function(pos:Bool, zoom:Bool) {parentLua.call("lock_cam", [pos, zoom]);});
	createGlobalCallback("nc_zoom", function(cam:String, amount:Float, duration:Float, ease:String) {parentLua.call("zoom", [cam, amount, duration, ease]);});
	createGlobalCallback("nc_focus", function(tag:String, duration:Float, ease:String, lock:Bool) {parentLua.call("focus", [tag, duration, ease, lock]);});
	createGlobalCallback("nc_bump", function(cam:String, amount:Float) {parentLua.call("bump", [cam, amount]);});
	createGlobalCallback("nc_bump_speed", function(modulo:Float, amount_game:Float, amount_hud:Float) {parentLua.call("bump_speed", [modulo, amount_game, amount_hud]);});
	createGlobalCallback("nc_shake", function(cam:String, x:Int, y:Int, duration:Float, ease:String) {parentLua.call("shake", [cam, x, y, duration, ease]);});
	createGlobalCallback("nc_reloadTargets", function() {parentLua.call("reloadTargets", []);});
	createGlobalCallback("nc_section_ease", function(tag:String, x:Int, y:Int) {parentLua.call("section_ease", []);});
	createGlobalCallback("ncskyan_toggle_natural_bump", function(tag:Bool) {parentLua.call("toggle_natural_bump", [tag]);});
]])



--setOnHScript("nc_bump", function() debugPrint("yuh") end)



-- internal functions

function reloadTargets()
	if not targets.opp then
		set_target("opp",
			getMidpointX("dad") + 150 + getProperty("dad.cameraPosition[0]") + getProperty("opponentCameraOffset[0]"),
			getMidpointY("dad") - 100 + getProperty("dad.cameraPosition[1]") + getProperty("opponentCameraOffset[1]")
		)
	end
	
	if not targets.plr then
		set_target("plr",
			getMidpointX("boyfriend") - 100 - getProperty("boyfriend.cameraPosition[0]") + getProperty("boyfriendCameraOffset[0]"),
			getMidpointY("boyfriend") - 100 + getProperty("boyfriend.cameraPosition[1]") + getProperty("boyfriendCameraOffset[1]")
		)
	end
	
	if not targets.center then
			set_target("center",
			(targets.opp.x + targets.plr.x) / 2,
			(targets.opp.y + targets.plr.y) / 2
		)
	end
end

local defaultZoom
function onCreatePost()
	defaultZoom = getProperty("defaultCamZoom")
	reloadTargets()
	--[[
	if runHaxeFunction("assert_gf") and not targets.gf then
		set_target("gf",
			getMidpointX("gf") + getProperty("gf.cameraPosition[0]") + getProperty("girlfriendCameraOffset[0]"),
			getMidpointY("gf") + getProperty("gf.cameraPosition[1]") + getProperty("girlfriendCameraOffset[1]")
		)
	end
	]]
	
	makeLuaSprite("ncf", "", 0, 0)
	
	snap_target("center")
	setProperty("isCameraOnForcedPos", true)
	
	makeLuaSprite("ncsg", "", 0, 0)
	makeLuaSprite("ncsh", "", 0, 0)
	
	zooms.g = getProperty("defaultCamZoom")
	makeLuaSprite("nczg", "", zooms.g, 0)
	makeLuaSprite("nczh", "", 1, 0)

	runHaxeCode([[
		game.setOnHScript("nc_snap_zoom", function(cam:String, amount:Float) {parentLua.call("snap_zoom", [cam, amount]);});
		game.setOnHScript("nc_snap_target", function(tag:String) {parentLua.call("snap_target", [tag]);});
		game.setOnHScript("nc_set_target", function(tag:String, x:Int, y:Int) {parentLua.call("set_target", [tag, x, y]);});
		game.setOnHScript("nc_lock", function(pos:Bool, zoom:Bool) {parentLua.call("lock_cam", [pos, zoom]);});
		game.setOnHScript("nc_zoom", function(cam:String, amount:Float, duration:Float, ease:String) {parentLua.call("zoom", [cam, amount, duration, ease]);});
		game.setOnHScript("nc_focus", function(tag:String, duration:Float, ease:String, lock:Bool) {parentLua.call("focus", [tag, duration, ease, lock]);});
		game.setOnHScript("nc_bump", function(cam:String, amount:Float) {parentLua.call("bump", [cam, amount]);});
		game.setOnHScript("nc_bump_speed", function(modulo:Float, amount_game:Float, amount_hud:Float) {parentLua.call("bump_speed", [modulo, amount_game, amount_hud]);});
		game.setOnHScript("nc_shake", function(cam:String, x:Int, y:Int, duration:Float, ease:String) {parentLua.call("shake", [cam, x, y, duration, ease]);});
		game.setOnHScript("nc_reloadTargets", function() {parentLua.call("reloadTargets", []);});
		game.setOnHScript("nc_section_ease", function(tag:String, x:Int, y:Int) {parentLua.call("section_ease", []);});
		game.setOnHScript("ncskyan_toggle_natural_bump", function(tag:Bool) {parentLua.call("toggle_natural_bump", [tag]);});
	]])
end

function onSongStart()
	focus(gfSection and "gf" or (mustHitSection and "plr" or "opp"), 1.25, sectionEase)
	if natural_bump_toggle then
		bump("game", bumping.a.g)
		bump("hud", bumping.a.h)
	end
	--zoom('game', 0.2, 1)
end


--this shit is confusing af
--? - and (then) // : - or (else) 
function onSectionHit()
	if songName == 'Im Scary Guye' and curBeat >= 557 then else
		focus(gfSection and "gf" or (mustHitSection and "plr" or "opp"), 1.25, sectionEase)
	end
end

--I'm (CheesyCap) stupid 
function onStepHit()
	local beatsPerSection = 4
	local jerseyClub = false
	local force = 1
	if songName == 'First Night' then
		beatsPerSection = 3
	elseif songName == 'Bountiful' then
		if curBeat >= 0 and curBeat < 36 then 
			beatsPerSection = 0
		elseif curBeat >= 36 and curBeat < 68 then
			beatsPerSection = 2
		elseif curBeat >= 68 and curBeat < 96 then
			beatsPerSection = 1
		elseif curBeat >= 96 and curBeat < 108 then
			beatsPerSection = 0
		elseif curBeat >= 108 and curBeat < 172 then
			beatsPerSection = 2
		elseif curBeat >= 172 and curBeat < 204 then
			beatsPerSection = 4
		elseif curBeat >= 204 and curBeat < 220 then
			beatsPerSection = 1
		elseif curBeat >= 220 and curBeat < 234 then
			jerseyClub = true
		elseif curBeat >= 234 and curBeat < 252 then
			beatsPerSection = 4
			force = 0.5
		elseif curBeat >= 252 and curBeat < 265 then
			beatsPerSection = 1
			force = 0.5
		elseif curBeat >= 265 and curBeat < 268 then
			beatsPerSection = 0
		elseif curBeat >= 268 and curBeat < 284 then
			beatsPerSection = 1
		elseif curBeat >= 284 and curBeat < 288 then
			beatsPerSection = 0
		elseif curBeat >= 288 and curBeat < 298 then
			beatsPerSection = 1
		elseif curBeat >= 298 and curBeat < 308 then
			beatsPerSection = 0
		elseif curBeat >= 308 and curBeat < 332 then
			beatsPerSection = 1
		elseif curBeat >= 332 and curBeat < 360 then
			beatsPerSection = 2
		elseif curBeat >= 360 then
			beatsPerSection = 0
		end
	elseif songName == 'Steve' then
		beatsPerSection = 4
	elseif songName == 'blockbuster' then
		if curSection <= 1 or curSection == 24 or curSection == 40 or curSection == 54 or (curBeat >= 198 and curBeat < 201) or curSection == 64 or curSection == 80 or curSection >= 83 then
			beatsPerSection = 0
		elseif curSection == 17 or curSection == 25 or curSection == 41 or curSection == 57 or curSection == 65 or (curSection >= 81 and curSection <= 82) then
			beatsPerSection = 1
		elseif (curSection >= 26 and curSection <= 39) or (curSection >= 66 and curSection <= 79) then
			beatsPerSection = 1
			force = 0.5
			if curStep % 16 == 4 or curStep % 16 == 12 then
				force = 0.25
			end
		elseif curSection >= 50 and curSection <= 56 then
			beatsPerSection = 1
			force = 0.25
			if curStep % 16 == 4 or curStep % 16 == 12 then
				force = 0.5
			end
		else
			beatsPerSection = 1
			if curStep % 16 == 4 or curStep % 16 == 12 then
				force = 0.5
			end
		end
	end
	if curStep % (bumping.mod * beatsPerSection) == 0 and natural_bump_toggle and not jerseyClub then
		bump("game", bumping.a.g * force)
		bump("hud", bumping.a.h * force)
	elseif natural_bump_toggle and jerseyClub then
		if curStep == curSection * 16 + 16
		or curStep == curSection * 16 + 4
		or curStep == curSection * 16 + 8 
		or curStep == curSection * 16 + 11
		or curStep == curSection * 16 + 14 then
			bump("game", bumping.a.g)
			bump("hud", bumping.a.h)
		end
	end
end

local function follow_note(dir)
	if not note_offset then
		offset[1] = {
			x = 0,
			y = 0
		}
	else
		local horizontal = dir == 0 or dir == 3
		offset[1] = {
			x = horizontal and (dir == 0 and -offset_radius or offset_radius) or 0,
			y = horizontal and 0 or (dir == 1 and offset_radius or -offset_radius)
		}
	end
end

function goodNoteHit(id, dir)
	if mustHitSection and not getPropertyFromGroup("notes.members", id, "noAnimation") then
		follow_note(dir)
	end
end

function opponentNoteHit(id, dir)
	if not mustHitSection and not getPropertyFromGroup("notes.members", id, "noAnimation") then
		follow_note(dir)
	end
end

local events = {
	nc_bump_speed = function(modulo, amounts)
		local amount_game, amount_hud = amounts:match("([^,]+),([^,]+)")
		bump_speed(modulo, amount_game, amount_hud)
	end,

	nc_lock_camera = function(pos, zoom)
		locked_pos = pos and (trim(pos):lower() == "true") or nil
		locked_zoom = zoom and (trim(zoom):lower() == "true") or nil
	end,
	
	nc_bump = function(amount_game, amount_hud)
		bump("game", amount_game)
		bump("hud", amount_hud)
	end,
	
	nc_focus = function(tag, params)
		local duration, ease, lock = params:match("([^,]+),([^,]+),([^,]+)")
		focus(tag, duration, ease, lock and (trim(lock):lower() == "true") or nil)
	end,
	
	nc_shake_game = function(pos, params)
		local x, y = pos:match("([^,]+),([^,]+)")
		local duration, ease = params:match("([^,]+),([^,]+)")
		shake("game", x, y, duration, ease)
	end,
	
	nc_shake_hud = function(pos, params)
		local x, y = pos:match("([^,]+),([^,]+)")
		local duration, ease = params:match("([^,]+),([^,]+)")
		shake("hud", x, y, duration, ease)
	end,
	
	nc_zoom_game = function(amount, params)
		local duration, ease, lock = params:match("([^,]+),([^,]+),([^,]+)")
		zoom("game", amount, duration, ease, lock and (trim(lock):lower() == "true") or nil)
	end,
	
	nc_zoom_hud = function(amount, params)
		local duration, ease, lock = params:match("([^,]+),([^,]+),([^,]+)")
		zoom("hud", amount, duration, ease, lock and (trim(lock):lower() == "true") or nil)
	end,

	nc_snap_target = function(tag, nothing)
		snap_target(tag)
	end,
	
	nc_snap_zoom = function(cam, amount)
		snap_zoom(cam, amount)
	end,

	nc_set_target = function(tag, pos)
		local x, y = pos:match("([^,]+),([^,]+)")
		set_target(tag, x, y)
	end,

	nc_section_ease = function(tag, nothing)
		sectionEase = tag
	end,

	nc_reload_targets = function(nothing, nothing)
		set_target("opp",
			getMidpointX("dad") + 150 + getProperty("dad.cameraPosition[0]") + getProperty("opponentCameraOffset[0]"),
			getMidpointY("dad") - 100 + getProperty("dad.cameraPosition[1]") + getProperty("opponentCameraOffset[1]")
		)
	
		set_target("plr",
			getMidpointX("boyfriend") - 100 - getProperty("boyfriend.cameraPosition[0]") + getProperty("boyfriendCameraOffset[0]"),
			getMidpointY("boyfriend") - 100 + getProperty("boyfriend.cameraPosition[1]") + getProperty("boyfriendCameraOffset[1]")
		)
	
		set_target("center",
			(targets.opp.x + targets.plr.x) / 2,
			(targets.opp.y + targets.plr.y) / 2
		)
	end,
}

function onEvent(tag, v1, v2)
	if events[tag] then
		events[tag](v1, v2)
	end
	if tag == 'screen_zoom' then
		focusScreen((v1 == 'true'))
	end
end

local eas = 'quadinout'
local tim = 0.75
function focusScreen(yes)
	if yes then
		locked_pos = false
		focus('screen', tim, eas, true)
        zoom('game', 1, tim, eas)
		note_offset = false
		tweenPos('dadtwn', 'dad', {getProperty('dad.x')-300, getProperty('dad.y')+300}, tim + 1.75, eas)
		tweenPos('bftwn', 'boyfriend', {getProperty('boyfriend.x')+120, getProperty('boyfriend.y')+120}, tim + 1.75, eas)
	else
		focus('center', tim, eas, false)
        zoom('game', 0.55, tim, eas)
		note_offset = true
		locked_pos = false
		tweenPos('dadtwn', 'dad', {getProperty('dad.x')+300, getProperty('dad.y')-300}, tim + 1.5, 'quadout')
		tweenPos('bftwn', 'boyfriend', {getProperty('boyfriend.x')-120, getProperty('boyfriend.y')-120}, tim + 1.5, 'quadout')
	end
end

function tweenPos(tag, obj, pos, time, ease)
	doTweenX(tag..'X', obj, pos[1], time, ease)
	doTweenY(tag..'Y', obj, pos[2], time, ease)
end

function onUpdatePost(elapsed)
	if not freeze then
		local alpha = min(max(elapsed * pos_speed, 0), 1)
		
		if not note_offset then
			offset[1] = {
				x = 0,
				y = 0
			}
		end
		
		offset[2] = {
			x = lerp(offset[2].x, offset[1].x, alpha),
			y = lerp(offset[2].y, offset[1].y, alpha)
		}
		
		shaking.t = shaking.t + elapsed
		if shaking.t > 1 / shake_fps then
			shaking = {
				g = {
					x = getRandomInt(-1, 1) * getProperty("ncsg.x"),
					y = getRandomInt(-1, 1) * getProperty("ncsg.y")
				},
				
				h = {
					x = getRandomInt(-1, 1) * getProperty("ncsh.x"),
					y = getRandomInt(-1, 1) * getProperty("ncsh.y")
				},
				
				t = shaking.t % (1 / shake_fps)
			}
		end
		
		cur = {
			x = lerp(cur.x, getProperty("ncf.x") + offset[2].x, alpha),
			y = lerp(cur.y, getProperty("ncf.y") + offset[2].y, alpha)
		}
		
		alpha = min(max(elapsed * zoom_speed, 0), 1)
		zooms.g = lerp(zooms.g, getProperty("nczg.x"), alpha)
		zooms.h = lerp(zooms.h, getProperty("nczh.x"), alpha)
		
		setProperty("camGame.followLerp", 0)
		
		setProperty("camGame.scroll.x", cur.x + shaking.g.x - screenWidth / 2)
		setProperty("camGame.scroll.y", cur.y + shaking.g.y - screenHeight / 2)
		setProperty("camGame.zoom", zooms.g)
		
		setProperty("camHUD.x", shaking.h.x)
		setProperty("camHUD.y", shaking.h.y)
		setProperty("camHUD.zoom", zooms.h)
	end
end

function onGameOverStart()
	freeze = true
end
