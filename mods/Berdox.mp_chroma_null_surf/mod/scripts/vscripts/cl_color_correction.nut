global function cl_setlight_init;

void function cl_setlight_init() {
    string mapName = GetMapName()
    if ( mapName == "mp_complex_surf" )
    {
        thread Client_SetLight(0.1, 0.1)
    }
}

void function Client_SetLight(float sun, float sky)
{
    WaitFrame()
    entity le = GetLightEnvironmentEntity();
    if (le != null)
        le.ScaleSunSkyIntensity(sun, sky);
}