import flixel.util.FlxTimer;
import openfl.filters.ShaderFilter;
var path:String = "stages/mojangLogo/";
var bg:FlxSprite;


function onCreatePost()
{	
	bg = new FlxSprite(-800, -500).loadGraphic(Paths.image(path + "bg"));
	bg.scrollFactor.set(0.2,0.2);
	bg.scale.set(1.5, 1.5);
	bg.updateHitbox();
	game.addBehindGF(bg);
	bg.antialiasing = ClientPrefs.data.antialiasing;

    gfGroup.scrollFactor.set(0.65, 0.65);
    //no 17bucks
    camGame.bgColor = FlxColor.BLACK;
}

function onStepHit()
{
    // Code here
    if (curStep == 10) {
        
    }
}

