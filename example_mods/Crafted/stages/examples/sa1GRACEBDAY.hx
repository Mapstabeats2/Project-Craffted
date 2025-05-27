import openfl.filters.ShaderFilter;
import flixel.text.FlxText;
import flixel.util.FlxGradient;

var bfBasePos = [];
var tBar;
var bBar;


var dadShadow;
var bfShadow;

var shader;

var customFocus = null;

var bgStuff = [];

var counter = new FlxText(0,0,FlxG.width,'',24);

function onCreatePost() {
	game.showCombo = false;
	game.showRating = false;
	game.showComboNum = false;
	for (i in [game.timeBar,game.timeTxt])
		i.visible = false;



	function makeBG(x:Float,y:Float,anim:String)
	{
		var spr = new FlxSprite(x,y);
		spr.frames = Paths.getSparrowAtlas('bg');
		spr.animation.addByPrefix(anim,anim);
		spr.animation.play(anim);
		spr.active = false;
		spr.updateHitbox();
		spr.antialiasing = ClientPrefs.data.antialiasing;

		return spr;
	}
	

	var bg = makeBG(-1000, -700,'sky');
	game.addBehindDad(bg);
	bg.scale.set(1.5, 1.5);
	bg.updateHitbox();
	bg.scrollFactor.set(0.5,0.5);
	bgStuff.push(bg);

	var bg = makeBG(-1000, -700,'sun');
	game.addBehindDad(bg);
	bg.scale.set(1.5, 1.5);
	bg.updateHitbox();
	bg.scrollFactor.set(0.65,0.65);
	bgStuff.push(bg);


	var bg = makeBG(-1000, -700,'mountains');
	game.addBehindDad(bg);
	bg.scale.set(1.5, 1.5);
	bg.updateHitbox();
	bg.scrollFactor.set(0.75,0.9);
	bgStuff.push(bg);

	
	var bg = makeBG(-1000, -700,'water');
	game.addBehindDad(bg);
	bg.scale.set(1.5, 1.5);
	bg.updateHitbox();
	bgStuff.push(bg);

	shader = game.createRuntimeShader('water');
	if (ClientPrefs.data.shaders)
	{
		bg.shader = shader;
	}

	var bg = makeBG(-1000, -700,'beach');
	game.addBehindDad(bg);
	bg.scale.set(1.5, 1.5);
	bg.updateHitbox();
	bgStuff.push(bg);

    tBar = new FlxSprite(0,-75).makeGraphic(1,1,0xFF0F142B);
    tBar.setGraphicSize(FlxG.width,75);
    tBar.updateHitbox();
    addBehindDad(tBar);
    tBar.cameras = [game.camHUD];
    tBar.blend = 14;

    bBar = new FlxSprite(0,FlxG.height).makeGraphic(1,1,0xFF0F142B);
    bBar.setGraphicSize(FlxG.width,75);
    bBar.updateHitbox();
    addBehindDad(bBar);
    bBar.cameras = [game.camHUD];
    bBar.blend = 14;



    dadShadow = new Character(game.dad.x, game.dad.y + game.dad.height, game.dad.curCharacter, game.dad.isPlayer);
	dadShadow.color = FlxColor.BLACK;
	addBehindDad(dadShadow);
	dadShadow.flipY = true;
	dadShadow.alpha = 0.05;
	
	bfShadow = new Character(game.boyfriend.x, game.boyfriend.y  + game.boyfriend.height - 50, game.boyfriend.curCharacter, game.boyfriend.isPlayer);
	bfShadow.color = FlxColor.BLACK;
	addBehindBF(bfShadow);
	bfShadow.flipY = true;
	bfShadow.alpha = 0.05;


	var overlay = new FlxSprite().loadGraphic(Paths.image('lensflare'));
	overlay.setGraphicSize(bg.width);
	overlay.updateHitbox();
	overlay.setPosition(bg.x,bg.y - 200);
	overlay.flipX = true;
	overlay.angle = -30;
	// overlay.blend = 0;
	// overlay.alpha = 0.6;
	add(overlay);
	overlay.scrollFactor.set(1.5,1.5);
	bgStuff.push(overlay);


	// intro shit
	game.camHUD.alpha = 0;
	game.isCameraOnForcedPos = true;
	game.camFollow.setPosition(bg.getMidpoint().x - 100, bg.y + 300);
	FlxG.camera.zoom = 1.5;
	FlxG.camera.snapToTarget();
	FlxG.camera._fxFadeAlpha = 1;
	FlxG.camera._fxFadeColor = FlxColor.WHITE;
	bfBasePos = [game.boyfriend.x, game.boyfriend.y];

    // shader = game.createRuntimeShader('perspecitve');
    // bloomShader.setFloat('bloom',0.1);
    // FlxG.camera.filters = [new ShaderFilter(shader)];

	add(counter);
	counter.cameras = [game.camOther];
	counter.font = game.scoreTxt.font;
	counter.alignment = 'center';
	counter.y = (FlxG.height - counter.size) /2;


	game.updateIconsScale = (elapsed)->{
		var mult:Float = FlxMath.lerp(0.8, game.iconP1.scale.x, Math.exp(-elapsed * 9 * playbackRate));
		game.iconP1.scale.set(mult, mult);
		game.iconP1.updateHitbox();

		var mult:Float = FlxMath.lerp(0.8, game.iconP2.scale.x, Math.exp(-elapsed * 9 * playbackRate));
		game.iconP2.scale.set(mult, mult);
		game.iconP2.updateHitbox();
	}

	game.updateIconsPosition = ()->{
		var iconOffset:Int = 13;
		game.iconP1.x = game.healthBar.barCenter + (150 * game.iconP1.scale.x - 150) / 2 - iconOffset + 25;
		game.iconP2.x = game.healthBar.barCenter - (150 * game.iconP2.scale.x) / 2 - iconOffset * 2 - 25;
	}
    


}

