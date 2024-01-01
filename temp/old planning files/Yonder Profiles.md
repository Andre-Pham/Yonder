# Weapons

Weapons can have multiple tags, and as long as one matches a profile may be selected.

```swift
case damage
case damageAndRestoration
case restoration
case healthRestoration
case armorPointsRestoration
case collateral // E.g. converts health into shields, self damaging, and burning effects
case consumesFoe // E.g. taking or copying their attack, or lifesteal
```

| Name                    | Description                                                  | Tags |
| ----------------------- | ------------------------------------------------------------ | ---- |
| Shadowflame Gauntlet    | A powerful gauntlet imbued with dark and fiery magic, capable of unleashing a barrage of searing shadow flames at enemies. |      |
| Shadowburn Gauntlet     | A deadly gauntlet that channels dark, shadowy energy into deadly blasts of pure force, capable of incinerating enemies on contact. |      |
| Temporal Gauntlet       | A powerful gauntlet imbued with the ability to slow time to pursue devastating blows. |      |
| Enchanted Gauntlet      | A magical gauntlet imbued with powerful enchantments, capable of enhancing the user's physical abilities and allowing them to cast a wide range of spells. |      |
| Fractured Gauntlet      | A powerful gauntlet made of shattered shards of a mysterious, otherworldly metal. It resonates dark energy. |      |
| Inferno Gauntlet        | A powerful gauntlet imbued with fiery magic, capable of unleashing scorching blasts of flame and engulfing enemies in flames. |      |
| Gauntlet of Purity      | A holy gauntlet imbued with powerful purifying magic, it radiates warm mystical light. |      |
| Frost Gauntlet          | A gauntlet imbued with ice magic, capable of freezing enemies solid and coating the battlefield in a layer of slippery ice. |      |
| Dual Iron Blades        | A pair of twin swords crafted from iron, capable of striking quickly and delivering devastating blows to enemies. |      |
| Dual Steel Blades       | A pair of steel swords, sharpened to slice through even the toughest armor. |      |
| Duel Shadowflame Blades | A pair of swords crafted from dark, enchanted steel and imbued with shadow and flame magic, capable of unleashing powerful blasts of energy against enemies. |      |
| Duel Shadowburn Blades  | A pair of swords that can channel shadowy energy into deadly blasts of force, capable of incinerating enemies on contact. |      |
| Iron Blade              | A single, long sword crafted from iron, capable of delivering powerful, sweeping strikes against enemies. |      |
| Ironbark Blade          | A single-edged blade carved from ironbark, it's both lightweight, durable and capable of slicing through even armored foe. |      |
| Steel Blade             | A single sword crafted from steel, known for its sharp edge and deadly efficiency in combat. |      |
| Blade of the Forest     | A unique sword charged with the power of nature, forged from vines, roots, and other natural elements to bound the nature's spirit. |      |
| Bronze Blade            | A single sword crafted from bronze, known for its durability and resistance to corrosion, making it an ideal weapon for use in harsh environments. |      |
| Inferno Blade           | A sword equipped with a blazing hot blade engulfed in flames that can set enemies ablaze with each strike. |      |
| Frost Blade             | A blade made of enchanted ice that can freeze enemies with each striking blow. |      |
| Eternos Blade           | The Eternos Blade is a weapon that is imbued with the power of time. It has a blade that can manipulate time itself, allowing the wielder to strike multiple times in the span of a single moment. |      |
| Tes Blade               | A blade that crackles with electricity and can shock enemies with each strike. A field of charge is generated around it when wield. |      |
| Malis Blade             | Cast out of darkness, the shadowy blade can drain the life force from enemies with each strike. |      |
| Blessed Blade           | Cast from holy magic, the shining blade can smite evil and heal the wielder with each strike. |      |
| Cursed Blade            | Cast from curse magic, the blade siphons the mind of its victims. |      |
| Fractured Blade         | A blade that was shattered, its pieces are bound together by gravitational forces. Its source, history and reasoning is unknown. |      |
| Hero's Blade            | The Hero's Blade is a weapon that is wielded by heroes who have proven themselves in battle. It has a blade that shines with the light of righteousness and can cut through any obstacle. |      |
| Warrior's Blade         | A sturdy, reliable sword that has been passed down through generations of warriors. It is well-balanced and sharp, making it a formidable weapon in battle. |      |
| Blackruby Blade         | A sleek and deadly sword with a black handle and a ruby embedded in the hilt. The blade itself is made of a dark sinister metal that appears to absorb light. |      |
| Dragonbone Blade        | Crafted from the bones of a dragon, the blade is incredibly strong and sharp, and is said to be imbued with the spirit of the dragon from which it was made. |      |
| Mythril Blade           | A light and agile sword made of mythril. It is said to be able to cut through any substance, and is favored by skilled swordsmen who value speed and precision in combat. |      |
| Blessed Tome            | This ancient book is filled with holy writings and powerful spells that can be used to vanquish evil. Blessed by great casters, its pages glow with a holy light when used in battle. |      |
| Cursed Tome             | This dark and sinister book is filled with forbidden knowledge and malevolent spells that can be used to inflict pain and suffering upon others. Its mere presence can cause feelings of unease and dread. |      |
| Caster's Tome           | This thick and heavy book is filled with arcane knowledge and complex spells that can be used to bend the elements to the caster's will. It is said to be favored by powerful magic users, and its pages are filled with intricate diagrams and incantations. |      |
| Arcane Tome             | This ancient tome is filled with mysterious and powerful spells that have been passed down through the ages. Those who are capable of wielding it are capable of tapping into incredible magical power. |      |
| Enchanted Tome          | This ancient book is imbued with powerful magical energy, its pages glow with a magical violet light, and the spells within can be unleashed with devastating force. |      |
| Temporal Tome           | Its pages are filled with complex spells that can be used to speed up or slow down time, warping forces around its target. |      |
| Shadowflame Tome        | This dark and malevolent book is filled with powerful shadow magic that can be used to engulf enemies in searing flames. Its pages are made of blackened parchment, and they burn with an otherworldly fire when the spells within are cast. |      |
| Shadowburn Tome         | Shadowburn Tome: This ancient tome is said to be filled with powerful shadow magic that can be used to burn away the very essence of an enemy. |      |
| Tome of Healing         | This ancient book is filled with powerful spells that can be used to heal the wounded and restore the vitality of the living. Its pages are filled with glyphs of herbs, flowers, and other natural elements, and they glow with a gentle, soothing light when the spells within are cast. |      |
| Tome of Pain            | This blood-fused book is filled with malevolent spells that can be used to inflict suffering and death upon others. Its pages glow with a twisted, malevolent light when the spells within are cast. |      |
| Tome of Nature          | This ancient book is filled with powerful spells that can be used to control and manipulate the natural world. Its pages are filled with images of plants, animals, and other natural elements, and they glow with a vibrant, life-giving light when the spells within are cast. |      |
| Tome of Life            | This ancient tome is said to hold the secrets of life itself. Its pages are filled with intricate diagrams and complex spells that can be used to restore life, and they glow with a warm, nurturing light when the spells within are cast. |      |
| Tome of Sacrifice       | This abandoned tome is engraved in blood with spells of sacrifice and destruction. The user experiences great anguish and self-destruction as a price for the immense power this unleashes. |      |
| Darkblood Tome          | This ancient tome is said to be imbued with the power of dark, malevolent magic. Its pages are made of parchment that has been steeped in the blood of dark creatures, and they glow with a twisted, crimson light when the spells within are cast. |      |
| Siphoning Tome          | This ancient book is said to hold the power to drain the life energy from others. Its pages are filled with intricate spells that can be used to siphon the life force from enemies. |      |
| Divine Staff            | A staff imbued with powerful holy magic, where its mere presence can strike fear into the hearts of evil beings. Its golden shaft is topped with a glowing orb that shines with a holy light. |      |
| Cursed Staff            | This dark and twisted staff is said to be cursed by its own creator. Its blackened shaft is topped with a sinister-looking crystal that glows with a malevolent light. |      |
| High-order Staff        | This powerful staff is said to be favored by high-ranking magic users. Its ornately-carved shaft is topped with a glowing gemstone that shines with a brilliant light. |      |
| Nature's Staff          | This elder staff is made of wood from a sacred tree, and its mere presence can inspire feelings of tranquility and peace. Its wooden shaft is topped with a crystal that glows with a warm, nurturing light. |      |
| Arcane Staff            | This pristine staff is equipped with an ornately-carved shaft, and is topped with a glowing gemstone that shines with a brilliant light, and its mere touch can unleash devastating spells. |      |
| Soulstealer Staff       | This twisted staff is said to have the power to steal the very souls of its victims. The short twisted rod twirls with darkness when it drains the life from its victims. |      |
| Temporal Staff          | This rare staff has an intricately-carved shaft is topped with a glowing crystal that shines with a temporal energy, and its mere touch can speed up or slow down time. |      |
| Shadowflame Staff       | This ancient dark staff is topped with a crystal that glows with an otherworldly shadowfire, and its mere touch can unleash devastating spells. |      |
| Shadowburn Staff        | This ancient staff is said to be imbued with powerful shadow magic that can be used to burn away the very essence of an enemy. Castings fire a bolt of entwined flame and shadow. |      |
| Healing Staff           | This ancient staff is imbued with powerful healing magic, topped with a crystal that glows with a warm, nurturing light, where its mere touch can heal the wounded and restore vitality. |      |
| Staff of Corruption     | This unstable staff appears to be in an unbalanced state of constant self destruction and recreation. It's castings have the power to corrupt and twist the minds of its victims. The fractured orb at the tip of the staff can cause its victims to fall under its dark, corrupting influence from mere touch. |      |
| Staff of Life           | This divine staff is imbued with powerful life-giving magic, and its mere presence can inspire feelings of vitality and rejuvenation. It's forged of a green-tinted metal. |      |
| Staff of Sacrifice      | This ancient staff has a grim, twisted shaft with a blood-orb at its end engulfed in dark shadows. Casting causes great anguish as fuel for the immense power this unleashes. |      |
| Darkblood Staff         | This distorted staff pulses with blood energy. It's castings are capable of sapping the lifeforce from its victims. |      |
| Staff of Siphoning      | This tall, lightweight staff boasts a glowing red crescent at its peak. Draining the life out of enemies extracts visible crimson arcs from the victim. |      |
| Arcane Bracelet         | A golden bracelet capable of casting arcane missiles towards a target. |      |
| Enchanted Bracelet      | A shimmering violet bracelet capable of casting disks of fractured light towards a target. |      |
| Temporal Bracelet       | A bracelet made of a wood and cobalt blend capable of warping time to unleash great forces towards a target. |      |
| Shadow Bracelet         | A pulsating bracelet of seemly materialised shadow. It is capable of launching shadow-orbs towards a target. |      |
| Shimmering Bracelet     | A bracelet that glimmers even in darkness, it's capable of directing light towards a target, blinding and burning them. |      |
| Iron Longsword          | This long, straight sword is made of iron and is incredibly sturdy and durable. Its double-edged blade is capable of delivering powerful, slashing blows, and its hilt is wrapped in sturdy leather for a secure grip. |      |
| Iron Shortsword         | This shorter sword is made of iron and is incredibly sturdy and durable. Its double-edged blade is capable of delivering quick, precise thrusts, and its hilt is wrapped in sturdy leather for a secure grip. |      |
| Steel Longsword         | A longsword forged out of steel by a master blacksmith. Its strong, sharpened blade can deliver powerful, slashing blows. |      |
| Steel Shortsword        | A shortsword forged out of steel by a novice blacksmith. Its hilt has additional steel spikes for additional lethality. |      |
| Obsidian Greatsword     | This massive sword is made of obsidian, a rare and incredibly hard black volcanic glass. Its razor-sharp blade is capable of delivering devastating blows, and its hilt is carved from a single piece of polished obsidian for a secure grip. |      |
| Cursed Longsword        | This sinister sword is said to be cursed by dark magic. Its blade is twisted and jagged, and its hilt is adorned with dark, malevolent symbols. |      |
| Ironwood Longsword      | This longsword is made of ironwood, a rare and incredibly strong wood that is said to be impervious to rot and decay. Its blade is sharp and sturdy. |      |
| Cursed Shortsword       | This dark and twisted short sword is said to be cursed by dark magic. Its blade is jagged and serrated. |      |
| Ironwood Shortword      | This short sword is made of ironwood, a rare and incredibly strong wood that is said to be impervious to rot and decay. Its blade is sharp and sturdy. |      |
| Blackruby Longsword     | This elegant longsword is adorned with a massive black ruby at its hilt. Its blade is sharp and polished to a mirror finish, and its hilt is crafted from gleaming silver. |      |
| Dragonbone Shortsword   | This short sword is made of dragonbone, a rare and incredibly strong material that is said to be able to withstand even the most powerful blows. |      |
| Mythril Longsword       | This longsword is made of mythril, a rare and incredibly strong silver-like metal. Its blade is sharp and polished to a mirror finish, and its hilt is adorned with intricate, mythical designs. |      |
| Mythril Shortsword      | This short sword is made of mythril, a rare and incredibly strong silver-like metal. Its blade is sharp and polished to a mirror finish, and its hilt is adorned with intricate, mythical designs. |      |
| Battleaxe               | This massive axe is designed for warfare and is capable of delivering devastating blows. Its sharp, double-bladed head is mounted on a sturdy haft, and its hilt is wrapped in sturdy leather for a secure grip. |      |
| Mythril Battleaxe       | This battleaxe is made of mythril, a rare and incredibly strong silver-like metal. Its double-bladed head is sharp and polished to a mirror finish, and its hilt is adorned with intricate, mythical designs. |      |
| Inferno Battleaxe       | This massive axe is engraved with flaming glyphs, and its double-bladed head is surrounded by flickering flames, with its hilt carved from blackened steel. |      |
| Frost Battleaxe         | This massive axe has a double-bladed head surrounded by a swirling, icy mist and a hilt carved from frozen steel. |      |
| Darkblood Battleaxe     | A completely deformed axe with blackened and twisted edges, it has begun to no longer resemble an axe. |      |
| Dragonbone Battleaxe    | This massive axe is made of dragonbone, a rare and incredibly strong material that is said to be able to withstand even the most powerful blows. |      |
| Broken Battleaxe        | This battered and broken axe is a testament to the hardships of battle. Its double-bladed head is chipped and dented, and its hilt is splintered and cracked. Despite its worn and damaged state, it is still a formidable weapon, capable of delivering powerful blows. |      |
| Warrior's Battleaxe     | This massive axe is said to have been wielded by a legendary warrior. It has an engraving - "LX". |      |
| Iron Mace               | This sturdy mace is made of iron and is capable of delivering powerful, crushing blows. |      |
| Mythril Mace            | This mace is made of mythril, a rare and incredibly strong silver-like metal. Its head is topped with a spiked cube forged in great precisions. |      |
| Guard's Spear           | This sturdy spear is said to have been wielded by the guards of a great kingdom in battles of old. Its sharp, pointed head is mounted on a sturdy haft, with an engraving of some mythical creature. |      |
| Darkblood Spears        | Dual spears with darkblood gems at both ends. They are shorter than standard spears, and create shadowed streaks from the tips. |      |
| Warhammer               | This massive, heavy weapon is designed for smashing through armor and shields. Its head is forged from metal clumps of various kinds. |      |
| Mythril Warhammer       | A warhammer of great proportions, made of mythril, a rare and incredibly strong silver-like metal. |      |
| Blacksmith's Warhammer  | A sturdy warhammer, its sheer weight makes it cumbersome to lift. It's forged from an unidentifiable metal of immense strength and durability. |      |
| Ogre's Warhammer        | This large, heavyweight warhammer was created to be used by infant ogres. It still manages to outsize your proportions. |      |
| Stealth Dagger          | This slender, curved dagger is designed for stealth and speed. Its blade is sharp and curved, and its hilt is wrapped in supple leather. |      |
| Bone Dagger             | This slender, curved dagger is made of bone, and its sharp, curved blade is said to be able to cut through even the toughest armor. |      |
| Thief's Dagger          | Used by thieves in the darklands, its concealed design makes it perfect for quick surprise attacks. |      |
| Rogue's Dagger          | This slender, straight dagger's small size and light weight make it an excellent weapon for rogues and assassins. |      |
| Tomb Dagger             | A serrated dagger used by tomb raiders, its made of sharpened bone and ironwood. |      |
| Ironwood Dagger         | A duel-ended dagger formed of ironwood, a rare and incredibly strong wood that is said to be impervious to rot and decay. |      |
| Poisoned Dagger         | A small and deadly dagger with a curved blade coated in a deadly poison, capable of delivering a swift and stealthy kill. |      |
| Blessed Greatsword      | A massive and imposing sword imbued with holy magic, forged to slay enemies of the dark arts. |      |
| Nightblade              | A blade made of a black, glossy metal that seems to absorb light, giving it a shadowy appearance. |      |
| Lich's Scythe           | This razor-edged scythe is said to have belonged to a powerful Lich, a being of immense magical power and malevolent intent. The weapon is made of a pale, bone-like material, and the curved blade is inscribed with strange, glowing runes. |      |
| Ogre Club               | This large, unwieldy club was created to be used by infant ogres. You must build momentum to even manage a swing. |      |
| Ironbark Club           | A slim club carved from ironbark, it's capable of delivering swift but potent blows to those who intercept its swing. |      |
| Spirit Lance            | A long, slender lance with a shimmering, ethereal blade that seems to glow with otherworldly energy. The handle is made of a smooth, polished crystal that is cool to the touch. |      |
| Lionheart Blade         | This mighty sword is said to have belonged to a great hero who was known for his courage and strength. The hilt is made of gold and is intricately carved with the image of a roaring lion, symbolizing the hero's bravery and ferocity. |      |
| Dragonlance             | This weapon is wielded by great dragon slayers. It is a long and sturdy spear with a razor-sharp tip that is capable of piercing even the thickest scales. Its metal shines with a fierce, fiery energy. |      |
| Duskblade               | This elegant sword is favored by warriors who prefer to strike from the shadows. It is a slender blade with a curved, swept-hilt design that is perfect for quick, deadly strikes. |      |
| Bloodied Axe            | This brutal weapon is equipped with jagged, serrated blades that are capable of tearing through flesh and bone with ease. |      |
| Void Staff              | This ancient and mysterious staff harnesses the power of the void. The staff is made of a shimmering, otherworldly material that seems to shift and swirl with dark, ethereal energy. |      |
| Void Tome               | A black tome enchanted with void spells. Casting unleashes dark ethereal energy onto the victim. |      |
| Forsaken Greatsword     | This massive sword is said to have been abandoned by its previous wielder, a powerful but evil warrior who fell in battle. It has an engraving - "BX". |      |
| Tidal Blade             | A long and elegant sword with a curved, flowing design that is perfect for cutting through water. The blade is made of a shimmering, iridescent metal that seems to sparkle and glint in the light. |      |
| Tidal Gauntlet          | It is made of a shimmering, iridescent metal that seems to sparkle and glint in the light, and it is covered with sharp, jagged spikes that are capable of tearing through armor and scales with ease. |      |
| Molten Sword            | This fiery weapon is said to have been forged in the heart of a volcano. The blade leaves molten metal into whatever it pierces. |      |
| Molten Lance            | The lance is long and sturdy, with a sharp, jagged tip. The shaft is made of a strong, heat-resistant material, and the lancehead is fashioned from a glowing, molten metal that seems to burn with an intense, fiery energy. |      |
| Molten Outcast          | This weapon is said to have been wielded by a powerful warrior who was cast out from their tribe for their greed and betrayal. It is a massive, double-headed axe with jagged, serrated blades that drip molten rock. |      |
| Soulshard               | A unique and mysterious weapon that resembles a small crystal shard, capable of siphoning the life force of enemies and transferring it to the wielder. |      |
| Flamewrath              | A hilt that at will, can emit a great blazing flame to form a blade of pure flaming energy. The beaming flame illuminates the wielder's entire surroundings in a warm flickering glow. |      |

