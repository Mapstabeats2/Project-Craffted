if (PlayState.SONG.stage != "customMenu") { //yeah... that's not good
    
    //I'm such a base FNF modder wannabe
    //import backend.Mods;
    //import psychlua.HScript;

    /*
    var alexStageScript:Hscript;

    function onCreate() {
        alexStageScript = new HScript(null, "mods/" + Mods.currentModDirectory + "/stages/alexStage.hx");
    }
    */

    function onCountdownTick(tick:Countdown, counter:Int){
        switch(tick)
        {
            case Countdown.THREE:
                //Counter equals to 0
                nc_zoom("game", 0.6, 0.7, "sineOut");
                nc_focus("opp", 1.7, "sineIn", false);
            case Countdown.TWO:
                //Counter equals to 1
            case Countdown.ONE:
                //Counter equals to 2
            case Countdown.GO:
                //Counter equals to 3
            case Countdown.START:
                //Counter equals to 4, this has no visual indication or anything, it's pretty much at nearly the exact time the song starts playing
        }
    }

    function onSongStart() {
        nc_zoom("game", 0.8, 0.7, "sineOut");
        //nc_focus("opp", 1, "circIn", false);
    }
    
    function onStepHit() {
        switch curStep {
            case 12:
                //doDarknessTwn(0.5, 0.2, FlxEase.sineIn);
            case 88:
                nc_zoom("g", 0.7, 0, "circOut");
            case 98:
                nc_zoom("g", 0.8, 0, "circOut");
            case 112:
                nc_focus("center", 1, "circOut", true);
                nc_zoom("g", 0.7, 0, "circOut");
            case 140:
                nc_zoom("g", 0.6, 0, "circOut");
            case 128:
                nc_zoom("g", 0.6, 1.3, "sineOut");
                triggerEvent("darknessTwn", 0.7, "1.3,sineIn");
            case 143:
                nc_lock(false, false);
            case 144:
                nc_snap_zoom("g", 0.85);
                nc_snap_target("plr");
                nc_bump("g", 2);
                nc_zoom("g", 0.7, 1, "expoOut");
                triggerEvent("darknessTwn", 0);
            case 176:
                nc_zoom("g", 0.8, 0, "circOut");
            case 192:
                nc_zoom("g", 0.9, 0, "circOut");
            case 208:
                nc_focus("center", 1, "circOut", true);
                nc_zoom("g", 0.7, 0, "circOut");
            case 271:
                nc_lock(false, false);
            case 272:
                nc_zoom("g", 0.8, 0, "circOut");
            case 368:
                nc_focus("center", 1, "circOut", true);
                nc_zoom("g", 0.7, 0, "circOut");
            case 416:
                nc_zoom("g", 0.6, 1.3, "sineOut");
            case 431:
                nc_lock(false, false);
            case 432:
                nc_snap_zoom("g", 0.7);    
                //nc_snap_target("plr");
                nc_bump("g", 2);
            case 552:
                nc_focus("plr", 0.65, "expoOut", false);
            case 560:
                nc_snap_target("plr");
            case 610:
                nc_snap_zoom("g", 0.72);
            case 612:
                nc_snap_zoom("g", 0.74);
            case 614:
                nc_snap_zoom("g", 0.76);
            case 616:
                nc_snap_zoom("g", 0.78);
            case 618:
                nc_snap_zoom("g", 0.8);
            case 620:
                nc_snap_zoom("g", 0.82);
            case 622:
                nc_snap_zoom("g", 0.84);
            case 624:
                nc_zoom("g", 0.6, 1, "expoOut");
                nc_focus("center", 1, "expoOut", true);
            case 664:
                nc_lock(false, false);
                nc_focus("opp", 1, "circOut", false);
                nc_zoom("g", 0.7, 1, "expoOut");
            case 688:
                //alexStageScript.call("changeStageTo3d", []); //THIS STUFF SUCKS. IT DOESN'T WORK PROPERLY.
                //changeStageTo3d();
                triggerEvent("changeStageTo3d");
                nc_snap_zoom("game", 1.5);
                nc_snap_target("opp");
            case 1072:
                //alexStageScript.call("changeStageTo2d", []);
                //changeStageTo2d();
                triggerEvent("changeStageTo2d");
                nc_snap_zoom("game", 0.8);
                nc_snap_target("opp");
        }
    }

}