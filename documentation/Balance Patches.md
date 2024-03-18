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

### Patch 003

* `ContentManager`
    * Nerfed challenge hostile stats and loot (now they just are equivalent to fighting an enemy from the next stage)
        * *The enemies were just ridiculous, like if you had to face one most of the time you were blown out the water. Additionally, the loot was unbalanced, if you're getting a piece of armor or a weapon from 3 stages in the future its just a bit ridiculous and can sway the game too heavily*
* `Foes`
    * Reduced health and damage across the board
        * *Enemies were starting with absurd amounts of health and attack, and it was just a massive delta between starting with nothing then getting OP stuff - loot and equipment has been adjusted as a counterbalance as described below*
* `WarriorClass`
    * Reduced starting health to 200 (from 300)
        * *Accounting for nerfed hostiles*
* `Friendlies`
    * Reduced base damage of dragon slayer sword to 200 (from 300)
        * *Accounting for nerfed hostiles, but also geez 300 base damage was nuts*
    * Buffed shiv damage to 50 (from 15)
        * *15 was so weak it was humiliating*
    * All-weapons buff now has a base damage buff of 30 (from 50)
* `Accessories`
    * Reduced magnitude values (not percentage-based values) across the board (except for gold-buff accessories)
        * *Accounting for nerfed hostiles - gold accessories unaffected because honestly they need the help*
* `BonusHealthConsumable`
    * Reduced bonus health amount for tier 3 and 4 to 80 and 150 (from 100 and 200)
        * *Accounting for nerfed hostiles, also it was a bit OP to get a tier 4 bonus health consumable*
* `LootOptionsFactory`
    * Now 2/3 bags get an extra bit of bonus gold on top
        * *Because we want the player to build up gold over time naturally (without having to explicitly collect it), add a bit of gold to most bags. It's also fun and thematic to get a bit of gold. What can happen otherwise is the player just never collects any gold because they're too busy collecting vital loot like armour - this means shops and enhancers become useless and become things to avoid instead of things to target*
    * Added a hard cap on weapons - loot bags are not allowed to contain more than a single weapon
        * *Too many weapons is unhealthy for the game, because unlike armour and accessories, you can keep collecting them infinitely instead of having to replace them*
* `PotionFactory`
    * Reduced probability of getting damage potions, damage percent potions, health restoration percent potions, weakness potions
        * *Damage potions are good but really shouldn't outshine health potions, which actually has a more important purpose of keeping the player alive over time. The "percent buff" potions are cool on occasion but are overwhelming if you have too many and aren't fun to use frequently.*
* `ConsumableFactory`
    * Reduced probability of getting damage buff and restore buff consumables
        * *Same reason "percent buff" potions were reduced*
* `EnhanceOffers`
    * Reduced damage increase for grow damage for weapon upgrade
        * *Weapons that grow in damage after every attack are very dangerous*
* `Weapons`
    * Minor adjustments to weapon damages and stats across the board based on intuition
        * *I didn't decrease the damage of most of them despite the foe nerfs because it was already an issue that a lot of the time the weapons weren't strong enough - will monitor this*
    * Reduced weapon durabilities across the board
        * *Weapons were lasting too long. It meant I'd accumulate too many weapons, but also weapons like acute damage weapons with 200+ damage would be way too strong.*
* `Armors`
    * Reduced armor across the board
        * *Accounting for nerfed hostiles*
* `WeaponFactory`
    * Reduced probability of getting a pure healing/armour restoration weapon
        * *Not as useful as damage weapons, you don't want to be getting them too frequently - if you get like 2 in a row you basically get screwed a lot of the time*
* `Pricing`
    * Adjusted pricing for all the nerfs/buffs/adjustments
    * Reduced the price of many things - for example, player damage and player permanent and bonus health was way over valued
* `BuffApps`
    * Added a maximum price discount of 75% off so items can't be impossibly cheap or free

 