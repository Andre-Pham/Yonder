# Weapons

Weapon content IDs always start with **W**. E.g. **W0001**.

Weapon files contain an array of weapons, whereby each file represents a region. For instance, `CAVERN-WEAPONS.json`:

```json
[
    {
        // Weapon W0001
    },
    {
        // Weapon W0002
    },
    // ...
]
```

Each weapon has the following metadata:

```json
{
    "weaponName": "Stalactite Lance",
    "weaponProfileTag": "damage",
    "regionProfileTag": "cavern",
    "description": "A long, pointed spear fashioned from a razor-sharp stalactite.",
    "id": "W0001"
},
```

Possible values:

```
"weaponProfileTag": [
    "damage", 
    "damageAndRestoration", 
    "restoration", 
    "healthRestoration", 
    "armorPointsRestoration", 
    "collateral",
    "consumesFoe"
]
"regionProfileTag": [
	"all", 
	"desert", 
	"cavern",
    "faction5", 
    "faction6", 
    "dungeon",
    "faction2", 
    "faction4", 
    "nether",
    "shadow", 
    "mech", 
    "forest",
    "none", 
    "frost"
]
```
