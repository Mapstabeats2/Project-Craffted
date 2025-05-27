/**
Hi, my name is CheesyCap.
I borrowed some code from Psych Engine and base Friday Night Funkin' source codes, Miner's Haunt android optimization, 15LUKAS, and Untitled Goose Mod menu codes
Psych Engine: https://github.com/ShadowMario/FNF-PsychEngine/tree/main/source
Fridau Night Funkin': https://github.com/FunkinCrew/Funkin/tree/main/source
Miner's Haunt android optimization: https://youtu.be/krdizP7_rXg
Minet's Haunt: https://gamebanana.com/mods/568591
15LUKAS: https://gamebanana.com/mods/529487
Untitled Goose Mod: https://gamebanana.com/mods/398180

Tbh, it was pretty fun to code
**/

/**
	INFO:
	Minecraftles font minimal size: 9
**/

import backend.CoolUtil;
import backend.WeekData;
import backend.Highscore;
import backend.Song;
import backend.Mods;
import backend.MusicBeatState;
import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.sound.FlxSound;
import flixel.group.FlxTypedSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.util.FlxStringUtil;
import flixel.util.FlxSave;
import options.OptionsState;
import Reflect;
import tjson.TJSON;
using StringTools;

//DATA
typedef Render = {
	var name:String;
	var x:Int;
	var y:Int;
	var scale:Float;
}
typedef Song = {
	var name:String;
	var difficulty:Int;
	var info:String;
	var icon:String;
	var render:Render;
}
var songPath:String;
if (FileSystem.exists("mods/" + Mods.currentModDirectory + "/stages/customMenu/customMenuSongs.json") && Mods.currentModDirectory != null) {
	songPath = "mods/" + Mods.currentModDirectory + "/stages/customMenu/customMenuSongs.json";
}
else if (FileSystem.exists("mods/stages/customMenu/customMenuSongs.json")) {
	FlxG.stage.window.alert('Please, put the "Project Crafted" modpack inside of its own folder "mods/Project Crafted/" instead of "mods/" or the game may crash', "Modpack location warning!");
	songPath = "mods/stages/customMenu/customMenuSongs.json";
}
else {
	FlxG.stage.window.alert('Please, put the "Project Crafted" modpack inside of its own folder "mods/Project Crafted/" or the game may crash\nPress E if you get softlocked', "Modpack location warning!");
	songPath = Paths.getPath("stages/customMenu/customMenuSongs.json");
}
var songs:Array<Song> = TJSON.parse(File.getContent(songPath));

/**
	{
		name : "NPC",
		difficulty : 13,
		info : "CheesyCap",
		icon : "amoguspixel",
		render : {
			name : "ryan",
			x : -350,
			y : -700,
			scale : 0.24
		}
	}
**/

typedef SongButton = {
	var btn:FlxSprite;
	var name:FlxText;
	var info:FlxText;
	var icon:FlxSprite;
}

//BACKGROUND
var bgGroup:FlxTypedSpriteGroup<FlxSprite>;
//MAIN MENU
var mainGroup:FlxTypedSpriteGroup<FlxSprite>;
var mainItemsGroup:FlxTypedSpriteGroup<FlxSprite>;
var mainGroupTwn:FlxTween;
var mainTitle:FlxSprite;
var buttonPlay:FlxSprite;
var buttonPlayText:FlxText;
var buttonPlay2:FlxSprite;
var buttonPlay2Text:FlxText;
var buttonCredits:FlxSprite;
var buttonCreditsText:FlxText;
var buttonOptions:FlxSprite;
var buttonOptionsText:FlxText;
var buttonQuit:FlxSprite;
var buttonQuitText:FlxText;
//MAIN MENU LOGIC
var curMenu:Int = 0;
var mainMouseControls:Bool = false;
//FREEPLAY
var freeplayGroup:FlxTypedSpriteGroup<FlxSprite>;
var songsGroup:FlxTypedSpriteGroup<FlxSprite>;
var topFreeplay:FlxSprite;
var backFreeplay:FlxSprite;
var borderSongs:FlxSprite;
var borderInfo:FlxSprite;
var buttonPlay:FlxSprite;
var songInfoText:FlxText;
var songInfoTextS:FlxText;
var songInfoBorder:FlxSprite;