# NPCs

| Name               | Description | Area Tags |
| ------------------ | ----------- | --------- |
| Dryad [name]       |             |           |
| Druid [name]       |             |           |
| Travelling Warrior |             |           |
| Travelling Caster  |             |           |
| Bearclan Scout     |             |           |
| Bearclan Merchant  |             |           |
| Satyr              |             |           |
| Dwarf              |             |           |
| Nymph              |             |           |

# Hostiles

Foes can have multiple tags, and as long as one matches a profile may be selected.

**I should add a test to ensure there is at least 6 of every single (tag + area tag) combination.**

```swift
case regular
case regularObtuse
case regularAcute
case goblin
case goblinObtuse
case goblinAcute
case brute
```

| Name                 | Description                                                  | Tags                  | Area Tags                                |
| -------------------- | ------------------------------------------------------------ | --------------------- | ---------------------------------------- |
| Goblin Scout         | A small, sly goblin that scouts ahead and gathers information for its tribe. It is agile and quick, and is armed with a short sword. | goblin                | neutral                                  |
| Aggro Goblin         | A goblin with red in its eyes equipped with two razor daggers. It's small but leaps on its foe flurrying its blades. | goblinAcute           | neutral                                  |
| Goblin Runt          | A smaller goblin that gets by with more cunning strategies. It keeps many little contraptions in its satchel. | goblin                | neutral                                  |
| Cavern Goblin        | A goblin that lurks in the underground. It is adapted to life in the dark, and is skilled at ambushing its enemies. | goblin, goblinObtuse  | cave                                     |
| Snatcher Goblin      | In tattered clothes, this goblin creeps up on all fours then leaps on its victim, slashing at their eyes before snatching their precious items. | goblin, goblinAcute   | swamp, ruins, cave                       |
| Screecher Goblin     | Found in the mountain tops, these goblins screech at high pitches when attacking or threatened. They uniquely wear tattered fur coats to survive the cold. | goblinAcute           | mountain                                 |
| Stone Goblin         | A goblin known for its rock-like skin, it's capable of both camouflage and  enduring more powerful blows. | goblin, goblinObtuse  | rock                                     |
| Plague Goblin        | A putrid goblin with skin deformities, these infect any victim they can by expelling on them from their drooling mouths. | goblinAcute           | swamp, vegetation                        |
| Hill Goblin          | A goblin that dwells near mountaintops, they are generally more intelligent and organized than other goblin types, and are skilled at setting traps and ambushes. | goblin                | mountain                                 |
| Forest Goblin        | A goblin well adapted to the forest environment, they are capable of quickly scaling trees to escape or attack from. | goblin                | vegetation                               |
| Goblin Berserker     | A goblin that has become unhinged in battle, driven by a frenzied desire to kill and destroy. It has no weapons, and instead uses its extended sharp claws. | goblinAcute           | neutral                                  |
| Goblin Behemoth      | A massive goblin that towers over other goblin types. It is incredibly strong and durable, and is equipped with heavy armor. | goblinObtuse          | neutral                                  |
| Lumbering Goblin     | A goblin that is larger and slower than other goblin types, but is also more durable. It carries a tower shield but ends up swinging it at foes rather than blocking. | goblinObtuse          | neutral                                  |
| Marsh Goblin         | A goblin that lives in marshy or swampy areas. It is adapted to life in humid, wet environments, with its ability to swim and skin that resembles that of a wrinkly frog. | goblin                | swamp                                    |
| Loot Goblin          | A small nimble goblin with long arms entranced by looting. It will slash at its foe with a carved dagger while taking whatever is in its reach. | goblin                | neutral                                  |
| Heaving Goblin       | A fat goblin that can take a lot more hits than other goblin types, albeit while having slower and less impactful blows. | goblinObtuse          | neutral                                  |
| Undead Goblin        | A slain goblin raised from the dead. The undead serve their lord to infest the lands. | goblin, goblinObtuse  | undead                                   |
| Flesh Goblin         | A goblin long outcast from its tribe, its exposed flesh and sickly body gives it a ghoul-like appearance. Its sanity is bygone as it ravages the land. | goblin                | undead, dark, cave, swamp, ruins         |
| Darktooth Ghoul      | A gnarled and twisted undead creature with jagged teeth and mottled skin. Its eyes emit a dim blood-red light, and it seems to be able to move with surprising speed and agility for its decayed form. | regular, regularAcute | dark, undead                             |
| Flesheating Ghoul    | A hulking undead monstrosity with torn and ragged flesh hanging from its bones. It seems to be driven by an insatiable hunger, and will attack any living being it encounters with frenzied savagery. Its powerful jaws and claws can easily tear through armor and flesh. | regular, regularAcute | dark, undead                             |
| Ghoul Berserker      | A wild and uncontrolled undead creature with a frenzied and bloodthirsty demeanor. Covered in scars and wounds, it will attack anything in its path with reckless abandon. | regular, regularAcute | dark, undead                             |
| Dark Ghoul           | A shadowy undead creature with glowing eyes and a wickedly sharp set of teeth. | regular, regularAcute | dark, undead                             |
| Frothing Ghoul       | A twisted and diseased undead creature with a frothing mouth. It seems to be driven by an insatiable hunger, and will attack anything it encounters with a frenzied and relentless ferocity. | regular, regularAcute | dark, undead                             |
| Crazed Ghoul         | An undead creature covered in sores and pustules that seems to be driven by an uncontrolled madness. It attacks with a frenzied and erratic energy. | regular, regularAcute | dark, undead                             |
| Jeremy               | He says his name is Jeremy. You surely can't trust him - he looks evil. | regular               | ruins, dark                              |
| Shadow Stalker       | A shadowy creature that lurks in the darkness, waiting to strike at unsuspecting travelers. It can move silently and quickly, and its attacks are deadly. | regularAcute          | dark                                     |
| Frost Elemental      | A being made entirely of ice, with a body that shimmers and glows with an otherworldly light. It is immune to cold and can unleash powerful blasts of frost on its enemies. | regularObtuse         | ice                                      |
| Fire Elemental       | A being of pure flame and heat, with a body made up of swirling flames and molten magma. It is able to control and manipulate fire, and has no hesitation to destruction and chaos. | regularObtuse         | heat                                     |
| Water Elemental      | A being made entirely of water, with a body that shimmers and glows with an otherworldly light. It is immune to cold and can unleash powerful blasts of water on its enemies. | regularObtuse         | swamp                                    |
| Air Elemental        | A being of materialised air and wind, with a body enveloped in swirling gusts and clouds. It is able to control and manipulate the air around it with speed and agility. | regularObtuse         | mountain                                 |
| Inferno Drake        | A fearsome dragon that spews flames and molten lava from its mouth. It is resistant to fire and can fly through the air with grace and speed. | regularObtuse         | heat                                     |
| Lapis Drake          | A slim dragon that glides through the air spewing bursts of arcane magic. Its lapis-blue scales gleam in the sun. | regularObtuse         | mountain, swamp, rock, ice               |
| Divine Drake         | A powerful and majestic dragon with shimmering, otherworldly scales and a holy aura. It ravages any who invade its land. | regularObtuse         | holy                                     |
| Undead Drake         | A reanimated dragon with decayed and twisted flesh, and glowing, malevolent eyes. The undead serve their lord to infest the lands. | regularObtuse         | undead                                   |
| Mountain Troll       | A massive, hulking creature that dwells in the mountains. It has skin as hard as stone and is capable of hurling boulders with ease. | brute                 | mountain                                 |
| Rock Troll           | A large, burly, humanoid creature with rocky skin and sharp, jagged teeth. Its powerful blows compensate its low intelligence. | brute                 | rock                                     |
| Lumbering Troll      | A massive, slow-moving troll with thick skin and powerful muscles. Its brute strength and savagery compensate for its low intelligence. | brute                 | vegetation, swamp, mountain, ruins, cave |
| Swamp Troll          | A slimy, amphibious troll with webbed feet and sharp, venomous claws. It is found in swamps and marshes, and is known for its stealth attacks and surprising brute force. | brute                 | swamp                                    |
| Cavern Troll         | A subterranean troll with glowing eyes and sharp, bony protuberances. It is found in underground caverns and tunnels, and uses a rock club to smash its opponents. | brute                 | cave                                     |
| Necromancer          | A wicked magician who has mastered the art of raising the dead. They can summon undead minions to do their bidding and are skilled in dark magic. | regular               | dark                                     |
| Toxic Serpent        | A venomous serpent that can strike quickly and deliver a deadly bite. It is agile and difficult to catch, and its venom can cause severe poisoning. | regularAcute          | vegetation, swamp                        |
| Giant Spider         | A massive spider with venomous fangs and long, sticky webs. It can spin webs to ensnare its prey and is skilled at hiding in shadows. | regularObtuse         | cave, dark, vegetation                   |
| Creeping Spider      | This enlarged, venomous spider is known for its stealthy movements and tendency to hide in dark, secluded areas. It is often found lurking in shadows, waiting for an opportunity to strike. | regular               | cave, dark, vegetation                   |
| Cavern Spider        | A large spider with a hick, chitinous exoskeleton which makes it resistant to physical attacks. | regular               | cave                                     |
| Ironbark Spider      | A massive spider with a thick exoskeleton found lurking near ironbark groves, where it preys on large animals. | regularObtuse         | vegetation                               |
| Outcast Druid        | A druid cast out of their order for breaking their oaths. They still possess their powerful druidic magic, but use it with dark magic to pursue destructive purposes. Much of their sanity is lost. | regular               | dark                                     |
| Outcast Warlock      | A powerful warlock who turned to the dark arts after being outcast from their kingdom. They are skilled in the use of black magic and can summon dark spirits to do their bidding. | regular               | dark                                     |
| Outcast Warrior      | Once a great warrior, he was outcast for murdering his wife in a crazed rage. He now travels the lands in tattered clothes and beaten armor, searching for his next victim. | regular               | dark                                     |
| Outcast Caster       | A caster that was outcast from his temple for pursuing the dark arts. His eyes are enveloped in black, and his skin is tainted with scars that glow a wicked purple. His hands linger with shadowflame. | regular               | dark                                     |
| Mad Naga             | A serpentine creature with a human-like upper body, the naga has clearly gone insane. It uncontrollably whispers to itself causing froth to build from its mouth. | regular               | swamp                                    |
| Swamp Naga           | A serpentine creature with a human-like upper body. It is agile and skilled with sea magic, and its venomous bites can cause paralysis. | regular               | swamp                                    |
| Divine Spirit        | This spirit is a being of pure divine energy. It's so entranced in purifying all morality that it attempts to vanquish any who it perceives has sinned. | regular               | holy                                     |
| Forest Spirit        | This spirit is a being of nature, infused with the power of the forest and its inhabitants. It has such devotion to isolating the natural environment that it attempts to vanquish any who it perceives has intruded. | regular               | vegetation                               |
| Frost Spirit         | This spirit is a being of frost, devoted to protecting the ice realm. It attempts to freeze any who it perceives has intruded its territory. | regular               | ice                                      |
| Mountain Spirit      | This spirit is a being of enchanted mountain rock, who pledged to protected regions of high altitude. It uses chillwind to propel intruders off the mountaintops. | regular               | mountain                                 |
| Inferno Spirit       | This spirit is a being of pure flame, and is capable of unleashing devastating solar flares upon those who it deems has intruded the firelands. | regular               | heat                                     |
| Shadowflame Spirit   | This spirit is a being of pure shadowflame devoted to the dark arts. It is capable of unleashing barrages of of dark magic spells, engulfing any foe in shadowfire. | regular               | dark                                     |
| Lumbering Orc        | An orc larger and more muscular than its kin, known for its brute strength and endurance. Its slow, heavy movements can be intimidating, but also make it more vulnerable to quicker and more agile foes. | brute                 | neutral                                  |
| Undead Orc           | An orc risen from the grave, its body animated by dark magic. The undead serve their lord to infest the lands. | brute                 | undead                                   |
| Orc Behemoth         | This massive orc is the largest and strongest of its kin, with thick gray skin and powerful muscles. | brute                 | neutral                                  |
| Mountain Orc         | An orc which is hardy and adaptable, able to survive in the harsh and unforgiving mountain regions where it makes its home. | brute                 | mountain                                 |
| Cavern Orc           | An orc adapted to life underground. It has departed with its poor eyesight, and now relies solely on hearing, smell and its brute force to navigate the caverns. | brute                 | cave                                     |
| Wildbear             | This ferocious bear is known for its   ability to maul its enemies with its sharp claws and teeth. It is highly territorial and will fiercely defend its home against intruders. | brute                 | vegetation                               |
| Wildbear Behemoth    | This massive bear is even larger and more powerful than its smaller kin. It is known for its incredible strength and endurance, and can take a tremendous amount of damage before going down. | brute                 | vegetation                               |
| Tortoise Behemoth    | This massive tortoise is known for its slow, methodical movements and incredible durability, being covered in a thick, armored shell. Its attacks are slow and deliberate, but are devastating when they connect. | brute                 | vegetation                               |
| Wilderwolf           | This fierce wolf is known for its wild, untamed nature. Its attacks are swift and powerful, and it is known for its ability to tear into its enemies with its sharp teeth and claws. | regularAcute          | ice, mountain, rock                      |
| Frostwolf            | This wolf has a thick fur coat to adapt to life in cold, snowy environments. It is swift and agile, and its attacks can be particularly devastating to those who are unprepared for the cold. | regularAcute          | ice                                      |
| Mountain Hound       | This hound is a large, powerful canine that is well-suited to life in the mountains. It is highly agile and able to navigate rough terrain with ease. | regularAcute          | mountain                                 |
| Treant               | This sentient tree is a powerful and ancient being, with deep roots and a connection to the earth. Its attacks are slow, but buys time using its ability to manipulate plants and vines in battle. | regular               | vegetation                               |
| Swift Bandit         | This bandit is fast and agile, and able to move quickly and strike without warning. They equip a rugged leather outfit and wear a cloth mask to cover their face. | regular               | ruins                                    |
| Scavenging Bandit    | This bandit is a desperate and opportunistic scavenger, hiding in ruins to ambush unsuspecting victims. | regular               | ruins                                    |
| Armored Bandit       | This bandit is heavily armed and armored, making it a formidable foe in combat. The armor comprises of scrap metal and stolen equipment. | regularObtuse         | ruins                                    |
| Ironbark Golem       | This golem is made of ironbark, a tough, durable wood that has been enchanted to give it life. It has a tree-like appearance and wields powerful, lumbering movements. | brute                 | vegetation, rock                         |
| Blackruby Golem      | This golem is made of enchanted blackruby, a black shimming metal that seems to absorb light. It lurks in dark areas of cavern systems, and creates the perception of a lurking, reflective shadow. | brute                 | cave                                     |
| Mythril Golem        | This golem is made of mythril, a rare and powerful metal that has been enchanted to give it life. It is often found in areas with rich deposits of mythril and is known for its silvery, shimmering appearance. | brute                 | cave                                     |
| Molten Golem         | This golem is made of molten rock and magma, and is able to unleash devastating waves of heat and flame upon its enemies. | brute                 | heat                                     |
| Divine Golem         | This golem is imbued with divine energy and is able to unleash powerful holy attacks against its enemies. Once summoned to guard sacred temples, it now traverses the land ravaging any who it perceives as a foe. | brute                 | holy                                     |
| Frost Golem          | This massive golem is made of hardened ice and snow, and is able to demolish enemies by smashing its unwieldy arms into the ground. | brute                 | ice                                      |
| Cavern Golem         | This golem is formed of enchanted rock, and roams caverns without intention or purpose. It uses its massive arms to crush those who get in its path. | brute                 | cave                                     |
| Hardrock Golem       | This golem is made of an almost indestructible rock and has a jagged, rugged form. | brute                 | rock                                     |
| Worg                 | A large, wolf-like creature that despite its ferocity, is particularly cunning in how it approaches its strikes. | regularAcute          | neutral                                  |
| Scavenging Worg      | A decrepit wolf-like creature that travels alone scavenging the landscape. It acts weakened then ferociously pounds onto unsuspecting prey for an easy kill. | regularAcute          | neutral                                  |
| Worg Berserker       | This large, wolf-like creature is a fierce fighter, driven into a frenzy by its bloodthirsty nature. It is known for its reckless, wild attacks and its willingness to take on even the most formidable foes. | regularAcute          | neutral                                  |
| Dark Cultist         | This cultist is devoted to the worship of the dark arts. They're draped in a dark hooded robes and lurk in the shadows. | regular               | dark                                     |
| Shadowflame Cultist  | This cultist is devoted to the practice of dark shadowflame magic. They're draped in robes of a dark, tattered fabric that is torn with burning shadowflame and adorned with glyphs that glow a faint purple. Scars that emit shadowflame mark their skin. | regular               | dark                                     |
| Forest Cultist       | This cultist is devoted to the crazed and violent worship of nature and the forest, and is able to call upon the power of the forest to unleash powerful attacks against its enemies. | regular               | vegetation                               |
| Shambling Mound      | This creature is a massive, mobile mound of dirt and plant matter, with long, grasping vines and sharp, jagged rocks protruding from its surface. It survives by entangling and slowly consuming unsuspecting victims. | regular               | vegetation, swamp                        |
| Rockshell Tortoise   | This massive tortoise is covered in a thick, armored shell layered with rock and stone. A mini vegetative ecosystem lives upon its expansive shell. | brute                 | vegetation, swamp                        |
| Bonespike Hound      | A canine with an arched back and bony spines that protrude from its dark fur. They strike by biting and dragging the victim to the ground. | regularAcute          | neutral                                  |
| Stealth Hound        | A smaller canine with an arched back and midnight black fur. It remains hidden stalking its prey, then leaps out and strikes with its powerful jaw. | regularAcute          | dark                                     |
| Slipstone Hound      | A canine with an arched back that has razer sharp claws. Using its extended claws, it's capable of traversing slippery surfaces and scaling vertical terrain. | regularAcute          | neutral                                  |
| Frost Hound          | A canine adapted to the cold, this hound has a thick grey fur goat and a bite that can shatter bone. | regularAcute          | ice                                      |
| Sludge Ooze          | This ooze is a foul-smelling, putrid mass of slime. It is a slow-moving creature, but it is capable of engulfing and suffocating its prey. Its body is constantly secreting a thick, oily substance that makes it difficult to grip or hold onto. | regular               | swamp                                    |
| Iron Ooze            | This ooze is a metallic, shimmering mass of slime that roams caverns. It is a slow-moving creature, but it is incredibly strong and can deliver powerful blows with its body. Its surface is covered in sharp, metallic shards, making it dangerous to touch. | regular               | cave                                     |
| Molten Ooze          | This ooze is a glowing, molten mass of magma. It is a slow-moving creature, but it can deliver devastating burns with its searing touch. Its body is constantly radiating heat, and it can melt through most forms of matter with ease. | regular               | heat                                     |
| Cavern Ooze          | This ooze is a dark, shadowy mass of slime. It is a slow-moving creature, but it is capable of blending in with its surroundings and launching surprise attacks. | regular               | cave                                     |
| Vine Crawler         | This creature looks like a mass of vines and roots, with a pair of glowing eyes peering out from within. It is capable of dragging itself along the ground, using its vines to grasp and pull itself forward. It is also able to wrap its vines around its prey, constricting and suffocating them. | regular               | vegetation                               |
| Gorgon               | An intelligent creature with the body of a serpent and the head of a woman with snakes for hair. Its gaze is said to have the power to turn living beings to stone. | regular               | rock                                     |
| Cavern Gorgon        | This gorgon is adapted to life in underground caverns, with a dark, mottled coloration that allows it to blend in with the shadows. Its gaze is still said to have the power to turn living beings to stone. | regular               | cave                                     |
| Rockbeetle Behemoth  | This massive beetle is the size of a small house, with a hard exoskeleton that is nearly impenetrable. It is covered in sharp, jagged spines, and its mandibles are strong enough to crush rock and metal. | brute                 | cave, rock                               |
| Mad Minotaur         | This creature is a towering, muscular humanoid with the head of a bull. It is known for its frenzied, unpredictable behavior, and is capable of delivering powerful blows with its hooves and horns. | brute                 | cave                                     |
| Burrowing Dragon     | This dragon is a massive, serpentine creature with powerful claws and wings. It is able to dig through solid rock with ease, using its claws and strong body to carve tunnels through the earth. | regularObtuse         | cave                                     |
| Darkeyed Dragon      | A rare dragon with dark, shimmering scales and glowing red eyes. It is incredibly agile in the air, and is capable of launching devastating fire attacks from its mouth. | regularObtuse         | dark                                     |
| Shadowflame Horror   | This horror is a shadowy, ghostly creature with a pair of glowing, fiery eyes. It is able to phase in and out of the physical world at will, and is capable of launching devastating shadowflame attacks that can ignite and consume its enemies. | regularAcute          | dark                                     |
| Flesh Horror         | This horror is a grotesque, mutilated creature made of pulsating flesh and bones. It has surprisingly long arms that can extend and grab unsuspecting victims. | regular               | dark                                     |
| Swamp Croc           | This croc is a massive, armored reptile with a long, powerful tail and sharp teeth. It is adapted to life in swamps and marshes, and is capable of dragging its prey into the water to drown them. | brute                 | swamp                                    |
| Giant Croc           | Larger and more powerful than a normal croc, this beast is capable of delivering devastating bites and tail swipes, and has adapted to living most of its life on land. | brute                 | swamp                                    |
| Greatscale Croc      | A great croc with rigid scales that are particularly large and tough, and a bite capable of crushing bone. | brute                 | swamp                                    |
| Stargazed Angel      | A bright angel with divine power and black-enveloped eyes that twinkle stars. The stargazed are tranced in divine visions, and believe any who don't conform to their visions be extinguished from existence. | regular               | holy                                     |
| Stargazed Traveller  | An aged traveller with black-enveloped eyes that twinkle stars. The stargazed are tranced in divine visions, and believe any who don't conform to their visions be extinguished from existence. | regular               | holy                                     |
| Devoted Stargazer    | A figure hidden by long robes and a hood that masks their face, they hold a tall golden staff. The stargazed are tranced in divine visions, and believe any who don't conform to their visions be extinguished from existence. | regular               | holy                                     |
| Stargazed Goblin     | A goblin that sways while walking with black-enveloped eyes that twinkle stars. The stargazed are tranced in divine visions, and believe any who don't conform to their visions be extinguished from existence. | goblin                | holy                                     |
| Stargazed Scavenger  | A starved man with scraps for clothes and black-enveloped eyes that twinkle stars. The stargazed are tranced in divine visions, and believe any who don't conform to their visions be extinguished from existence. | regular               | holy                                     |
| Stargazed Adventurer | A young adventurer with casting equipment and black-enveloped eyes that twinkle stars. The stargazed are tranced in divine visions, and believe any who don't conform to their visions be extinguished from existence. | regular               | holy                                     |
| Stargazed Cultist    | A cultist wearing sparkling gold and white robes, and black-enveloped eyes that twinkle stars. The stargazed are tranced in divine visions, and believe any who don't conform to their visions be extinguished from existence. | regular               | holy                                     |
| Stargazed Caster     | A mage that wears arcane robes and once was a respectable fighter, now wanders with black-enveloped eyes that twinkle stars. The stargazed are tranced in divine visions, and believe any who don't conform to their visions be extinguished from existence. | regular               | holy                                     |
| Stargazed Merchant   | Carrying pouches of items and potions that have long gone off, this merchant now stares with black-enveloped eyes that twinkle stars. The stargazed are tranced in divine visions, and believe any who don't conform to their visions be extinguished from existence. | regular               | holy                                     |
| Scavenging Wendigo   |                                                              | regularAcute          | ice, mountain                            |
| Frost Wraith         |                                                              | regular               | ice                                      |
| Flame Wraith         |                                                              | regular               | heat                                     |
| Dark Wraith          |                                                              | regular               | dark                                     |
| Blood Wraith         |                                                              | regular               | dark                                     |
| Flame Imp            |                                                              | regular               | heat                                     |
| Inferno Imp          |                                                              | regular               | heat                                     |
| Demonic Imp          |                                                              | regular               | heat                                     |
| Imp Behemoth         |                                                              | brute                 | heat                                     |
| Scavenging Imp       |                                                              | regular               | heat, ruins                              |
| Shadowflame Imp      |                                                              | regular               | dark, heat                               |
| Dark Imp             |                                                              | regular               | dark                                     |
| Bone Imp             |                                                              | regular               | heat                                     |
| Undead Imp           |                                                              | regular               | heat                                     |
| Animated Rock        |                                                              | brute                 | rock                                     |
| Vampiric Bat         |                                                              | regular               | cave                                     |
| Cavern Crawler       |                                                              | regularObtuse         | cave                                     |
| Cavern Elemental     |                                                              | regularObtuse         | cave                                     |
| Hardrock Centipede   |                                                              | regularObtuse         | cave                                     |
| Undead Miner         |                                                              | regular               | cave                                     |
| Darkrock Tunneller   | some wack made up insect - it's hard to get a glance in the dim light of the cavern | regular               | cave                                     |
| Devouring Worm       |                                                              | regularObtuse         | cave                                     |
| Darktooth Worm       |                                                              | regularObtuse         | cave                                     |
| Greatscale Worm      |                                                              | regularObtuse         | cave                                     |
| Quaking Worm         |                                                              | regularObtuse         | cave                                     |
| Flame Demon          |                                                              | regularAcute          | heat                                     |
| Shadowflame Demon    |                                                              | regularAcute          | dark                                     |
| Demon Behemoth       |                                                              | brute                 | heat, dark                               |
| Nether Dragon        |                                                              | regularObtuse         | heat                                     |
| Demon Lord           |                                                              | brute                 | heat, dark                               |
| Magma Ooze           |                                                              | regular               | heat                                     |
| Magma Serpent        |                                                              | regular               | heat                                     |
| Winged Inferno       |                                                              | regular               | heat                                     |
| Flamerock Behemoth   |                                                              | brute                 | heat                                     |
| Flamefractured Orc   |                                                              | brute                 | heat                                     |
| Animated Skeleton    |                                                              | regular               | dark, ruins                              |
| Skeleton Warrior     |                                                              | regular               | dark, ruins                              |
| Ironbark Chest Mimic |                                                              | regular               | ruins                                    |
| Rotting Mimic        |                                                              | regular               | ruins                                    |
| Splintered Mimic     |                                                              | regularAcute          | ruins                                    |
| Lost Wight           |                                                              | regular               | undead, ice                              |
| Wight Behemoth       |                                                              | brute                 | undead, ice                              |
| Wight Berserker      |                                                              | regularAcute          | undead, ice                              |
| Wight Soldier        |                                                              | regularAcute          | undead, ice                              |
| Undead Footman       |                                                              | regular               | undead                                   |
| Undead Berserker     |                                                              | regularAcute          | undead                                   |
| Undead Behemoth      |                                                              | brute                 | undead                                   |
| Undead Farmer        |                                                              | regular               | undead                                   |
| Undead Soldier       |                                                              | regular               | undead                                   |
| Undead Footman       |                                                              | regular               | undead                                   |
| Undead Servant       |                                                              | regular               | undead                                   |
| Undead Adventurer    |                                                              | regular               | undead                                   |
| Undead Bandit        |                                                              | regular               | undead                                   |
| Undead Hero          |                                                              | regular               | undead                                   |
| Undead Hound         |                                                              | regularAcute          | undead                                   |
| Undead Assassin      |                                                              | regularAcute          | undead                                   |
| Undead Wanderer      |                                                              | regular               | undead                                   |
| Flesheating Mutant   |                                                              | regularAcute          | dark                                     |
| Mutant Behemoth      |                                                              | brute                 | dark                                     |

