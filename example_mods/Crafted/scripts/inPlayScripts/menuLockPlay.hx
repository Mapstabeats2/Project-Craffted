//code from 15lukas by mrmeep64
//15lukas https://gamebanana.com/mods/529487
//mrmeep64 https://twitter.com/mrmeep64

import backend.Highscore;
import backend.Song;


function onEndSong() {
    return returnToMenu();
}
/*
function onUpdatePost() {
    if (FlxG.keys.pressed.Q){
		return returnToMenu();
	}
}
*/
function returnToMenu() {
    if (Paths.formatToSongPath(PlayState.SONG.song) != "project-crafted") {
        PlayState.transitioning = false;
        Highscore.saveScore(Song.loadedSongName, songScore, "hard", ratingPercent);
        game.callOnLuas("loadSong", ["project-crafted", "hard"]);
        return Function_Stop;
    }
    return Function_Continue;
}