var songButtons:Array<FlxSprite> = [];
var songIcons:Array<FlxSprite> = [];

var render:FlxSprite;
var titleFreeplay:FlxSprite;
//FREEPLAY LOGIC
var curSong:Int = 0;
//FREEPLAY VISUAL STUFF
var freeplayGroupTwn:FlxTween;
var songBtnSpacing:Int = 100;
var songBtnDefaultPos:Int = 370;
var renderTwnX:FlxTween;
var renderTwnA:FlxTween;
var titleFreeplayY:Int = 100;
var titleTwnScale:FlxTween;
//FREEPLAY STARS
var starsGroup:FlxTypedSpriteGroup<FlxSprite>;
//FREEPLAY STARS VISUAL STUFF
var starY:Int = 200;
//SAVE
var nameSaveFile:String = "project_crafted_savedata";
var fieldSaveFileSongId:String = "rememberedSongId";


//LOGIC
var mainMenu:Bool = true;
var freeplay:Bool = false;
var pickedSong:Bool = false;

var path:String = "freeplay/";
var pathMenuScripts:String = "mods/" + Mods.currentModDirectory + "/stages/customMenu/";
FlxG.mouse.visible = true;



function onCreatePost() {
	//CAMERA
	game.camera.scroll.set(0, 0);
	triggerEvent("Camera Follow Pos", FlxG.width/2, FlxG.height/2);

	//OTHER
	game.skipCountdown = true;
	uiGroup.alpha = 0;


	
	//I tried FlxBackdrop. I felt it's unoptimized. So yeah.
	bgGroup = new FlxTypedSpriteGroup();
	add(bgGroup);
	for (i in 0...4) {
		bg0 = new FlxSprite(720 * i, 0).loadGraphic(Paths.image(path + "panorama/1.20_panorama_" + i));
		bg0.scale.set(720/1000, 720/1000);
		bg0.antialiasing = ClientPrefs.data.antialiasing;
		bg0.updateHitbox();
		bg0.velocity.x = -20;
		bgGroup.add(bg0);
	}

	//MAIN MENU
	mainGroup = new FlxTypedSpriteGroup();
	add(mainGroup);

	//old fps
	//24 * (60 / 102) / (15 / 24)
	mainTitle = new FlxSprite(0, -40);
	mainTitle.frames = Paths.getSparrowAtlas("logoBumpin");
	mainTitle.animation.addByPrefix("bump", "logo bumpin", 24, false);
	mainTitle.animation.play("bump");
	mainTitle.antialiasing = ClientPrefs.data.antialiasing;
	mainTitle.screenCenter(0x01);
	mainTitle.x -= 5;
	mainTitle.updateHitbox();
	mainTitle.scale.set(0.75, 0.75);
	mainGroup.add(mainTitle);

	mainItemsGroup = new FlxTypedSpriteGroup();
	mainGroup.add(mainItemsGroup);

	var txtSpacingTop:Int = 6;
	var btnSpacing:Int = 66;
	function makeShadow(spr:FlxText){
		var shadow = new FlxText(spr.x + spr.size / 7.5, spr.y + spr.size / 7.5, spr.width, spr.text, spr.size);
		shadow.setFormat(spr.font, spr.size, FlxColor = 0xFF3e3e3e, spr.alignment);
		shadow.updateHitbox();
		return shadow;
	}

	buttonPlay = new FlxSprite(FlxG.width/2-600/2, 350).loadGraphic(Paths.image(path + "button"));
	buttonPlay.antialiasing = ClientPrefs.data.antialiasing;
	buttonPlay.updateHitbox();
	mainItemsGroup.add(buttonPlay);
	buttonPlayText = new FlxText(buttonPlay.x, buttonPlay.y + txtSpacingTop, buttonPlay.width, "Singleplayer", 30);
	buttonPlayText.setFormat(Paths.font("Minecraftia.ttf"), 30, FlxColor.WHITE, FlxTextAlign = "center");
	buttonPlayText.updateHitbox();
	mainGroup.add(makeShadow(buttonPlayText));
	mainGroup.add(buttonPlayText);
	
	buttonPlay2 = new FlxSprite(buttonPlay.x, buttonPlay.y + btnSpacing).loadGraphic(Paths.image(path + "button-pressed"));
	buttonPlay2.antialiasing = ClientPrefs.data.antialiasing;
	buttonPlay2.updateHitbox();
	mainGroup.add(buttonPlay2);
	buttonPlay2Text = new FlxText(buttonPlay2.x, buttonPlay2.y + txtSpacingTop, buttonPlay2.width, "Multiplayer", 30);
	buttonPlay2Text.setFormat(Paths.font("Minecraftia.ttf"), 30, FlxColor = 0xFF989898, FlxTextAlign = "center");
	buttonPlay2Text.updateHitbox();
	mainGroup.add(makeShadow(buttonPlay2Text).setFormat(Paths.font("Minecraftia.ttf"), 30, FlxColor = 0xFF272727, FlxTextAlign = "center"));
	mainGroup.add(buttonPlay2Text);
	
	buttonCredits = new FlxSprite(buttonPlay2.x, buttonPlay2.y + btnSpacing).loadGraphic(Paths.image(path + "button"));
	buttonCredits.antialiasing = ClientPrefs.data.antialiasing;
	buttonCredits.updateHitbox();
	mainItemsGroup.add(buttonCredits);
	buttonCreditsText = new FlxText(buttonCredits.x, buttonCredits.y + txtSpacingTop, buttonCredits.width, "Credits", 30);
	buttonCreditsText.setFormat(Paths.font("Minecraftia.ttf"), 30, FlxColor.WHITE, FlxTextAlign = "center");
	buttonCreditsText.updateHitbox();
	mainGroup.add(makeShadow(buttonCreditsText));
	mainGroup.add(buttonCreditsText);
	
	buttonOptions = new FlxSprite(buttonCredits.x, buttonCredits.y + btnSpacing).loadGraphic(Paths.image(path + "button"));
	buttonOptions.antialiasing = ClientPrefs.data.antialiasing;
	buttonOptions.updateHitbox();
	mainItemsGroup.add(buttonOptions);
	buttonOptionsText = new FlxText(buttonOptions.x, buttonOptions.y + txtSpacingTop, buttonOptions.width, "Options", 30);
	buttonOptionsText.setFormat(Paths.font("Minecraftia.ttf"), 30, FlxColor.WHITE, FlxTextAlign = "center");
	buttonOptionsText.updateHitbox();
	mainGroup.add(makeShadow(buttonOptionsText));
	mainGroup.add(buttonOptionsText);

	buttonQuit = new FlxSprite(buttonOptions.x, buttonOptions.y + btnSpacing).loadGraphic(Paths.image(path + "button"));
	buttonQuit.antialiasing = ClientPrefs.data.antialiasing;
	buttonQuit.updateHitbox();
	mainItemsGroup.add(buttonQuit);
	buttonQuitText = new FlxText(buttonQuit.x, buttonQuit.y + txtSpacingTop, buttonQuit.width, "Exit mod", 30);
	buttonQuitText.setFormat(Paths.font("Minecraftia.ttf"), 30, FlxColor.WHITE, FlxTextAlign = "center");
	buttonQuitText.updateHitbox();
	mainGroup.add(makeShadow(buttonQuitText));
	mainGroup.add(buttonQuitText);
	
	//FREEPLAY
	freeplayGroup = new FlxTypedSpriteGroup();
	add(freeplayGroup);


	borderSongs = new FlxSprite(0, 0).loadGraphic(Paths.image(path + "borderSongs"));
	borderSongs.antialiasing = ClientPrefs.data.antialiasing;
	borderSongs.scale.set(0.85, 1.4);
	borderSongs.updateHitbox();
	borderSongs.screenCenter();
	freeplayGroup.add(borderSongs);
	
	//FREEPLAY SONGS
	songsGroup = new FlxTypedSpriteGroup();
	freeplayGroup.add(songsGroup);
	
	
	for (i in 0...songs.length) {
		songButtons[i] = new FlxSprite(615, songBtnDefaultPos + i *songBtnSpacing).loadGraphic(Paths.image(path + "button-freeplay"));
		songButtons[i].antialiasing = ClientPrefs.data.antialiasing;
		songButtons[i].scale.set(0.85, 0.85);
		songButtons[i].updateHitbox();
		songButtons[i].screenCenter(0x01);
		//0x01 = X
		//0x10 = Y
		//thx cyachao from Psych Ward
		songsGroup.add(songButtons[i]);
		
		if (!(songs[i].icon == null || songs[i].icon == "")) {
			songIcons[i] = new FlxSprite(songButtons[i].x + 25, songButtons[i].y + 18);
			songIcons[i].frames = Paths.getSparrowAtlas(path + "icons/" + songs[i].icon);
			songIcons[i].animation.addByPrefix("idle", "idle0", 10, true);
			songIcons[i].animation.addByPrefix("confirm", "confirm0", 10, false);
			songIcons[i].animation.addByPrefix("confirm-hold", "confirm-hold0", 10, true);
			songIcons[i].animation.play("idle");
			songIcons[i].antialiasing = false;
			songIcons[i].updateHitbox();
			songIcons[i].scale.set(2,2);
			songsGroup.add(songIcons[i]);
		}
		
		var txtName:FlxText;
		try {
			txtName = new FlxText(songButtons[i].x + 110, songButtons[i].y + 15, 400, Song.loadFromJson(songs[i].name + "-hard", songs[i].name).song, 36);
		}
		catch(e:Any) {
			txtName = new FlxText(songButtons[i].x + 110, songButtons[i].y + 15, 400, songs[i].name, 36);
		}
		txtName.setFormat(Paths.font("Minecraftia.ttf"), 36, FlxColor = 0xFF3e3e3e, FlxTextAlign = "left");
		txtName.updateHitbox();
		songsGroup.add(txtName);
		
		var inst:FlxSound;
		inst = new FlxSound();
		inst.loadEmbedded(Paths.inst(songs[i].name));
		var secondsTotal:Int = Math.floor(inst.length / 1000);
		var instLengthTxt:String = FlxStringUtil.formatTime(secondsTotal, false);
		var txtName:FlxText = new FlxText(songButtons[i].x + 110, songButtons[i].y + 56, 400, instLengthTxt + ", Difficulty: " + songs[i].difficulty, 18);
		try {
			Song.loadFromJson(songs[i].name + "-hard", songs[i].name);
		}
		catch(e:Any) {
			txtName.text = "";
		}
		txtName.setFormat(Paths.font("Minecraftia.ttf"), 18, FlxColor = 0xFF3e3e3e, FlxTextAlign = "left");
		txtName.updateHitbox();
		songsGroup.add(txtName);
	}
	

	render = new FlxSprite(0, 0);
	render.antialiasing = ClientPrefs.data.antialiasing;
	render.scale.set(1, 1);
	render.updateHitbox();
	freeplayGroup.add(render);
	
	
	songInfoBorder = new FlxSprite(900, 300-20).loadGraphic(Paths.image(path + "borderSongs"));
	songInfoBorder.antialiasing = ClientPrefs.data.antialiasing;
	songInfoBorder.scale.set(0.6, 0.5);
	songInfoBorder.updateHitbox();
	freeplayGroup.add(songInfoBorder);
	
	songInfoText = new FlxText(900 + 20, 300, 300, songs[curSong].info, 20);
	songInfoText.setFormat(Paths.font("Minecraftia.ttf"), 16, FlxColor.WHITE, FlxTextAlign = "left");
	songInfoText.updateHitbox();
	//songInfoText.fieldHeight = 68;
	songInfoTextS = makeShadow(songInfoText);
	freeplayGroup.add(songInfoTextS);
	freeplayGroup.add(songInfoText);
	
	
	//FREEPLAY FRONT
	titleFreeplay = new FlxSprite(200, titleFreeplayY).loadGraphic(Paths.image(path + "titles/" + songs[curSong].name));
	titleFreeplay.antialiasing = ClientPrefs.data.antialiasing;
	var titleScale:Float = 900 / FlxG.width;
	titleFreeplay.scale.set(titleScale, titleScale);
	titleFreeplay.updateHitbox();
	titleFreeplay.screenCenter(0x01);
	freeplayGroup.add(titleFreeplay);
	
	starsGroup = new FlxTypedSpriteGroup();
	freeplayGroup.add(starsGroup);
	for (i in 0...10) {
		star = new FlxSprite(i * 40, starY).loadGraphic(Paths.image(path + "star0"));
		star.antialiasing = ClientPrefs.data.antialiasing;
		star.scale.set(1, 1);
		star.updateHitbox();
		starsGroup.add(star);
	}
	starsGroup.screenCenter(0x01);
	
	
	topFreeplay = new FlxSprite(0, 0).loadGraphic(Paths.image(path + "topFreeplay"));
	topFreeplay.antialiasing = ClientPrefs.data.antialiasing;
	topFreeplay.updateHitbox();
	freeplayGroup.add(topFreeplay);
	
	songSelectTxt = new FlxText(0, 16, 1280, "Select song", 16);
	songSelectTxt.setFormat(Paths.font("Minecraftia.ttf"), 9, FlxColor = 0xFF3e3e3e, FlxTextAlign = "center");
	songSelectTxt.updateHitbox();
	freeplayGroup.add(songSelectTxt);
	
	backFreeplay = new FlxSprite(0, 0).loadGraphic(Paths.image(path + "back"));
	backFreeplay.antialiasing = ClientPrefs.data.antialiasing;
	backFreeplay.updateHitbox();
	freeplayGroup.add(backFreeplay);
	
	/*
	concept = new FlxSprite(0, 0).loadGraphic(Paths.image(path + "Minecraft_ui"));

	concept.antialiasing = ClientPrefs.data.antialiasing;
	concept.scale.set(2/3,2/3);
	concept.alpha = 0;
	concept.updateHitbox();
	freeplayGroup.add(concept);
	*/



	//SAVE STUFF	
	var variables = MusicBeatState.getVariables();
	var save:FlxSave = new FlxSave();
	save.bind(nameSaveFile, CoolUtil.getSavePath() + '/' + 'psychenginemods');
	variables.set("save_$nameSaveFile", save);
	
	var rememberedSongId:Int = 0;
	
	var saveData = variables.get("save_$nameSaveFile").data;
	if (Reflect.hasField(saveData, fieldSaveFileSongId))
		rememberedSongId = Reflect.field(saveData, fieldSaveFileSongId);
	
	chooseSong(rememberedSongId);
	//freeplayGroup.alpha = 0;
	toFreeplay();

	//AUDIO
	//game.callOnLuas("playMusic", [path + "mainMenuMix", true]);
	FlxG.sound.playMusic(Paths.music(path + "mainMenuMix"), 1, true);
	Conductor.songPosition = 0;
}


