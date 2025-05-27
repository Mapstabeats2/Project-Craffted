//DEBUG FOR SONG CHARTING AND EVENT PLACING

//===========INSTRUCTIONS===========
/*
Press B to toggle botplay

Press [ to rewind song time to deltaSecs
Press [ to forward song time to deltaSecs

Use numpad to input your step position
Press numpad period to set song time to your step position
*/

//Made by CheesyCap



//CHANGE YOUR VARIABLES HERE
var deltaSecs:Float = 3;
var stepOffsetSecs:Float = 0;

//
import backend.MusicBeatState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.text.FlxText;
import flixel.text.FlxTextBorderStyle;

var songDataTxt:FlxText;
var toStep:Array<Int> = [];

var isChartingMode:Bool = false;

function onCreatePost() {
    isChartingMode = PlayState.chartingMode;
    if (isChartingMode) {
        songDataTxt = new FlxText(15, FlxG.height - 100, 500, 
            "curTime:\n" +
            "curSection:\n" +
            "curBeat:\n" +
            "curStep:\n"
            , 15);
        songDataTxt.setFormat(songDataTxt.font, 15, FlxColor.WHITE, FlxTextAlign = "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        songDataTxt.borderSize = 1.25;
        songDataTxt.updateHitbox();
        songDataTxt.cameras = [camOther];
        add(songDataTxt);
    }
}

function onUpdatePost() {
    if (isChartingMode) {
        songDataTxt.text =
            "curTime: " + Std.int(Conductor.songPosition / 10) / 100 + "\n" +
            "curSection: " + curSection + "\n" +
            "curBeat: " + curBeat + "\n" +
            "curStep: " + curStep + "\n";
    }

    if (FlxG.keys.justPressed.B) {
        PlayState.instance.cpuControlled = !PlayState.instance.cpuControlled;
        PlayState.changedDifficulty = true;
        PlayState.instance.botplayTxt.visible = PlayState.instance.cpuControlled;
        PlayState.instance.botplayTxt.alpha = 1;
        PlayState.instance.botplaySine = 0;
    
        ClientPrefs.data.gameplaySettings.set('botplay', !ClientPrefs.getGameplaySetting('botplay'));
        ClientPrefs.saveSettings();
    }
    

    if (FlxG.keys.justPressed.LBRACKET) {
        var newTime:Float = Conductor.songPosition - deltaSecs * 1000;
        PlayState.startOnTime = newTime;
        restartSong(true);
    }
    else if (FlxG.keys.justPressed.RBRACKET) {
        var newTime:Float = Conductor.songPosition + deltaSecs * 1000;
        PlayState.instance.clearNotesBefore(newTime);
        PlayState.instance.setSongTime(newTime);
    }



    if (FlxG.keys.justPressed.NUMPADONE) {
        toStep.push(1);
        debugPrint(convert());
    }
    if (FlxG.keys.justPressed.NUMPADTWO) {
        toStep.push(2);
        debugPrint(convert());
    }
    if (FlxG.keys.justPressed.NUMPADTHREE) {
        toStep.push(3);
        debugPrint(convert());
    }
    if (FlxG.keys.justPressed.NUMPADFOUR) {
        toStep.push(4);
        debugPrint(convert());
    }
    if (FlxG.keys.justPressed.NUMPADFIVE) {
        toStep.push(5);
        debugPrint(convert());
    }
    if (FlxG.keys.justPressed.NUMPADSIX) {
        toStep.push(6);
        debugPrint(convert());
    }
    if (FlxG.keys.justPressed.NUMPADSEVEN) {
        toStep.push(7);
        debugPrint(convert());
    }
    if (FlxG.keys.justPressed.NUMPADEIGHT) {
        toStep.push(8);
        debugPrint(convert());
    }
    if (FlxG.keys.justPressed.NUMPADNINE) {
        toStep.push(9);
        debugPrint(convert());
    }
    if (FlxG.keys.justPressed.NUMPADZERO) {
        toStep.push(0);
        debugPrint(convert());
    }

    if (FlxG.keys.justPressed.NUMPADPERIOD) {
        var step:Int = convert();
        var curTime:Float = 1000 * 60 * step / (Conductor.bpm * 4) - stepOffsetSecs;
        debugPrint(curTime / 1000 + "secs");
        toStep = [];

        if(curTime < Conductor.songPosition)
        {
            PlayState.startOnTime = curTime;
            restartSong(true);
        }
        else
        {
            if (curTime != Conductor.songPosition)
            {
                PlayState.instance.clearNotesBefore(curTime);
                PlayState.instance.setSongTime(curTime);
            }
        }
    } 
}

function convert() {
    var value:Int = 0;
    for (i in 0...toStep.length) {
        value += Math.pow(10, toStep.length - i - 1) * toStep[i];
    }
    return value;
}

function restartSong(noTrans:Bool = false){
    PlayState.instance.paused = true; // For lua
    FlxG.sound.music.volume = 0;
    PlayState.instance.vocals.volume = 0;
    
    if(noTrans) {
        FlxTransitionableState.skipNextTransIn = true;
        FlxTransitionableState.skipNextTransOut = true;
    }
    MusicBeatState.resetState();
}