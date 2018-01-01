#include "Factions.as";
#include "RPGCommon.as";
#include "MakeSign.as";
//#define SERVER_ONLY;

void onRestart( CRules@ this )
{
    this.server_setShowHoverNames(false);

    Factions _factions();
    this.set("factions", @_factions);

    RPGRespawns res(this);
    RPGCore core(this, res);
    this.set("core", @core);

    this.SetCurrentState(GAME);
    AddSpawnSigns();
    for(int i = 0; i < getPlayerCount(); i++)
    {
        CPlayer@ p = getPlayer(i);
        if(p !is null)
            p.server_setTeamNum(7);//aka factionless
    }
}

void onInit( CRules@ this )
{
    onRestart( this );
}

void AddSpawnSigns()
{
    if(getNet().isClient())
        return;
    Vec2f[] spawnpoints;
    CMap@ map = getMap();
    if(map !is null)
    {
        map.getMarkers("rpg_spawn", spawnpoints );
        for(uint i = 0; i < spawnpoints.length; ++i)
        {
            CBlob@ b = createSign(spawnpoints[i]+Vec2f(0,8),"Type !help to learn the faction commmands");
            b.Tag("spawnsign");
        }
    }
}