function onUpdatePost(){
	//thx Cyachao from FNModding Community
	if (FlxG.sound.music.playing) {
		Conductor.songPosition = FlxG.sound.music.time;
	}
    
    //MAIN MENU
	if (mainMenu) {
		if (FlxG.mouse.justPressed) mainMouseControls = true;
		if (mainMouseControls) {
			checkMouse(buttonPlay, toFreeplay, "button", "confirmMenu");
			checkMouse(buttonCredits, toCredits, "button", "confirmMenu");
			checkMouse(buttonOptions, options, "button", "confirmMenu");
			checkMouse(buttonQuit, quit, "button", "back");
			checkMouse(buttonPlay2, toFreeplay2, "", "");
		}
		if (controls.UI_UP_P)  	   chooseMenuItem(curMenu - 1);
		if (controls.UI_DOWN_P)	   chooseMenuItem(curMenu + 1);
		if (FlxG.mouse.wheel != 0) chooseMenuItem(curMenu -1 * FlxG.mouse.wheel);
		if (controls.ACCEPT){
			/**
			 * This is so bad, 
			 * but I'm not gonna deal with option strings 
			 * like in Psych Engine MainMenuState.
			 * I'm scared.
			*/
			switch curMenu {
				case 0: toFreeplay(); 
				case 1: toCredits();
				case 2: options();
				case 3: quit();
			}
			FlxG.sound.play(Paths.sound(path + "confirmMenu"));
		}
		if (controls.BACK){
			FlxG.sound.play(Paths.sound(path + "back"));
			quit();
		}
	}
	//FREEPLAY
	if (freeplay) {
		if (controls.UI_UP_P)      chooseSong(curSong - 1);
		if (controls.UI_DOWN_P)    chooseSong(curSong + 1);
		if (FlxG.mouse.wheel != 0) chooseSong(curSong -1 * FlxG.mouse.wheel);
		if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(songButtons[curSong]))
			startSong(curSong);
		else if (
			FlxG.mouse.justPressed && 
			FlxG.mouse.screenX > FlxG.width/2 - songButtons[curSong].width/2 && 
			FlxG.mouse.screenX < FlxG.width/2 + songButtons[curSong].width/2
			) {
			if (FlxG.mouse.screenY < songButtons[curSong].y)
				chooseSong(curSong - 1);
			else
				chooseSong(curSong + 1);
		}
		if (controls.ACCEPT) startSong(curSong);
		if (controls.BACK){
			toMainMenu();
			FlxG.sound.play(Paths.sound(path + "back"));
		}
		checkMouse(backFreeplay, toMainMenu, "", "back");
	}
	
	//debug quit
	if (FlxG.keys.pressed.Q){
		game.callOnLuas("exitSong", "");
		buttonPlay.alpha = 0;
	}
}

