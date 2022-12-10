# Balance Patches

### Patch 001 [0b11bb4]

* `burnForWeapon` enhance offer content
  * Reduced maximum damage offered and tightened range
    * *Burn is really strong, it stacks and it gets applied immediately the turn it's used effectively being an instance damage potion that is continuously applied - high damage values may be too strong when stacked*
* `BurnStatusEffectEffectPill`
  * Removed price discount
    * *Burn is really strong, it stacks and it gets applied immediately the turn it's used effectively being an instance damage potion that is continuously applied - it doesn't deserve a 30% discount*
* `resistanceForArmor` enhance offer content
  * Reduced minimum damage resistance offered
    * *5% damage resistance seems fine and reduces the probability of getting higher damage resistance values*
* `foeDamageStat`
  * Increased value of 1 foe damage from 0.5 to 0.65
    * *Damage resistance was a little too cheap*

* `buildLootBag`
  * Reduced target value
    * *Loot bags were too generous and made the player OP to easily*
  * Added hard cap of 3 options per loot bag
    * *Looting felt overwhelming and less rewarding when there were too many options, plus it made loot bags a little too strong - this will help reduce the cognitive load of picking loot as well as making rarer items more rewarding (because the overall quality of loot bags is decreased)*
  * Reduced probability of getting weapons and armor
    * *It never felt like weapons had to be used resourcefully because of their abundance, and armor was available too frequently*

* Challenge hostiles
  * Made 1 stage more difficult
    * *They weren't differentiated enough from regular enemies and were more than manageable, rather than actually feeling like mini-bosses*
* Challenge hostile loot
  * Reduced quality by 1 stage
    * *Challenge hostile loot was way, way too good, and essentially set you up for the rest of the area - this along with the loot bag nerf will help remedy this*

* Weapon content
  * Reduced damage of almost all damage-based weapons
    * *Too many weapons had too high damage, causing enemies to often be one shot*
* `buildWeapons`
  * Reduced the number of damage weapons (weapons that just do a standard amount of damage and nothing else) in the loot pool
    * *It felt like I was getting mostly these types of weapons without much variety*

* Foes
  * Buffed foes across the board (and extra for goblins)
    * *Enemies in general felt like they didn't do enough damage and died a little too easy, and goblins felt easier than standard enemies (probably because they were)*