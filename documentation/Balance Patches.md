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

### Patch 002 [0b11bb4]

* `buildLootPool`
  * Adjusted weapon frequency to what it was previously
  * Reduced probability of getting potions and consumables
    * *I was receiving too many consumables/potions, and they would build up in my inventory while I was lacking the other types of loot*
  * Increased gold added to loot bags
    * *The amount of gold I was receiving per lootbag was making it difficult to save*
* `DamagePotion.Tier`
  * Decreased damage potion damage for all tiers
    * *Damage potions were a bit too strong since they could kill enemies without causing an end of turn, meaning the player wouldn't be attacked and buffs lasted forever*
* `Foes`
  * Slightly increased foe health for most foes
  * Foe health now scales a lot more per stage
    * *Foes could not keep up with the rate the player would improve. While everything the player equipped would improve by, say, 20%, this would cause the player as a whole to be a lot more than 20% stronger than what they started at*
* `newRestorer`
  * Increased the minimum price for health/shields restoration
    * *Sometimes it would just be ridiculously cheap to heal a lot*
* `Weapons`
  * Increased damage durability across the board
    * *I found myself having no weapons for the majority of the playthrough - I was getting weapons, they were just being used up way too quickly, sometimes within a single battle*
* `Pricing`
  * Reduced the value of 1 player damage to $0.7
    * *Player damage was very expensive, often not being worth the investment, for example buying damage upgrades.*
  * Reduced the "infinite duration" constant to 22
    * *Items that lasted forever were much too overvalued*
* `PotionFactory`
  * Decreased potions stacks
    * *I was getting too many of each potion*
* `weaponDamageOrPotionCountFriendly`
  * Increased offered weapon damage upgrade
    * *I didn't own as many weapons simultaneously as I expected, so the obvious option was always potions*
* `freeItemsFriendly`
  * Reduced number of free potions/consumables
    * *The offer was ridiculous, I would receive way too many of each*
* `FoeFactory`
  * Reduced the frequency of goblins
    * *Encountering too many goblins made saving difficult while making restoration items useless*
  * Slightly increased frequency of brutes
    * *Previously you were almost twice as likely to find a goblin over a brute which felt unbalanced*