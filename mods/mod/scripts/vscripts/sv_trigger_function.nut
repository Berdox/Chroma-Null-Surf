
global function TriggerAction_TeleportPlayer


// ======================================================================
// Teleport player to origin of Teleport Destination
// ======================================================================
void function TriggerAction_TeleportPlayer(table signalTable)
{
    entity self = expect entity(signalTable["self"]);
    entity activator = expect entity(signalTable["activator"]);
    entity tele_destination = GetEntByScriptName("teleport_player_trig_destination")

    if ( IsValid( activator ) && IsValid(tele_destination))
    {   
        activator.Signal( "Gauntlet_ForceRestart" ) // Sends signal to restart gauntlet
        activator.SetOrigin( tele_destination.GetOrigin() )
        activator.SetAngles( tele_destination.GetAngles())
        activator.SetVelocity(Vector(0,0,0))
        //print("Teleported player to destination origin")
    } 
    // else {
    //     print("No teleport because no valid entities")
    // }
}