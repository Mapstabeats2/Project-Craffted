function onEvent(tag, v1, v2)
	if tag == 'Camera angle twn' then
		local value = v1
		local duration
		local ease
        if v2 == '' then 
            duration = 1 
            ease = 'circOut'
        else 
            duration, ease = v2:match("([^,]+),([^,]+)")
        end	
        cancelTween('cameraAngleTwn')
		doTweenAngle('cameraAngleTwn', 'camGame', value, duration, ease)
	end

	if tag == 'Camera angle snap' then
		local value = v1
		cancelTween('cameraAngleTwn')
		setProperty('camGame.angle', value)
	end
end