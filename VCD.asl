/*
    Viscera Cleanup Detail
    Version: 0.0.1
    Author: NoTeefy (Original script by KunoDemetries)
    Compatible Versions:
        Standalone (PC) || W10 (functional) || W7 (untested, might not work)
    
    Tiny load-remover for VCD. It only supports the traditional/normal edition.
*/
state("UDK", "x32") {
    bool isLoading : 0x68080C, 0x24C;
}
state("UDK", "x64") {
    bool isLoading : 0x3676C3C, 0x24C;
}
/*
    startup{} runs when the script gets loaded
*/
startup {
    // init version & debug flag
    vars.ver = "0.0.1";
    bool debugEnabled = false;
    
    /*
        Function dbgOut()
        Prints the passed text. You can use DebugView.exe from Microsoft to check the output. It only works if the debugEnabled flag has been set to true.

        Params: [string] text, that is getting printed out
        Return: void / nothing
    */
    vars.dbgOut = (Action<string>) ((text) => {
        if (debugEnabled) {
			print(" «[VCD - v" + vars.ver + "]» " + text);
        }
    });

    // set the amount of memory cycles per second
    refreshRate = 1000/7; // all 7ms
}
/*
    init{} runs if the given process has been found (can occur multiple times during a session; if you reopen the game as an example)
*/
init {
    vars.dbgOut("init{} - attached LS to the game process");
    vars.dbgOut("init{} - starting initialisation");

    // check what state descriptor to use
    version = game.Is64Bit() ? "x64" : "x32";
}
/*
    isLoading{} only runs when the timer's active (will be skipped if update{}'s returning false)
    return true => pauses the GameTime-Timer till the next tick
*/
isLoading {
    if(current.isLoading != null) {
        return current.isLoading; 
    }
}