function onBeatHit() {
	mainTitle.animation.play("bump");
	
	for (i in bgGroup.members)
		if (i.x <= -720)
			i.x += 720 * 4;
}

//==========FUNCTIONS=============

//MAIN MENU
function toFreeplay() {
	if (mainGroupTwn != null) { mainGroupTwn.cancel(); }
	mainGroupTwn = FlxTween.tween(mainGroup, { alpha:0, x:-10 }, 4/24, { ease: FlxEase.sineOut });
	mainMenu = false;
	freeplayGroup.x = 10;
	if (freeplayGroupTwn != null) { freeplayGroupTwn.cancel(); }
	freeplayGroupTwn = FlxTween.tween(freeplayGroup, { alpha:1, x:0 }, 4/24, { ease: FlxEase.sineOut });

	//To prevent the user accidentally choosing a song after clicking the SinglePlayer button
	new FlxTimer().start(0.1, function(tmr:FlxTimer) { 
		freeplay = true;
	});
}
function toMainMenu() {
	if (renderTwnX != null)  renderTwnX.cancel();
	if (renderTwnA != null)  renderTwnA.cancel();
	mainGroup.x = 10;
	if (mainGroupTwn != null) mainGroupTwn.cancel();
	mainGroupTwn = FlxTween.tween(mainGroup, { alpha:1, x:0 }, 4/24, { ease: FlxEase.sineOut });
	mainMenu = true;
	if (freeplayGroupTwn != null) freeplayGroupTwn.cancel();
	freeplayGroupTwn = FlxTween.tween(freeplayGroup, { alpha:0, x:-10 }, 4/24, { ease: FlxEase.sineOut });
	freeplay = false;
}

