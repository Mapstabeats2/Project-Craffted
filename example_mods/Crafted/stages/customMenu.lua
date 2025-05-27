function onStartCountdown()
    return Function_Stop
end

function onPause()
    return Function_Stop
end

function onUpdatePost()
	if keyboardJustPressed('E') then
		exitSong()
	end
	if keyboardJustPressed('R') then
		loadSong("project-crafted", "hard")
	end
end

function onBeatHit()
	--debugPrint("hah")
end

--why did I write all this stuff?

--getRunningScripts() is useful
--local scriptFiles = directoryFileList("mods/"..currentModDirectory.."/scripts/")
function onCreatePost()
	--[[
    for _, v in pairs(scriptFiles) do
        local fileExt = string.sub(v, string.len(v) - 2, string.len(v))
        if (fileExt == "lua") then
            removeLuaScript("scripts/"..string.sub(v, 1, -5))
        --elseif (fileExt == ".hx") then
            --removeHScript("scripts/"..string.sub(v, 1, -4))
        end
    end
	]]
	--removeHScript("scripts/Transition")
	--removeHScript("scripts/menuLockPlay")
	--removeHScript("scripts/menuLockPause")
	--removeHScript("scripts/cinematicBars")
	--runTimer("removeHScriptTimer", 0.5)
end
--[[
function onTimerCompleted(tag, loops, loopsLeft)
	-- A loop from a timer you called has been completed, value "tag" is it's tag
	-- loops = how many loops it will have done when it ends completely
	-- loopsLeft = how many are remaining
	if tag == "removeHScriptTimer" then
		for _, v in pairs(scriptFiles) do
			local fileExt = string.sub(v, string.len(v) - 2, string.len(v))
			if (fileExt == ".hx") then
				debugPrint("scripts/"..string.sub(v, 1, -4))
				--removeHScript("scripts/"..string.sub(v, 1, -4))
			end
		end
	end
end
]]