if (!PlayState.chartingMode) {

	var boxBottom:FlxSprite;
	var boxTop:FlxSprite;
	var boxLeft:FlxSprite;
	var boxRight:FlxSprite;
	var intensity:FlxSprite;
	
	var loadTime:Float = 0.5;
	var elapsedTime:Float = 0;
	var times:Int = 5;
	function onCreatePost()
	{
		// End of "create"
		boxTop = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height / 2, FlxColor.BLACK);
		boxTop.updateHitbox();
		boxTop.cameras = [camOther];
		add(boxTop);
	
		boxBottom = new FlxSprite(0, FlxG.height / 2).makeGraphic(FlxG.width, FlxG.height / 2, FlxColor.BLACK);
		boxBottom.updateHitbox();
		boxBottom.cameras = [camOther];
		add(boxBottom);
		
		boxLeft = new FlxSprite(0, 0).makeGraphic(FlxG.width / 2, FlxG.height, FlxColor.BLACK);
		boxLeft.updateHitbox();
		boxLeft.cameras = [camOther];
		add(boxLeft);
	
		boxRight = new FlxSprite(FlxG.width / 2, 0).makeGraphic(FlxG.width / 2, FlxG.height, FlxColor.BLACK);
		boxRight.updateHitbox();
		boxRight.cameras = [camOther];
		add(boxRight);
	
		intensity = new FlxSprite(0, 0);
		intensity.updateHitbox();
		FlxTween.tween(intensity, {x : 1}, loadTime, {ease: FlxEase.sineOut});
	}
	
	var i:Int = 1;
	function onUpdate(elapsed:Float)
	{
		if (elapsedTime <= loadTime + 2 * loadTime / times) {
			if (elapsedTime >= i * loadTime / times){
				i += 1;
				boxTop.y = -intensity.x * (FlxG.height / 2);
				boxBottom.y = FlxG.height / 2 + intensity.x * (FlxG.height / 2);
				boxLeft.x = -intensity.x * (FlxG.width / 2);
				boxRight.x = FlxG.width / 2 + intensity.x * (FlxG.width / 2);
			}
			elapsedTime += elapsed;
		}
	}
}