function toCredits() {
	initHScript(pathMenuScripts + "creditsSubState.hx");
	if (mainGroupTwn != null) { mainGroupTwn.cancel(); }
	mainGroupTwn = FlxTween.tween(mainGroup, { alpha:0, x:-10 }, 4/24, { ease: FlxEase.sineOut });
	mainMenu = false;
	freeplay = false;

}

function reloadMenu() {
	game.callOnLuas("loadSong", ["project-crafted", "hard"]);
}

function options() {
	//Code from Miner's Haunt optimization
	var pauseMusic = new flixel.sound.FlxSound();
	try {
		var pauseSong:String = getPauseSong();
		if(pauseSong != null) pauseMusic.loadEmbedded(Paths.music(pauseSong), true, true);
	}
	catch(e:Dynamic) {}
	pauseMusic.volume = 0;
	pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));
	MusicBeatState.switchState(new options.OptionsState());
	if(ClientPrefs.data.pauseMusic != 'None')
	{
		FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.pauseMusic)),pauseMusic.volume);
		FlxTween.tween(FlxG.sound.music,{volume: 1}, 0.8);
		FlxG.sound.music.time = pauseMusic.time;
	}
	OptionsState.onPlayState = true;
}

function quit() {
	FlxG.mouse.visible = false;
	game.callOnLuas("exitSong", "");
}

