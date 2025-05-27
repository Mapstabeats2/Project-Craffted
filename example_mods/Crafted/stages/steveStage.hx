import openfl.filters.ShaderFilter;

// If you're moving your stage from PlayState to a stage file,
// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming
var path:String = "stages/steve/";
//minimum zoom = 0.5
var sky:FlxSprite;
var clouds:FlxSprite;
var clouds2:FlxSprite;
var under:FlxSprite;
var back:FlxSprite;
var front:FlxSprite;
var add:FlxSprite;

var colorShader;
var colorShaderSky;


var loadingObjs = [];

function onCreate()
{
	// Spawn your stage sprites here.
	// Characters are not ready yet on this function, so you can't add things above them yet.
	// Use createPost() if that's what you want to do.
	
}

function onCreatePost()
{
	// Use this function to layer things above characters!
	sky = new FlxSprite(-900, -240).loadGraphic(Paths.image(path + "sky"));
	sky.scrollFactor.set(0, 0);
	sky.scale.set(0.8, 0.8);
	sky.updateHitbox();
	game.addBehindGF(sky);
	sky.antialiasing = ClientPrefs.data.antialiasing;
	
	
	clouds = new FlxSprite(-680, -280).loadGraphic(Paths.image(path + "clouds"));
	clouds.scrollFactor.set(0.1, 0.1);
	clouds.scale.set(0.8, 0.8);
	clouds.velocity.set(30, 0);
	clouds.updateHitbox();
	game.addBehindGF(clouds);
	loadingObjs.push(clouds);
	clouds.antialiasing = ClientPrefs.data.antialiasing;
	clouds2 = new FlxSprite(-680 - 2200, -280).loadGraphic(Paths.image(path + "clouds"));
	clouds2.scrollFactor.set(0.1, 0.1);
	clouds2.scale.set(0.8, 0.8);
	clouds2.velocity.set(30, 0);
	clouds2.updateHitbox();
	game.addBehindGF(clouds2);
	clouds2.antialiasing = ClientPrefs.data.antialiasing;
	loadingObjs.push(clouds2);
	
	under = new FlxSprite(-700, -400).loadGraphic(Paths.image(path + "under"));
	under.scrollFactor.set(0.2,0.2);
	under.scale.set(0.8, 0.8);
	under.updateHitbox();
	game.addBehindGF(under);
	under.antialiasing = ClientPrefs.data.antialiasing;
	loadingObjs.push(under);
	
	back = new FlxSprite(-880, -400).loadGraphic(Paths.image(path + "back"));
	back.scrollFactor.set(0.35,0.35);
	back.scale.set(0.9, 0.9);
	back.updateHitbox();
	game.addBehindGF(back);
	back.antialiasing = ClientPrefs.data.antialiasing;
	loadingObjs.push(back);
	
	front = new FlxSprite(-1000, -600).loadGraphic(Paths.image(path + "front"));
	front.scrollFactor.set(0.95,0.95);
	front.scale.set(1, 1);
	front.updateHitbox();
	game.addBehindGF(front);
	front.antialiasing = ClientPrefs.data.antialiasing;
	loadingObjs.push(front);

	
	add = new FlxSprite(0, 0).loadGraphic(Paths.image(path + "add"));
	add.scrollFactor.set(0, 0);
	add.scale.set(2/3, 2/3);
	add.blend = "add";
	add.cameras = [camHUD];
	add.updateHitbox();
	add(add);

	loadingObjs.push(boyfriendGroup);
	loadingObjs.push(gfGroup);
	loadingObjs.push(dadGroup);
	loadingObjs.push(boyfriend);
	loadingObjs.push(gf);
	loadingObjs.push(dad);
	
	for (i in loadingObjs) {
	    i.alpha = 0;
	}
	colorShader = game.createRuntimeShader('adjustColor');
	colorShader.setFloat('brightness', 0);
	colorShader.setFloat('contrast', 0);
	colorShader.setFloat('saturation', 0);
	colorShader.setFloat('hue', 0);
	for (i in loadingObjs) {
		i.shader = colorShader;
	}

	colorShaderSky = game.createRuntimeShader('adjustColor');
	colorShaderSky.setFloat('brightness', 0);
	colorShaderSky.setFloat('contrast', 0);
	colorShaderSky.setFloat('saturation', 0);
	colorShaderSky.setFloat('hue', 0);
	sky.shader = colorShaderSky;
}


