import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.sound.FlxSound;
import flixel.group.FlxTypedSpriteGroup;
import flixel.text.FlxText;

import tjson.TJSON;

using StringTools;

//VARIABLES
var path:String = "freeplay/";

typedef CreditInfo = {
	var name:String;
	var desc:String;
	var icon:String;
	var url:String;
}

//ITEMS
var creditInfoPath:String = Paths.getPath("stages/customMenu/creditsSubStateData.json");
var creditInfos:Array<CreditInfo> = TJSON.parse(File.getContent(creditInfoPath));

var creditsGroup:FlxTypedSpriteGroup<FlxSprite>;
var creditItemsGroup:FlxTypedSpriteGroup<FlxSprite>;
var creditButtons:Array<FlxSprite> = [];
var creditIcons:Array<FlxSprite> = [];

//VISUAL
var creditBtnSpacing = 100;

function onCreate() {
    
	creditsGroup = new FlxTypedSpriteGroup();
	add(creditsGroup);

    creditItemsGroup = new FlxTypedSpriteGroup();
	creditsGroup.add(creditItemsGroup);

    for (i in 0...creditInfos.length) {
		creditButtons[i] = new FlxSprite(0, 250 + i * creditBtnSpacing).loadGraphic(Paths.image(path + "button-freeplay"));
		creditButtons[i].antialiasing = ClientPrefs.data.antialiasing;
		creditButtons[i].scale.set(0.85, 0.85);
		creditButtons[i].updateHitbox();
		creditButtons[i].screenCenter(0x01);
		//0x01 = X
		//0x10 = Y
		//thx cyachao from Psych Ward
		creditItemsGroup.add(creditButtons[i]);
		
		if (!(creditInfos[i].icon == null || creditInfos[i].icon == "")) {
            creditIcons[i] = new FlxSprite(creditButtons[i].x, creditButtons[i].y + 10).loadGraphic(Paths.image(path + "credits/" + creditInfos[i].icon));
			creditIcons[i].antialiasing = false;
			creditIcons[i].updateHitbox();
			creditIcons[i].scale.set(1, 1);
			creditItemsGroup.add(creditIcons[i]);
		}
		
		var creditName:FlxText = new FlxText(creditButtons[i].x + 50, creditButtons[i].y + 10, 400, creditInfos[i].name, 36);
		creditName.setFormat(Paths.font("Minecraftia.ttf"), 36, FlxColor = 0xFF3e3e3e, FlxTextAlign = "left");
		creditName.updateHitbox();
		creditItemsGroup.add(creditName);
		
        var creditDesc:FlxText = new FlxText(creditButtons[i].x + 50, creditButtons[i].y + 70, 400, creditInfos[i].desc, 12);
		creditDesc.setFormat(Paths.font("Minecraftia.ttf"), 12, FlxColor = 0xFF3e3e3e, FlxTextAlign = "left");
		creditDesc.updateHitbox();
		creditItemsGroup.add(creditDesc);
		
	}

}