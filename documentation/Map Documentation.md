# Map Documentation

## Structure

#### Summary

The player can be at one Location (node) at once.

An Area is a graph of locations in a predefined structure.

A Segment is a collection of three adjacent areas. There is a "left" area, "middle" area and "right" area which represents their arrangement and which connects to which.

Areas are connected via Bridges, which are special Location nodes that allow a seamless transition between Areas.

A Tavern Area is a collection of Location Nodes that are non-hostile such as shops, blacksmiths, etc. It spans the width of three Areas.

A Territory is a Segment followed by a Tavern Area.

The Map is a sequence of Territories.

#### Presentation

Each location presents their type in their icon. This gives purpose and meaning to the player's choices in where they want to travel.

## Location

#### Types

| Location Type     | Description                                                  |
| ----------------- | ------------------------------------------------------------ |
| Hostile           | A regular hostile encounter where the player must fight      |
| Challenge Hostile | Like a mini boss; a Hostile enemy, but more challenging, with greater reward for the player |
| Shop              | The player may purchase items and sell items - there can be many types, such as potion shops, weapon shops, miscellaneous shops |
| Enhancer          | An upgrade shop, where the player can purchase upgrades for their weapons and armour, as well as repairs |
| Restorer          | The player may purchase the restoration of their health and/or armour |
| Quest             | Provides a quest for the player to complete - by doing a task such as accumulating a certain amount of gold, or going somewhere on the map, or both such as defeating an enemy at a certain location |
| Friendly          | These are just random friendly people, which may do things such as fully heal the player, give gold, offer a specific weapon for purchase, offer a trade such as double health for half their armour, etc. |

