You are my fellow rpg game designer. You are going to help me create content for my game. We are going to be creating some armors for my rpg game. Armors are composed of a piece for the head, body, and legs. First you must understand a few things.

Every armor piece has a "armorProfileTag" (armor profile tag). There are two options. This is the full list of available options:

1. heavyweight: Armor that focuses on being heavy and defensive, such as an iron chest-plate
2. lightweight: Armor that focuses on being light and provide bonuses, such as a hooded cloak

Every armor piece also has a "regionProfileTag" (region profile tag). This will be discussed later, but essentially it's the area the armor piece is found, such a forest, or desert, or dungeon.

Here are some examples of armors I expect. It's in JSON format.

```
{
    "armorName": "Vineguard Mail",
    "armorType": "body",
    "armorProfileTag": "lightweight",
    "regionProfileTag": "forest",
    "description": "A lightweight chestplate interwoven with living vines."
},
{
    "armorName": "Thornbark Helmet",
    "armorType": "head",
    "armorProfileTag": "lightweight",
    "regionProfileTag": "forest",
    "description": "A helmet crafted from thick bark and thorns."
},
{
    "armorName": "Fernmantle Robe",
    "armorType": "body",
    "armorProfileTag": "lightweight",
    "regionProfileTag": "forest",
    "description": "A robe adorned with fern patterns that glow with a soft, healing light."
},
```

You've probably noticed that armor doesn't actually have to be effective at protecting the user from physical attacks, it's just equipment the user wears on their head/body/legs. It can be a range of equipment, from iron plating, to robes and hoods, to crowns, and more. Use your imagination! The only exceptions are that it can't be a minor accessory like a ring, and it can't be for other parts of the body like gloves or shoes.

Does this all make sense?





Great. Before we start, I have some rules I want you to follow. First, each description must be at most one sentence. No more than one! It should be kept relatively brief. Two, each description should be almost entirely visual. If you had an armor piece called "Thornbark Helmet", a perfect description would be "A helmet crafted from thick bark and thorns with small antlers extruding from the sides". I also want you to understand that while heavyweight armor pieces are focused on being heavy and physically protective, the lightweight armors tend to be more magic or bonus focused - they're not a weaker version of the heavyweight armors, they just grant special effects that protect the user in other ways. This means you can get pretty creative with them. Some final rules. Try to make it obvious what part of the body the armor belongs to (head/body/legs), calling something "obsidian defence" could make it ambiguous to where the equipment belongs. And finally no including equipment that aren't typically part of RPGs that are commonly worn in the real world - this means no turbans, no caps, etc. Understood?





Let's start with "cavern" armor pieces. These are armor pieces that exist in both shallow and deep underground caverns. We're going to do each armor type. Let's start with head armor pieces. Please create 10 heavyweight head armor pieces of these in the provided JSON format I previously gave.

> Let's start with Songhai Empire weapons. These are based off the Songhai Empire faction from the Duelyst game. We're going to do each weaponProfileTag. Let's start with damage. Please create 10 of these in the provided JSON format I previously gave.



Continuing on, now do 10 lightweight head armor pieces. 



Continuing on, now let's do body armor pieces. We'll again start with 10 heavyweight armor pieces.



Continuing on, now do 10 lightweight body armor pieces.



Continuing on, now let's do legs armor pieces. We'll again start with 10 heavyweight armor pieces.



Finally, let's finish off with the 10 lightweight legs armor pieces.