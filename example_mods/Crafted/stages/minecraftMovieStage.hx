import flixel.util.FlxTimer;
import openfl.filters.ShaderFilter;
var path:String = "stages/minecraftMovie/";
var bg:FlxSprite;


function onCreatePost()
{	
	bg = new FlxSprite(-1150, -820).loadGraphic(Paths.image(path + "bg"));
	bg.scrollFactor.set(0.9,0.9);
	bg.scale.set(1, 1);
	bg.updateHitbox();
	game.addBehindGF(bg);
	bg.antialiasing = ClientPrefs.data.antialiasing;
}

function onStepHit()
{
    // Code here
    if (curStep == 10) {
        
    }
}

