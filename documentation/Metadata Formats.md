[TOC]

#### `jq` Queries

Find all keys of all json files in a directory:

```bash
for file in *.json; do
    jq 'keys' "$file"
done | jq -s 'add | unique' | jq '.[]'
```

Show the JSON of all restorers:

```bash
jq -s 'map(select(.roles | . != null and index("restorer"))) | unique' *.json
```

Show the filenames of all the restorers of the type "all":

```bash
for file in *.json; do
  if jq -e 'select(.type == "all") | .roles | index("restorer")' "$file" > /dev/null 2>&1; then
    echo "$file"
  fi
done
```

# Foes and Bosses

#### Rules.

Foe and boss content IDs always start with **E**. E.g. **E0001**.

#### File structure.

Every file contains just a single object, which contains the data for a single foe/boss.

*Note, if you wish to differentiate between what's a boss and what's a foe, refer to `NPC-DATA-INDEX.json`. This file is what defines what content IDs are a foe, boss, or interactor. If you want a file to represent a boss and a foe, that's possible - you'd just add their content ID to both arrays.*

#### Object structure.

Each foe/boss has the following metadata:

```json
{
    "id": "E0131",
    "code": "f2_masteroftaikwai",
    "name": "Demonwing",
    "description": "",
    "type": "faction2",
    "brute": false,
    "thief": false,
    "acute": false,
    "obtuse": false
}
```

#### Field values.

Possible values:

```
"type": [
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

# Interactors

#### Rules.

Interactor content IDs always start with **N**. E.g. **N0001**.

#### File structure.

Every file contains just a single object, which contains the data for a single interactor.

#### Object structure.

Each interactor has the following metadata:

```json
{
    "id": "N0428",
    "code": "neutral_goldenhammer",
    "name": "Goldhammer Defender",
    "description": "",
    "type": "all",
    "roles": [
        "enhancer"
    ],
    "shopTags": [],
    "restorerTags": [],
    "friendlyTags": [],
    "enhancerTags": [],
    "enemyName": "Goldhammer Defender",
    "enemyType": "divine",
    "brute": false,
    "thief": false
}
```

#### Field values.

Possible values:

```
"type": [
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
"roles": [
	"shop", 
	"friendly", 
	"restorer", 
	"enhancer"
]
"shopTags": [] (ALWAYS EMPTY)
"restorerTags": [
	"health", 
	"armor"
]
"friendlyTags": [
	"sacrifice", 
	"curse", 
	"shop", 
	"trade", 
	"generous"
]
"enhancerTags": [] (ALWAYS EMPTY)
```

# Weapons

#### Rules.

Weapon content IDs always start with **W**. E.g. **W0001**.

#### FIle structure.

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

#### Object structure.

Each weapon has the following metadata:

```json
{
    "weaponName": "Stalactite Lance",
    "weaponProfileTag": "damage",
    "regionProfileTag": "cavern",
    "description": "A long, pointed spear fashioned from a razor-sharp stalactite.",
    "id": "W0001"
}
```

#### Field values.

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

 # Armors

#### Rules.

Armor content IDs always start with **A**. E.g. **A0001**.

#### File structure.

Armor files contain an array of armor pieces, whereby each file represents a region. For instance, `CAVERN-ARMORS.json`:

```json
[
    {
        // Armor A0001
    },
    {
        // Armor A0002
    },
    // ...
]
```

#### Object structure.

Each armor piece has the following metadata:

```json
{
    "armorName": "Grotto Guardian Helm",
    "armorType": "head",
    "armorProfileTag": "heavyweight",
    "regionProfileTag": "cavern",
    "description": "A heavy steel helm with a visor shaped like a bat's face, adorned with glowing crystal fragments.",
    "id": "A0001"
}
```

#### Field values.

```
"armorType": [
	"head",
	"body",
	"legs"
]
"armorProfileTag": [
    "heavyweight", 
    "lightweight"
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

# Accessories

#### Rules.

Accessory content IDs always start with **G**. E.g. **G0001**.

#### File structure.

Accessory files contain an array of accessories, whereby each file represents a region. For instance, `CAVERN-ACCESSORIES.json`:

```json
[
    {
        // Accessory G0001
    },
    {
        // Accessory G0002
    },
    // ...
]
```

#### Object structure.

Each accessory has the following metadata:

```json
{
    "accessoryName": "Obsidian Aegis",
    "accessoryType": "peripheral",
    "accessoryProfileTag": "defensive",
    "regionProfileTag": "cavern",
    "description": "A glossy black shield, forged from volcanic glass, cool to the touch and unyielding.",
    "id": "G0001"
}
```

#### Field values.

```
"accessoryType": [
	"regular",
	"peripheral"
]
"accessoryProfileTag": [
    "defensive", 
    "offensive",
    "gold",
    "health",
    "everything",
    "special"
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

