import flixel.util.FlxTimer;
import openfl.filters.ShaderFilter;
import psychlua.LuaUtils;
var path:String = "stages/alex/";
var bg:FlxSprite;
var bg3d:FlxSprite;

var brightness:FlxSprite;
var darkness:FlxSprite;

var brightnessTwn:FlxTween;
var darknessTwn:FlxTween;

var colorShaderBfGf;
var colorShaderZombie;

var dadOriginalPos = [0, 0];
var gfOriginalPos = [0, 0];
var bfOriginalPos = [0, 0];

function onCreatePost()
{
	bg = new FlxSprite(-960, -500).loadGraphic(Paths.image(path + "bg"));
	bg.scrollFactor.set(0.9,0.9);
	bg.scale.set(0.9, 0.9);
	bg.updateHitbox();
	addBehindGF(bg);
	bg.antialiasing = ClientPrefs.data.antialiasing;

    bg3d = new FlxSprite(0, 0).loadGraphic(Paths.image(path + "bg3d"));
	bg3d.scrollFactor.set(1, 1);
	bg3d.scale.set(1, 1);
	bg3d.updateHitbox();
	addBehindGF(bg3d);
	bg3d.antialiasing = false;
    bg3d.alpha = 0;

    brightness = new FlxSprite(-1000, -1000).makeGraphic(3000, 3000, 0xFFfaf9de);
    brightness.scrollFactor.set(0, 0);
    brightness.blend = 0;
    brightness.alpha = 0;
    brightness.antialiasing = ClientPrefs.data.antialiasing;
    brightness.updateHitbox();
    addBehindGF(brightness);
    //setOnScripts("brightness", brightness);

    darkness = new FlxSprite(-1000, -1000).makeGraphic(3000, 3000, 0xFF240b11);
    darkness.scrollFactor.set(0, 0);
    darkness.blend = 9; //MULTIPLY
    darkness.alpha = 0;
    darkness.antialiasing = ClientPrefs.data.antialiasing;
    darkness.updateHitbox();
    addBehindGF(darkness);

	
	colorShaderBfGf = game.createRuntimeShader('adjustColor');
	colorShaderBfGf.setFloat('brightness', 0);
	colorShaderBfGf.setFloat('contrast', 0);
	colorShaderBfGf.setFloat('saturation', 0);
	colorShaderBfGf.setFloat('hue', 0);
	boyfriend.shader = colorShaderBfGf;
    gf.shader = colorShaderBfGf;

	colorShaderZombie = game.createRuntimeShader('adjustColor');
	colorShaderZombie.setFloat('brightness', 0);
	colorShaderZombie.setFloat('contrast', 0);
	colorShaderZombie.setFloat('saturation', 0);
	colorShaderZombie.setFloat('hue',   0);
	dad.shader = colorShaderZombie;

    addCharacterToList("alex3d", 1);
    addCharacterToList("gf3d", 2);
    addCharacterToList("bf3d", 0);
    
    dadOriginalPos[0] = dadGroup.x;
    dadOriginalPos[1] = dadGroup.y;
    gfOriginalPos[0] = gfGroup.x;
    gfOriginalPos[1] = gfGroup.y;
    bfOriginalPos[0] = boyfriendGroup.x;
    bfOriginalPos[1] = boyfriendGroup.y;

    
    //setOnScripts("changeStageTo3d", function() {changeStageTo3dFunc();});
    //setOnScripts("changeStageTo2d", function() {changeStageTo2dFunc();});
    /*
    setOnScripts("doDarknessTwn", function(amount:Float, duration:Float, easeType:FlxEase) {doDarknessTwnFunc(amount, duration, easeType);});
    */
    //setOnScripts("doBrightnessTwn", function(amount:Float, duration:Float, easeType:FlxEase) {doBrightnessTwnFunc(amount, duration, easeType);});
}


function changeStageTo3d()
{
    bg3d.alpha = 1;
    triggerEvent("Change Character", "dad", "alex3d");
    triggerEvent("Change Character", "gf", "gf3d");
    triggerEvent("Change Character", "bf", "bf3d");
    
    dadGroup.x = 230;
    dadGroup.y = -205;
    gfGroup.x = 125;
    gfGroup.y = -200;
    gfGroup.scrollFactor.set(1, 1);
    boyfriendGroup.x = 630;
    boyfriendGroup.y = -220;
    
    //nc_reloadTargets();
    triggerEvent("nc_reload_targets", "", "");

    //fixes incorrect opponent camera offsets
    //nc_reloadTargets() doesn't work properly for some reason
    nc_set_target("opp", 500, 370); 
}

function changeStageTo2d()
{
    bg3d.alpha = 0;
    triggerEvent("Change Character", "dad", PlayState.SONG.player2);
    triggerEvent("Change Character", "gf", PlayState.SONG.gfVersion);
    triggerEvent("Change Character", "bf", PlayState.SONG.player1);
    
    dadGroup.x = dadOriginalPos[0];
    dadGroup.y = dadOriginalPos[1];
    gfGroup.x = gfOriginalPos[0];
    gfGroup.y = gfOriginalPos[1];
    gfGroup.scrollFactor.set(0.95, 0.95);
    boyfriendGroup.x = bfOriginalPos[0];
    boyfriendGroup.y = bfOriginalPos[1];

    //nc_reloadTargets();
    triggerEvent("nc_reload_targets", "", "");
}

function doDarknessTwn(amount:Float, duration:Float, easeType:FlxEase) {
    if (darknessTwn != null) darknessTwn.cancel();
    if (amount != 0)
        darknessTwn = FlxTween.tween(darkness, { alpha:amount }, duration, { ease: easeType });
    else
        darkness.alpha = amount;
}

function doBrightnessTwn(amount:Float, duration:Float, easeType:FlxEase) {
    if (brightnessTwn != null) brightnessTwn.cancel();
    if (amount != 0)
        brightnessTwn = FlxTween.tween(brightness, { alpha:amount }, duration, { ease: easeType });
    else
        brightness.alpha = amount;
}

function onEvent(ev:String, v1:String, v2:String, time:Float){
    switch ev {
        case "changeStageTo3d":
            changeStageTo3d();
        case "changeStageTo2d":
            changeStageTo2d();
        case "darknessTwn", "brightnessTwn":
            //Thx data5 (taken from Hello John Doe)
            var values;
            var amount = Std.parseFloat(v1);
            var duration = 0;
            var easeType = FlxEase.linear;
            if (v2 != null && v2 != "") {
                values = v2.split(",");
                duration = Std.parseFloat(values[0]); 
                if (Math.isNaN(duration)) duration = 0;
                easeType = LuaUtils.getTweenEaseByString(values[1]);
            }
            if (ev == "darknessTwn")
                doDarknessTwn(amount, duration, easeType);
            else
                doBrightnessTwn(amount, duration, easeType);
    }

}