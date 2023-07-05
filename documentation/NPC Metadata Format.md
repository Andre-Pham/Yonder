# Foes

Foe content IDs always start with **E**. E.g. **E0001**.

File structure:

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

Possible values:

```
"type": [
	"all", "desert", "cavern", "faction5", "faction6", "dungeon", "faction2", 
	"faction4", "nether", "shadow", "mech", "forest", "none", "frost"
]
```

# Interactors

Interactor content IDs always start with **N**. E.g. **N0001**.

File structure:

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

Possible values:

```
"type": [
	"all", "desert", "cavern", "faction5", "faction6", "dungeon", "faction2", 
	"faction4", "nether", "shadow", "mech", "forest", "none", "frost"
]
"roles": ["shop", "friendly", "restorer", "enhancer"]
"shopTags": [] (ALWAYS EMPTY)
"restorerTags": ["health", "armor"]
"friendlyTags": ["sacrifice", "curse", "shop", "trade", "generous"]
"enhancerTags": [] (ALWAYS EMPTY)
```

