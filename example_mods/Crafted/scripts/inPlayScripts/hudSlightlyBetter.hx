import flixel.util.FlxStringUtil;

import backend.Language;
import backend.CoolUtil;

var iconBopIntensity:Float = 2.5;
setVar("iconBopIntensity", iconBopIntensity);
var iconPosY:Int;
function onCreatePost() {
    iconPosY = healthBar.y - 75;
    iconP1.y = iconPosY - iconBopIntensity / 2;
    iconP2.y = iconPosY + iconBopIntensity / 2;
    //scoreTxt.antialiasing = ClientPrefs.data.antialiasing;
    scoreTxt.size = 18;
    scoreTxt.fieldWidth = 200;
    scoreTxt.x = FlxG.width - 200;
    scoreTxt.y = FlxG.height / 2;
    scoreTxt.alignment = "left";
    timeTxt.size = 18;
    timeTxt.y += -10; //14
}
function onBeatHit() {
    iconP1.scale.set(1,1);
    iconP2.scale.set(1,1);

    if (curBeat % 2 == 0) {
        iconP1.y = iconPosY - iconBopIntensity;
        iconP2.y = iconPosY + iconBopIntensity;
    }
    else {
        iconP1.y = iconPosY + iconBopIntensity;
        iconP2.y = iconPosY - iconBopIntensity;
    }
    
}
//stop bopping
function onUpdateScore() {
    if(!ClientPrefs.data.scoreZoom)
        return;

    if(scoreTxtTween != null)
        scoreTxtTween.cancel();
    
    scoreTxt.scale.x = 1;
    scoreTxt.scale.y = 1;

    var str:String = Language.getPhrase('rating_$ratingName', ratingName);
    if(totalPlayed != 0)
    {
        str = Language.getPhrase(ratingFC);
    }

    var tempScore:String;
    if(!instakillOnMiss) tempScore = Language.getPhrase('score_text', '{1} Score\n{2} Misses\n{3}% Accuracy\n{4} Rating', [songScore, songMisses, CoolUtil.floorDecimal(ratingPercent * 100, 2), str]);
    //else tempScore = Language.getPhrase('score_text_instakill', 'Score: {1} | Rating: {2}', [songScore, str]);
    scoreTxt.text = tempScore;
}

function onUpdatePost() {
    if (!paused && updateTime)
    {
        var curTime:Float = Math.max(0, Conductor.songPosition - ClientPrefs.data.noteOffset);
        songPercent = (curTime / songLength);

        var songCalc:Float = (songLength - curTime);
        if(ClientPrefs.data.timeBarType == 'Time Elapsed') songCalc = curTime;

        var secondsTotal:Int = Math.floor(songCalc / 1000);
        if(secondsTotal < 0) secondsTotal = 0;

        if(ClientPrefs.data.timeBarType != 'Song Name')
            timeTxt.text = "Time: " + FlxStringUtil.formatTime(secondsTotal, false);
    }
}