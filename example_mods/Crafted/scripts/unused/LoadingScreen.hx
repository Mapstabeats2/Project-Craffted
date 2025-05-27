function onCreate()
{
    
    
			var myClass:Dynamic = Type.resolveClass('flixel.addons.transition.FlxTransitionableState');

			var split:Array<String> = "skipNextTransOut".split('.');
			if(split.length > 1) {
				var obj:Dynamic = LuaUtils.getVarInArray(myClass, split[0], false);
				for (i in 1...split.length-1)
					obj = LuaUtils.getVarInArray(obj, split[i], false);

				LuaUtils.setVarInArray(obj, split[split.length-1], false ? parseInstances(true) : true, false);
				return true;
			}
			
    var myClass:Dynamic = Type.resolveClass('flixel.addons.transition.FlxTransitionableState');



			var split:Array<String> = "skipNextTransIn".split('.');
			if(split.length > 1) {
				var obj:Dynamic = LuaUtils.getVarInArray(myClass, split[0], false);
				for (i in 1...split.length-1)
					obj = LuaUtils.getVarInArray(obj, split[i], false);

				LuaUtils.setVarInArray(obj, split[split.length-1], false ? parseInstances(true) : true, false);
				return true;
			}
			
    


	game.stateChangeDelay = 3; //Force loading screen to stay for atleast 3 seconds, remove this once you're done working on your loading screen unless you're using it for something else.




	var bg = new FlxSprite().makeGraphic(1, 1, 0xFFCAFF4D);
	bg.scale.set(FlxG.width, FlxG.height);
	bg.updateHitbox();
	bg.screenCenter();
	addBehindBar(bg);

	funkay = new FlxSprite(0, 0).loadGraphic(Paths.image('funkay'));
	funkay.antialiasing = ClientPrefs.data.antialiasing;
	funkay.setGraphicSize(0, FlxG.height);
	funkay.updateHitbox();
	addBehindBar(funkay);
}

function onUpdate(elapsed:Float)
{
	//do something here every frame
}