var loadTime:Float = 0.7;
var elapsedTime:Float = 0;
function onUpdate(elapsed:Float)
{
	// Code here
	
	
	if (elapsedTime <= loadTime) {
	    elapsedTime += elapsed;
	    for (i in 0...loadingObjs.length) {
            if (loadingObjs[loadingObjs.length - 1 - i].alpha != 1 && elapsedTime > loadTime * (i + 1) / loadingObjs.length){
                loadingObjs[loadingObjs.length - 1 - i].alpha = 1;
            }
	    

    	}
	}
	
}



// Steps, Beats and Sections:
//    curStep, curDecStep
//    curBeat, curDecBeat
//    curSection
function onStepHit()
{
	// Code here
	if (curStep == 256) {
		colorShader.setFloat('brightness', -63);
        colorShader.setFloat('contrast', -26);
        colorShader.setFloat('saturation', -36);
        colorShader.setFloat('hue', -47);

		colorShaderSky.setFloat('brightness', -100);
        colorShaderSky.setFloat('contrast', -83);
        colorShaderSky.setFloat('saturation', 32);
        colorShaderSky.setFloat('hue', 171);
	}
	else if (curStep == 384) {
		colorShader.setFloat('brightness', 0);
        colorShader.setFloat('contrast', 0);
        colorShader.setFloat('saturation', 0);
        colorShader.setFloat('hue', 0);

		colorShaderSky.setFloat('brightness', 0);
        colorShaderSky.setFloat('contrast', 0);
        colorShaderSky.setFloat('saturation', 0);
        colorShaderSky.setFloat('hue', 0);
	}
}
function onBeatHit()
{
	// Code here
	if (clouds.x > -680 + 2200)
	{
		clouds.x -= 2200 * 2;
	}
	if (clouds2.x > -680 + 2200)
	{
		clouds2.x -= 2200 * 2;
	}
}


/*
function onDestroy()
{
	// Code here
}

function onStartSong()
{
	// Code here
}

function onSectionHit()
{
	// Code here
}

// Substates for pausing/resuming tweens and timers
function onCloseSubState()
{
	if(paused)
	{
		//timer.active = true;
		//tween.active = true;
	}
}

function onOpenSubState(SubState:flixel.FlxSubState)
{
	if(paused)
	{
		//timer.active = false;
		//tween.active = false;
	}
}

// For events
function onEventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
{
	switch(eventName)
	{
		case "My Event":
	}
}
function onEventPushed(event:objects.Note.EventNote)
{
	// used for preloading assets used on events that doesn't need different assets based on its values
	switch(event.event)
	{
		case "My Event":
			//precacheImage('myImage') //preloads images/myImage.png
			//precacheSound('mySound') //preloads sounds/mySound.ogg
			//precacheMusic('myMusic') //preloads music/myMusic.ogg
	}
}
function onEventPushedUnique(event:objects.Note.EventNote)
{
	// used for preloading assets used on events where its values affect what assets should be preloaded
	switch(event.event)
	{
		case "My Event":
			switch(event.value1)
			{
				// If value 1 is "blah blah", it will preload these assets:
				case 'blah blah':
					//precacheImage('myImageOne') //preloads images/myImageOne.png
					//precacheSound('mySoundOne') //preloads sounds/mySoundOne.ogg
					//precacheMusic('myMusicOne') //preloads music/myMusicOne.ogg

				// If value 1 is "coolswag", it will preload these assets:
				case 'coolswag':
					//precacheImage('myImageTwo') //preloads images/myImageTwo.png
					//precacheSound('mySoundTwo') //preloads sounds/mySoundTwo.ogg
					//precacheMusic('myMusicTwo') //preloads music/myMusicTwo.ogg
				
				// If value 1 is not "blah blah" or "coolswag", it will preload these assets:
				default:
					//precacheImage('myImageThree') //preloads images/myImageThree.png
					//precacheSound('mySoundThree') //preloads sounds/mySoundThree.ogg
					//precacheMusic('myMusicThree') //preloads music/myMusicThree.ogg
			}
	}
}

// Note Hit/Miss
function onGoodNoteHit(note:Note)
{
	// Code here
}

function onOpponentNoteHit(note:Note)
{
	// Code here
}

function onNoteMiss(note:Note)
{
	// Code here
}

function onNoteMissPress(direction:Int)
{
	// Code here
}
*/