function onBeatHit()
{
	game.iconP1.scale.set(1, 1);
	game.iconP2.scale.set(1, 1);
	game.iconP1.updateHitbox();
	game.iconP2.updateHitbox();
}

function onCountdownTick(tick, thign) {
	if (game.countdownReady != null)
		game.countdownReady.cameras = [game.camOther];
	if (game.countdownSet != null)
		game.countdownSet.cameras = [game.camOther];
	if (game.countdownGo != null)
		game.countdownGo.cameras = [game.camOther];
}

function onSongStart() {

	FlxTween.tween(FlxG.camera, {_fxFadeAlpha: 0}, 2.4 * 1.5, {ease: FlxEase.sineInOut});

	new FlxTimer().start(2.4, (timer) -> {
		var currentPos = [game.camFollow.x, game.camFollow.y];
		game.moveCameraSection();
		var nextPos = [game.camFollow.x, game.camFollow.y];
		game.camFollow.setPosition(currentPos[0], currentPos[1]);

		FlxTween.tween(FlxG.camera, {zoom: game.defaultCamZoom - 0.025}, 2.4 * 2 - 0.3, {startDelay: 0.3, ease: FlxEase.sineInOut});

		function go() {
			FlxTween.tween(FlxG.camera, {zoom: game.defaultCamZoom}, 2.4 / 2, {startDelay: 0.3, ease: FlxEase.sineInOut});

			FlxTween.tween(game.camHUD, {alpha: 1}, 2.4 / 2, {ease: FlxEase.sineInOut});

            FlxTween.tween(bBar,{y: FlxG.height - bBar.height},2.4 / 2, {ease: FlxEase.cubeInOut});
            FlxTween.tween(tBar,{y: 0},2.4 / 2, {ease: FlxEase.cubeInOut});

			FlxTween.tween(game.camFollow, {y: nextPos[1]}, 2.4 / 2, {
				ease: FlxEase.sineIn,
				onComplete: Void -> {
					game.isCameraOnForcedPos = false;
				}
			});
		}
		FlxTween.tween(game.camFollow, {y: nextPos[1] + 25}, 2.4 * 2, {ease: FlxEase.sineInOut, onComplete: go});
	});
}

function noteMiss(note) {
	triggerHurt();
}

var finishedShake:Bool = false;
var shakeTimer:Float = 0;
var colorTween:FlxTween = null;

function triggerHurt() {
	game.boyfriend.color = 0xFFA875A3;
	if (colorTween != null)
		colorTween.cancel();
	colorTween = FlxTween.color(game.boyfriend, 0.3, 0xFFA875A3, FlxColor.WHITE);

	finishedShake = false;
	shakeTimer = 0.05;
}

function handleMissShake(e) {
	if (shakeTimer > 0) {
		shakeTimer -= e;

		game.boyfriend.x = bfBasePos[0] + FlxG.random.float(-0.01 * game.boyfriend.width, 0.01 * game.boyfriend.width);
		game.boyfriend.y = bfBasePos[1] + FlxG.random.float(-0.01 * game.boyfriend.height, 0.01 * game.boyfriend.height);
	} else {
		if (!finishedShake) {
			finishedShake = true;
			game.boyfriend.x = bfBasePos[0];
			game.boyfriend.y = bfBasePos[1];
		}
	}
}

var time = 0;
function onUpdatePost(e) {
	handleMissShake(e);

	time += e;
	shader.setFloat('iTime',time);

	if (!game.isCameraOnForcedPos) {


        if (game.curSection > 0)
        {
            moveCamera(!mustHitSection);
        }
	}


    copyAnims(dadShadow,dad);
    copyAnims(bfShadow,boyfriend);
    
}

