import openfl.filters.ShaderFilter;
var path:String = "stages/zombie/";
var bg:FlxSprite;

var colorShaderBfGf;
var colorShaderZombie;

function onCreatePost()
{	
	bg = new FlxSprite(-960, -500).loadGraphic(Paths.image(path + "bg"));
	bg.scrollFactor.set(0.9,0.9);
	bg.scale.set(0.9, 0.9);
	bg.updateHitbox();
	game.addBehindGF(bg);
	bg.antialiasing = ClientPrefs.data.antialiasing;
	
	colorShaderBfGf = game.createRuntimeShader('adjustColor');
	colorShaderBfGf.setFloat('brightness', -30);
	colorShaderBfGf.setFloat('contrast', -22);
	colorShaderBfGf.setFloat('saturation', -41);
	colorShaderBfGf.setFloat('hue', -23);
	boyfriend.shader = colorShaderBfGf;
    gf.shader = colorShaderBfGf;

	colorShaderZombie = game.createRuntimeShader('adjustColor');
	colorShaderZombie.setFloat('brightness', -12);
	colorShaderZombie.setFloat('contrast', 3);
	colorShaderZombie.setFloat('saturation', -46);
	colorShaderZombie.setFloat('hue', 40);
	dad.shader = colorShaderZombie;
}
