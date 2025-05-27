import backend.Mods;
import backend.Song;
import psychlua.FunkinLua;
using StringTools;

function onCreate() {
    if (PlayState.SONG.stage != "customMenu")
        for (folder in Mods.directoriesWithFile(Paths.getSharedPath(), 'scripts/inPlayScripts/'))
            for (file in FileSystem.readDirectory(folder))
            {
                if(file.toLowerCase().endsWith('.lua'))
                    new FunkinLua(folder + file);

                if(file.toLowerCase().endsWith('.hx'))
                    initHScript(folder + file);
            }
}