function onEvent(ev, v1, v2, time) {
    if (ev == 'Change Zoom')
    {
        var newZoom = Std.parseFloat(v1);
        if (Math.isNaN(newZoom)) newZoom = 0.5;
        game.defaultCamZoom = newZoom;
    }
	if (ev == 'Change Focus') {
        customFocus = v1 == 'dad' ? game.dad : game.boyfriend;
	}

	if (ev == '')
	{
		switch(v1)
		{
			case 'zoomOut':

				function fixZoom()
					{
						onEvent('Change Zoom',Std.string(FlxG.camera.zoom),'',0);
					}

				FlxTween.tween(FlxG.camera,{zoom: 0.45,_fxFadeAlpha: 1},171 - 168, {onUpdate: fixZoom, onComplete: fixZoom});
			case 'subs':
				counter.y = FlxG.height - counter.height - 100;
				counter.text = v2;
			case 'theEnd':
				FlxTween.tween(game.camHUD,{alpha: 0},(160.8 - 158.4) * 2);

				// FlxTween.tween(FlxG.camera, {_fxFadeAlpha: 1},171 - 158.4);
				for (i in bgStuff)
					{
						FlxTween.color(i,171 - 158.4,FlxColor.WHITE,FlxColor.GRAY);
					}

			case 'zoomInFade':
				FlxG.camera._fxFadeColor = FlxColor.BLACK;
				FlxTween.tween(FlxG.camera,{_fxFadeAlpha: 1,zoom: 0.65},127.24 - 123.88, {onUpdate: Void->{
					onEvent('Change Zoom',Std.string(FlxG.camera.zoom),'',0);
				}});
				FlxTween.tween(game.camHUD,{alpha: 0},127.24 - 123.88);

				

			case 'fadeOut':
				for (i in bgStuff)
				{
					FlxTween.color(i,121 - 113,FlxColor.WHITE,FlxColor.GRAY);
				}

			case 'one':
				counter.text = 'one';

			case 'two':
				counter.text = 'two';


			case 'three':
				counter.text = 'three';


			case 'fadeBack':
				counter.text = '';
				
				for (i in bgStuff)
					{
						i.color = FlxColor.WHITE;
					}

				function fixZoom()
				{
					onEvent('Change Zoom',Std.string(FlxG.camera.zoom),'',0);
				}

				FlxTween.tween(game.camHUD,{alpha: 1},0.3);

				FlxTween.tween(FlxG.camera,{_fxFadeAlpha: 0,zoom: 0.5},0.3, {onUpdate: fixZoom, onComplete: fixZoom});
		}
	}

	if (ev == '' && v1 == 'zoomInFade')
	{

	}
	if (ev == '' && v1 == 'fadeOut')
	{

	}
}

var lerpTween:FlxTween = null;

function onMoveCamera(char) {
	if (game.curBeat >= 16) {
		if (lerpTween != null)
			lerpTween.cancel();
		game.cameraSpeed = 0;
		lerpTween = FlxTween.num(game.cameraSpeed, 1, 0.75, {ease: FlxEase.cubeIn}, (f) -> game.cameraSpeed = f);
	}
    customFocus = null;
}


function moveCamera(isDad:Bool)
{
    if (customFocus != null) customFocus = game.dad ? isDad = true : isDad = false;
    if(isDad)
    {
        if(game.dad == null) return;
        game.camFollow.setPosition(game.dad.getMidpoint().x + 150, game.dad.getMidpoint().y - 100);
        game.camFollow.x += game.dad.cameraPosition[0] + game.opponentCameraOffset[0];
        game.camFollow.y += game.dad.cameraPosition[1] + game.opponentCameraOffset[1];
    }
    else
    {
        if(game.boyfriend == null) return;
        game.camFollow.setPosition(game.boyfriend.getMidpoint().x - 100, game.boyfriend.getMidpoint().y - 100);
        game.camFollow.x -= game.boyfriend.cameraPosition[0] - game.boyfriendCameraOffset[0];
        game.camFollow.y += game.boyfriend.cameraPosition[1] + game.boyfriendCameraOffset[1];

    }

    var char = isDad ? game.dad : game.boyfriend;

    var offsetX = getCharOffset(char,true);
    var offsetY = getCharOffset(char,false);

    var nextAngle = offsetX == 10 ? -1 : offsetX == -10 ? 1 : 0;
    if (getVar('setLerpAngle') != null)
    {
        getVar('setLerpAngle')(nextAngle);
    }


    game.camFollow.x += offsetX;
    game.camFollow.y += offsetY;

}

function getCharOffset(char:Character,x:Bool)
{
    if (char == null || char.isAnimationNull()) return 0;

    return switch (char.getAnimationName().substr(4).split('-')[0].toLowerCase())
    {
        case 'up': return x ? 0 : -10;
        case 'down': return x ? 0 : 10;
        case 'left': return x ? -10 : 10;
        case 'right': return x ? 10 : 10;
        case _: return 0;
    }
}

function copyAnims(char,copy)
{
    char.playAnim(copy.getAnimationName(),true,false,copy.animation.curAnim.curFrame);
}