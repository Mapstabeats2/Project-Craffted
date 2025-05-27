//code from 15lukas by mrmeep64
//15lukas https://gamebanana.com/mods/529487
//mrmeep64 https://twitter.com/mrmeep64

function onPause(){
    setVar('updateFunc', function() {
        if (FlxG.state.subState != null && FlxG.state.subState.curSelected != null && FlxG.state.subState.menuItems[FlxG.state.subState.curSelected] == "Exit to menu") {
            if (controls.ACCEPT) {
                game.callOnLuas("loadSong", ["project-crafted", "hard"]);
            }
        }
    });
    FlxG.signals.preUpdate.add(getVar('updateFunc'));
}

function onResume(){
        FlxG.signals.preUpdate.remove(getVar('updateFunc'));
}

function onDestroy(){
        FlxG.signals.preUpdate.remove(getVar('updateFunc'));
}