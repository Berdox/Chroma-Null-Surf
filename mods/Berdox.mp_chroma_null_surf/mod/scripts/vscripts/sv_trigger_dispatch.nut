untyped

global function Script_Dispatch_Init

// List of triggers you want to bind
array<string> triggerNames =
[
    "teleport_player_trig_1",
    "teleport_player_trig_2",
    "teleport_player_trig_3",
    "teleport_player_trig_4",
    "teleport_player_trig_5",
    "teleport_player_trig_6",
    "teleport_player_trig_7",
    "teleport_player_trig_8",
    "teleport_player_trig_9",
    "teleport_player_trig_10",
    "teleport_player_trig_11",
    "teleport_player_trig_12",
    "teleport_player_trig_13",
    "teleport_player_trig_14",
    "teleport_player_trig_15",
    "teleport_player_trig_16",
    "teleport_player_trig_17",
    "teleport_player_trig_18",
    "teleport_player_trig_19",
    "teleport_player_trig_20",
    "teleport_player_trig_21",
    "teleport_player_trig_22",
    "teleport_player_trig_23",
    "teleport_player_trig_24",
    "teleport_player_trig_25",
    "teleport_player_trig_26",
    "teleport_player_trig_27",
    "teleport_player_trig_28",
    "teleport_player_trig_29",
    "teleport_player_trig_30",
    "teleport_player_trig_31",
    "teleport_player_trig_32",
    "teleport_player_trig_finish"
]

// ======================================================================
// Trigger → action lookup table
// ======================================================================
table<string, void functionref(table)> triggerActionMap = {}

void function RegisterTriggerActions()
{

    // Bind script_name to specific functions
    triggerActionMap["teleport_player_trig_1"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_2"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_3"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_4"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_5"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_6"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_7"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_8"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_9"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_10"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_11"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_12"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_13"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_14"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_15"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_16"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_17"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_18"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_19"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_20"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_21"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_22"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_23"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_24"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_25"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_26"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_27"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_28"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_29"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_30"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_31"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_32"]  <- TriggerAction_TeleportPlayer
    triggerActionMap["teleport_player_trig_finish"]  <- TriggerAction_TeleportPlayer
}


// ======================================================================
// Entry point
// ======================================================================
void function Script_Dispatch_Init()
{
    string mapName = GetMapName()
    if ( mapName == "mp_chroma_null_surf" )
    {
        thread  Find_And_Bind_Triggers()
    }
}


// ======================================================================
// Startup: find triggers and bind actions
// ======================================================================
void function Find_And_Bind_Triggers()
{
    wait 2 // Make sure trigger exist
    //print("Find and Bind Triggers")

    RegisterTriggerActions()

    // Spawn listener threads
    foreach ( name in triggerNames )
    {
        entity trig = GetEntByScriptName( name )
           
        if ( !IsValid( trig ) )
        {
            print("Trigger missing: " + name)
            continue
        }

        thread WaitForTriggerAndDispatch( trig, name)
    }
}

// ======================================================================
// Per-trigger waiter + dispatcher
// ======================================================================

void function WaitForTriggerAndDispatch(entity trig, string trigger_name)
{
    while ( IsValid(trig) )
    {
        // **************** Signal Table ***************************************
        // Key: self | Value: entity (106: trigger_multiple StopAndRotateTrigger [106])
        // Key: activator | Value: entity (1: player Berdoxs [1])
        // Key: signal | Value: OnTrigger
        // Key: value | Value: null
        // Key: caller | Value: entity (106: trigger_multiple StopAndRotateTrigger [106])
        table signalTable = trig.WaitSignal("OnTrigger")

        if (trigger_name in triggerActionMap) 
        {
            triggerActionMap[trigger_name](signalTable);
        } 
        else 
        {
            print("No action assigned for trigger: " + trigger_name);
        }
    }
}