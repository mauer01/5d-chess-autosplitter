/* 5D Chess with multiverse timetravel Autosplitter (--) 
*  Maintained by Mauer01
*
*/



state("5dchesswithmultiversetimetravel"){
    int pointerfirstboard : "5dchesswithmultiversetimetravel.exe", 0x146B48;
    int gameendedwinner : "5dchesswithmultiversetimetravel.exe", 0x146C14;
    int playerlocal : "5dchesswithmultiversetimetravel.exe", 0x146B04;

}
init {
    print("loaded");
}

startup 
{
    print("startup");
    settings.Add("solo", false, "reset when leaving");
}

start {
    return old.gameendedwinner == 0 && current.gameendedwinner == -1;
}

split {
    if (current.pointerfirstboard == 0){
        return false;
    }
    return old.gameendedwinner == -1 && current.gameendedwinner == current.playerlocal;
}

reset {
    if (current.pointerfirstboard != 0) {
        return false;
    }
    return settings["solo"] && old.gameendedwinner == -1 && current.gameendedwinner == 0;
}