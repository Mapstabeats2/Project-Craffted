import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.group.FlxTypedSpriteGroup;
import psychlua.LuaUtils;

var barTop:FlxSprite;
var barTopGroup:FlxTypedSpriteGroup<FlxSprite>;
var barTopTwn:FlxTween;

var barBottom:FlxSprite;
var barBottomGroup:FlxTypedSpriteGroup<FlxSprite>;
var barBottomTwn:FlxTween;

function onCreatePost() {
    barTopGroup = new FlxTypedSpriteGroup();
    barTopGroup.cameras = [camHUD];
    add(barTopGroup);
    barBottomGroup = new FlxTypedSpriteGroup();
    barBottomGroup.cameras = [camHUD];
    add(barBottomGroup);

    barTop = new FlxSprite(0, -FlxG.height / 2).makeGraphic(FlxG.width, FlxG.height / 2, FlxColor.BLACK);
    barTop.scrollFactor.set(0, 0);
    barTop.updateHitbox();
    barTopGroup.add(barTop);
    barBottom = new FlxSprite(0, FlxG.height / 2 + FlxG.height / 2).makeGraphic(FlxG.width, FlxG.height / 2, FlxColor.BLACK);
    barBottom.scrollFactor.set(0, 0);
    barBottom.updateHitbox();
    barBottomGroup.add(barBottom);
}
function onEvent(event, v1, v2, time) {
    if (event == "cinematicBars") {
        var intensity:Float = v1;
        var duration:Float = 1;
        var ease:FlxEase = FlxEase.quadOut;
        if (v2 != null) {
            var split:Array<String> = v2.split(',');
            duration = Std.parseFloat(split[0]);
            ease = LuaUtils.getTweenEaseByString(split[1]);
            //PlayState.instance.addTextToDebug(ease, FlxColor.WHITE);
        }
        if (barTopTwn != null) { barTownTwn.cancel(); }
        if (barBottomTwn != null) { barBottomTwn.cancel(); }
        barTopTwn = FlxTween.tween(barTopGroup, { y:intensity * FlxG.height / 2 }, duration, { ease: ease });
        barBottomTwn = FlxTween.tween(barBottomGroup, { y:-intensity * FlxG.height / 2 }, duration, { ease: ease });
    }
}