# Accessories

# Armor

Armor can only have one tag.

```swift
/// Armor that focuses on being heavy and defensive, such as an iron chest-plate.
case heavyweight
/// Armor that focuses on being light and provide bonuses, such as a hooded cloak.
case lightweight
```

| Name                     | Description                                                  | Tag  |
| ------------------------ | ------------------------------------------------------------ | ---- |
| Iron Great Helm          | A helmet made of solid iron covering the entire head and face, with slits for the eyes. The top of the helm is adorned with a crest, and it has a sturdy neck guard to protect against blows from behind. |      |
| Iron Breastplate         | This heavyweight armor consists of a large, rectangular piece of iron that covers the chest and abdomen with straps and buckles to secure it in place. |      |
| Iron Leg Armor           | These armor pieces consist of plates of iron that cover the front and sides of the legs, from the hips to the knees. They are attached to the legs using straps and buckles. |      |
| Steel Helmet             | A helmet is made of polished steel and is designed to protect the head from blows and other attacks. It has a rounded shape that covers the top and back of the head, with a small visor that can be raised to cover the face. |      |
| Steel Chestplate         | This armor consists of a large, rectangular piece of steel that covers the chest and abdomen. It has straps and buckles to secure it in place. |      |
| Steel Leg Armor          | These armor pieces consist of plates of steel that cover the front and sides of the legs, from the hips to the knees. They are attached to the legs using straps and buckles. |      |
| Divine Hood              | A hood is made of a shimmering, otherworldly fabric that faintly glows with a holy light. The hood is lightweight and comfortable, and it has a subtle, divine power that protects the wearer from harm. |      |
| Divine Robes             | Robes made of a shimmering, otherworldly fabric that faintly glows with a holy light, and are adorned with intricate patterns and symbols of the divine. The robes are comfortable and flowing, and they grant the wearer a sense of peace and serenity. |      |
| Divine Legwear           | Legwear made of a shimmering, otherworldly fabric that faintly glows with a holy light, and are adorned with intricate patterns and symbols of the divine. They have a snug, form-fitting design that allows for ease of movement. |      |
| Cursed Hood              | A hood made of a dark, tattered fabric that seems to writhe and twist of its own accord. It covers the head and neck, and it has a cowl that can be worn up or down to obscure the face. |      |
| Cursed Robes             | Robes made of a dark, tattered fabric that are adorned with sinister symbols and markings. The robes are comfortable and flowing, but they grant the wearer a sense of malevolence and cruelty. |      |
| Cursed Legwear           | Legwear made of a dark, tattered fabric that are adorned with sinister symbols and markings. They have a snug, form-fitting design that allows for ease of movement. |      |
| Ironbark Helmet          | A helmet made of a sturdy, ironbark-like material that is both strong and flexible. It covers the head and face, with slits for the eyes and mouth. |      |
| Ironbark Body Armor      | This armor consists of a large, rectangular piece of the ironbark-like material that covers the chest and abdomen. It has matted vines to secure it in place. |      |
| Ironbark Leg Armor       | These armor pieces consist of plates of the ironbark-like material that cover the front and sides of the legs, from the hips to the knees. It's somewhat flexible and allows for a full range of motion. |      |
| Inferno Mask             | A mask is made of a fiery, inferno-like material that glows with a fierce, orange light. The mask has a menacing, demonic appearance, and it is imbued with the power of fire. |      |
| Inferno Surcoat          | This armor consists of a long, flowing surcoat made of a fiery, inferno-like material. It covers the torso and arms, and it has a high collar and flared sleeves. |      |
| Inferno Leggings         | Leggings made of a fiery, inferno-like material. They have a lightweight with generous airflow. |      |
| Frost Mask               | A mask is made of a shimmering, ice-like material that glows with a cold, blue light. The mask has a frigid, frozen appearance, and it is imbued with the power of ice. |      |
| Frost Surcoat            | This armor consists of a long, flowing surcoat made of a shimmering, ice-like material. It covers the torso and arms, and it has a high collar and flared sleeves. It has the ability to slow down or even freeze enemies who come into contact with it. |      |
| Frost Leggings           | Leggings made of a shimmering, ice-like material. Cold to the touch, internally they surprisingly feel warm while wearing them. |      |
| Serpent Scale Helmet     | A helmet made from a behemoth serpent's scales. The purple-green scales are large and rugged. A pair of curved horns extrude from the top. |      |
| Serpent Scale Chestplate | A chestplate made from overlapping behemoth serpent scales. The purple-green scales are large and rugged, and are interwoven to create a strong, yet flexible armor. |      |
| Serpent Scale Leg Armor  | Leg armor made from overlapping behemoth serpent scales. The purple-green scales are large and rugged, and interwoven to provide a full range of movement. |      |
| Dragon Scale Helmet      | A helmet is made from the shimmering scales of a dragon. The scales are impenetrable, and provide intense heat resistance. |      |
| Dragon Scale Chestplate  | A chestplate made from overlapping dragon scales. The shimmering scales are impenetrable, and provide intense heat resistance. |      |
| Dragon Scale Leg Armor   | Leg armor made from overlapping dragon scales. The shimmering scales are impenetrable, and provide intense heat resistance. |      |
| Eternos Hood             | A hood is made from a shimmering, celestial fabric that seems to radiate with otherworldly energy. The hood is adorned with intricate silver embroidery. |      |
| Eternos Robes            | Robes made from a shimmering, celestial fabric that seems to radiate with otherworldly energy. The robes are adorned with intricate silver embroidery, and have a flowing, elegant design. |      |
| Eternos Legwear          | Legwear made from a shimmering, celestial fabric that seems to radiate with otherworldly energy. The legwear has a sleek, elegant design, and are adorned with intricate silver embroidery. |      |
| Blackruby Helm           | A helm made from a dark, shimmering metal that seems to absorb light. It covers the entire head, face and neck, with two very narrow slits for the eyes, creating the impression of a reflective shadow. |      |
| Blackruby Chestplate     | A chestplate with a sleek design made from a dark, shimmering metal that seems to absorb light. It covers the entire chest and abdomen, creating the impression of a reflective shadow. |      |
| Blackruby Leg Armor      | Leg armor pieces made from a dark, shimmering metal that seems to absorb light. The pieces are tightly buckled together, creating the impression of a reflective shadow. |      |
| Caster's Hood            | A hood is made of a lightweight, flowing fabric woven for spellcasters. It is adorned with glowing intricate symbols and runes. |      |
| Caster's Robes           | Robes made of a soft, silky material that is comfortable to wear and moves easily with the wearer, adorned with glowing intricate symbols and runes. They have long sleeves and a flowing, ankle-length hem. |      |
| Caster's Legwear         | Leg coverings made of a lightweight, stretchy material that allows for easy movement. They are adorned with glowing intricate symbols and runes. |      |
| Temporal Hood            | A hood is made of a shimmering, metallic fabric that is infused with temporal magic. The hood is adorned with intricate symbols and runes that are believed to favour the flow of time to the wearer. |      |
| Temporal Cloak           | A cloak made of a shimmering, metallic fabric that is infused with temporal magic. The cloak is adorned with intricate symbols and runes that are believed to favour the flow of time to the wearer. The cloak is designed to be worn over the shoulders and is fastened with a clasp at the neck, allowing the wearer to easily adjust the fit. |      |
| Temporal Legwear         | Leg coverings made of a shimmering, metallic fabric that is infused with temporal magic. |      |
| Mythril Helm             | A helm made of mythril, a rare and incredibly strong silver-like metal. The helm is shaped to fit snugly over the head, with a visor that can be raised or lowered as needed. |      |
| Mythril Breastplate      | A breastplate made of mythril, a rare and incredibly strong silver-like metal. It covers the chest and abdomen, providing excellent protection against physical attacks. |      |
| Mythil Leg Armor         | Leg coverings made of mythril, a rare and incredibly strong silver-like metal. It is fastened with straps at the thighs and calves, allowing for a customizable fit. |      |
| Arcane Scarf             | A lapis-blue scarf made of a soft, silky fabric that is infused with arcane magic. The scarf is designed to be worn around the neck and can be fastened with a clasp or left to hang loose. |      |
| Arcane Cloak             | A lapis-blue cloak made of a soft, silky fabric that is infused with arcane magic. It extends down to the ankles, and is inscribed with golden glyphs of astral entities. |      |
| Arcane Leggings          | Lapis-blue leggings made of a soft, silky fabric that is infused with arcane magic. They are fitted to the wearer and inscribed with golden glyphs of astral entities. |      |
| Chillwind Great Helm     | A great helm made of a cold, rugged metal that is resistant to both physical and magical attacks. The armor is ice-blue with icy-white streaks. |      |
| Chillwind Bodyarmor      | Bodyarmor made of a cold, rugged metal that is resistant to both physical and magical attacks. The armor is ice-blue with icy-white streaks. |      |
| Chillwind Leg Armor      | Leg coverings made of a cold, rugged metal that is resistant to both physical and magical attacks. The armor is ice-blue with icy-white streaks. |      |
| Hardshell Helm           | A helm made of durable hardshell, a material greatly resistant to physical attacks. It is also reinforced with metal plates at key points to provide even more protection against blows. |      |
| Hardshell Plating        | Plating made of durable hardshell, a material greatly resistant to physical attacks. It is also reinforced with metal plates at key points to provide even more protection against blows. |      |
| Hardshell Leg Armor      | Leg coverings made of durable hardshell, a material greatly resistant to physical attacks. It is also reinforced with metal plates at key points to provide even more protection against blows. |      |

