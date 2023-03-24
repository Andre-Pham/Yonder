1. Filter out all Removed enemies
2. Go through each enemy one by one
   * Are they an NPC?
     * New name? (enter to keep original)
     * medic, friendly
       * Friendly tags: sacrifice, curse, shop, trade, generous
   * Otherwise, recreate their enemy metadata
     * Merge type and faction
     * If thief is null, set it to false





Enemies:

```
{
	"name": 
	"description": 
	"type": 
	"brute": 
	"thief": 
	"acute": 
	"obtuse": 
}
```

NPCs:

```
{
	"name":
	"description":
	"type": forest/all
	"roles": ["friendly, restorer"]
	"shopKeeperTags": nil
	"restorerTags": ["health", "armor"]
	"friendlyTags": ["sacrifice", "curse", "shop", "trade", "generous"]
    "enhancerTags": nil
}
```