var freeplay2Clicks:Int = 0;
function toFreeplay2() {
	switch freeplay2Clicks {
		case 10: debugPrint("can you not");
		case 20: debugPrint("...");
		case 40: debugPrint("stop");
		case 100: debugPrint("wow, you made it. you tried to enter multiplayer 100 times.");
		case 200: 
			FlxG.stage.window.alert("here you go.\nminecraft multiplayer.", "");
			CoolUtil.browserLoad('https://classic.minecraft.net/');
			game.callOnLuas("addLuaScript", ["data/project-crafted/smth special/die.lua"]);
	}
	freeplay2Clicks += 1;
}

function chooseMenuItem(curNew:Int) {
	mainMouseControls = false;
	if (0 <= curNew && curNew < mainItemsGroup.members.length) {
		mainItemsGroup.members[curMenu].loadGraphic(Paths.image(path + "button"));
		mainItemsGroup.members[curMenu].updateHitbox();
		mainItemsGroup.members[curNew].loadGraphic(Paths.image(path + "button-hovered"));
		mainItemsGroup.members[curNew].updateHitbox();
		curMenu = curNew;
	}
}

function checkMouse(spr:FlxSprite, func:Void->Void, str:String, sound:String){
	mainMouseControls = true;
	if (FlxG.mouse.overlaps(spr)) {
		if (str != null) 
			spr.loadGraphic(Paths.image(path + str + "-hovered"));
		if (FlxG.mouse.justPressed){
			if (!(sound == null || sound == ""))
				FlxG.sound.play(Paths.sound(path + sound));
			func();
		}
	}
	else if (str != null)
			spr.loadGraphic(Paths.image(path + str));
}

