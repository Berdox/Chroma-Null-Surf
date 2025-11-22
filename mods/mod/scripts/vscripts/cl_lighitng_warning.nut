global function Display_Lighting_Warning_init

void function Display_Lighting_Warning_init() {
    string mapName = GetMapName()
    if ( mapName == "mp_chroma_null_surf" )
    {
        print("Warning lighitng init *************************")
        thread Display_Lighting_Warning("If lighting and shadow are messed up, change SUN SHADOW DETAIL in settings and apply it", 10.0)
    }
}

void function Display_Lighting_Warning(string message, float duration = 20.0)
{
    wait(10)
    print("Warning lighitng *************************")
    // Create the RUI
    var msgRUI = CreatePermanentCockpitRui($"ui/sp_onscreen_hint.rpak")
    RuiSetResolutionToScreenSize(msgRUI)

    // Set the message directly
    RuiSetString(msgRUI, "locStringKBM", message)
    RuiSetBool(msgRUI, "hasLocStringKBM", true)
    RuiSetBool(msgRUI, "displayCentered", false)

    // Wait for the specified duration minus fade time
    float fadeTime = 1.0
    wait(duration - fadeTime)

    // Fade out safely
    try
    {
        RuiSetBool(msgRUI, "forceFadeOut", true)
    }
    catch (err)
    {
        print("Tried to fade out a destroyed RUI, skipping.")
    }

    // Wait for fade to finish, then destroy
    wait(fadeTime)
    SafeDestroyRUI(msgRUI)
}

// Safe destroy function
void function SafeDestroyRUI(var rui)
{
    if (rui != null)
    {
        RuiDestroyIfAlive(rui)
        rui = null
    }
}
