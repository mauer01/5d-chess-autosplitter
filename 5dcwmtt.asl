/* 5D Chess with multiverse timetravel Autosplitter (--) 
*  Maintained by Mauer01
*
*/



state("5dchesswithmultiversetimetravel"){
    int pointerfirstboard : "5dchesswithmultiversetimetravel.exe", 0x146B48;
    int endofgamedesc : "5dchesswithmultiversetimetravel.exe", 0x146C18;
    int finishgamebutton : "5dchesswithmultiversetimetravel.exe", 0x146C10;
    int gameendedwinner : "5dchesswithmultiversetimetravel.exe", 0x146C14;
    int playerlocal : "5dchesswithmultiversetimetravel.exe", 0x146B04;

}
init {
    print("loaded");
}

startup 
{
    print("startup");
    settings.Add("puzzle", false, "Puzzle Mode");
    settings.Add("vscpu", false, "Variant Mode");
    settings.Add("solo", false, "reset when leaving", "vscpu");
}

start {
    return old.gameendedwinner == 0 && current.gameendedwinner == -1;
}

split {
    if (current.pointerfirstboard == 0){
        return false;
    }
    if (settings["puzzle"]) {
        return old.endofgamedesc == 0 && current.endofgamedesc == 1;
    }
    if (settings["vscpu"]) {

        return old.gameendedwinner == -1 && current.gameendedwinner == current.playerlocal;
    }
}

reset {
    if (current.pointerfirstboard != 0) {
        return false;
    }
    return settings["solo"] && old.gameendedwinner == -1 && current.gameendedwinner == 0;
}