//FREEPLAY
var iStar:Int = 0;
function updateStars() {
    var dif:Int = songs[curSong].difficulty;
	if (dif == -1)
		starsGroup.alpha = 0;
	else
		starsGroup.alpha = 1;
    for (i in 0...starsGroup.members.length) {
        if (dif >= 2){
            starsGroup.members[i].loadGraphic(Paths.image(path + "star" + 2));
            dif -= 2;
        }
        else {
            starsGroup.members[i].loadGraphic(Paths.image(path + "star" + dif));
            dif = 0;
        }
    }
	//there's kinda no point in making this function
	starJump();
}
var upDown:Int = 1;
function starJump() {
	for (i in 0...starsGroup.members.length) {
		if (i % 2)
			starsGroup.members[i].y = starY - upDown * 4;
		else
			starsGroup.members[i].y = starY + upDown * 4;
	}
	upDown = -upDown;
	new FlxTimer().start(2 / 24, function(tmr:FlxTimer) {
		for (i in 0...starsGroup.members.length)
			starsGroup.members[i].y = starY;
	});
}

var songsGroupTwn:FlxTween;
function chooseSong(curNew:Int){
	if (0 <= curNew && curNew < songs.length) {
		songButtons[curSong].loadGraphic(Paths.image(path + "button-freeplay"));
		songButtons[curSong].updateHitbox();
		songButtons[curNew].loadGraphic(Paths.image(path + "button-freeplay-hovered"));
		songButtons[curNew].updateHitbox();
		if (songsGroupTwn != null) songsGroupTwn.cancel();
		songsGroupTwn = FlxTween.tween(songsGroup, { y:-curNew * songBtnSpacing }, 6/24, { ease: FlxEase.quintOut });
		curSong = curNew;

		render.loadGraphic(Paths.image(path + "renders/" + songs[curNew].render.name));
		render.scale.set(songs[curNew].render.scale, songs[curNew].render.scale);
		render.x = songs[curNew].render.x - 10;
		render.y = songs[curNew].render.y;

		if (renderTwnX != null) renderTwnX.cancel();
		renderTwnX = FlxTween.tween(render, { x:songs[curNew].render.x }, 4/24, { ease: FlxEase.quadOut });
		render.alpha = 0.5;

		if (renderTwnA != null) renderTwnA.cancel();
		renderTwnA = FlxTween.tween(render, { alpha:1 }, 4/24, { ease: FlxEase.quadOut });

		if (Paths.image(path + "titles/" + songs[curNew].name) != null) {
			titleFreeplay.loadGraphic(Paths.image(path + "titles/" + songs[curNew].name));
			titleFreeplay.alpha = 1;
		}
		else {
			titleFreeplay.alpha = 0;
		}
    	var titleScale:Float = 900 / FlxG.width;
    	titleFreeplay.scale.set(titleScale * 1.05, titleScale * 1.05);
		titleFreeplay.y = titleFreeplayY - 10;
    	titleFreeplay.updateHitbox();
    	titleFreeplay.screenCenter(0x01);
		if (titleTwnScale != null) titleTwnScale.cancel();
    	titleTwnScale = FlxTween.tween(titleFreeplay, { y:titleFreeplayY, "scale.x":titleScale, "scale.y":titleScale }, 4/24, { ease: FlxEase.quadOut });

    	updateStars();

		var infoTextStr:String = 
			"Highscore: " + Highscore.getScore(songs[curNew].name, "hard") + "\n" +
			"Cleared: " + Math.ffloor(Highscore.getRating(songs[curNew].name, "hard") * 10000) / 100 + "%" + "\n" +
			"\n" +
			songs[curNew].info;
		songInfoText.text = infoTextStr;
		songInfoTextS.text = infoTextStr;
		try {
			Song.loadFromJson(songs[curNew].name + "-hard", songs[curNew].name);
			songInfoBorder.alpha = 1;
		}
		catch(e:Any) {
			songInfoText.text = "";
			songInfoTextS.text = "";
			songInfoBorder.alpha = 0;
		}
		FlxG.sound.play(Paths.sound(path + 'scroll'));
	}
}

function startSong(i:Int) {
	try {
		Song.loadFromJson(songs[i].name + "-hard", songs[i].name);
		FlxG.sound.play(Paths.sound(path + "click"));
		songIcons[i].animation.play("confirm");

		//SAVES THE STARTED SONG
		var variables = MusicBeatState.getVariables();
		Reflect.setField(variables.get('save_$nameSaveFile').data, fieldSaveFileSongId, i);

		new FlxTimer().start(1.0, function(tmr:FlxTimer) {
			FlxG.mouse.visible = false;
			// It fixes the skip song text appearing even without launching the song before
			PlayState.seenCutscene = false; 
			game.callOnLuas("loadSong", [songs[i].name, "hard"]);
		});
	}
	catch (e:haxe.Exception) {

	}	
}