# Bosses

* FOREST TITAN
* DEATHBRINGER, LORD UNDEAD

# Areas

```
neutral
vegetation
rock
dark
swamp
holy
ice
mountain
cave
heat
ruins
undead
```

### Stage 0: Overgrown Vegetation

| Area Name           | Area Description | Area Tags                 |
| ------------------- | ---------------- | ------------------------- |
| Overgrown Ironbark  |                  | neutral, vegetation, rock |
| Lush Vegetation     |                  | neutral, vegetation       |
| Carnivorous Tangles |                  | neutral, vegetation, dark |
| Deep Boscage        |                  | neutral, vegetation, dark |
| Rotting Woodlands   |                  | neutral, vegetation, dark |

### Stage 1: Grasslands/Swamp

| Area Name          | Area Description | Area Tags                  |
| ------------------ | ---------------- | -------------------------- |
| Dense Wetlands     |                  | neutral, swamp, vegetation |
| Starlight Meadows  |                  | neutral, vegetation, holy  |
| Darmurk Swamp      |                  | neutral, dark, swamp       |
| Taekunda Falls     |                  | neutral, vegetation        |
| Frosted Grasslands |                  | neutral, vegetation, ice   |

### Stage 2: Rocky/Snowy

| Area Name       | Area Description | Area Tags          |
| --------------- | ---------------- | ------------------ |
| Glacier Rifts   |                  | neutral, ice, rock |
| Glacier Hollows |                  | ice, cave          |
| Blizzard Slopes |                  | ice, mountain      |
| Moonsnow Plains |                  | neutral, ice, holy |
| Icewind Tundra  |                  | neutral, ice, rock |

### Stage 3: Mountains/Cliffsides

| Area Name            | Area Description | Area Tags                     |
| -------------------- | ---------------- | ----------------------------- |
| Mt Hymboc            |                  | neutral, mountain             |
| Densecloud Alps      |                  | mountain, ice                 |
| Sun-blessed Mountain |                  | neutral, mountain, holy       |
| Lush Peaks           |                  | neutral, mountain, vegetation |
| Jagged Versant       |                  | neutral, rock, dark           |

### Stage 4: Hotlands

| Area Name            | Area Description | Area Tags           |
| -------------------- | ---------------- | ------------------- |
| Ablaze'd Netherworld |                  | heat                |
| Blazerock Ridge      |                  | neutral, heat, rock |
| Fever Caverns        |                  | heat, cave          |
| Drylands             |                  | neutral, heat, rock |
| Molten Flows         |                  | heat, rock          |

### Stage 5: Caves/Catacombs

| Area Name                                | Area Description | Area Tags              |
| ---------------------------------------- | ---------------- | ---------------------- |
| Sinkom Chambers                          |                  | undead, cave           |
| Deathroot Valley                         |                  | neutral, undead, dark  |
| Crawling Catacombs                       |                  | undead, cave           |
| Temporal Kingdom (lost/destroyed/ruined) |                  | neutral, undead, ruins |
| Orkskull (dead orc remains stuff?)       |                  | neutral, undead, ruins |

### Stage 6: Deadlands

| Area Name          | Area Description | Area Tags    |
| ------------------ | ---------------- | ------------ |
| Decrepit Peaks     |                  | undead, dark |
| Shadowflamed Ruins |                  | undead, dark |
| Tarnished Brinks   |                  | undead, dark |
| Desolate Borders   |                  | undead, dark |

