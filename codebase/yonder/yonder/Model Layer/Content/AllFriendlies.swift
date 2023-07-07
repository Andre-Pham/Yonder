//
//  AllFriendlies.swift
//  yonder
//
//  Created by Andre Pham on 27/12/21.
//

import Foundation

enum Friendlies {
    
    // 01
    static func goldOrRestorationFriendly(profile: FriendlyProfile, stage: Int) -> Friendly {
        let restorationAmount = 150.0.compound(multiply: 1.1, index: stage).toRoundedInt()
        let goldAmount = Pricing.usingStage(stage: stage) {
            // Bonus because otherwise immediate value of restoration is almost always better than potential value provided by gold
            (Double(Pricing.playerHealthRestorationStat.getValue(amount: restorationAmount))*1.25)
                .toRoundedInt()
        }
        return Friendly(
            contentID: profile.id,
            name: profile.friendlyName,
            description: profile.friendlyDescription,
            offers: [
                FreeGoldOffer(goldAmount: goldAmount),
                FreeRestorationOffer(restorationAmount: restorationAmount)
            ],
            offerLimit: 1
        )
    }
    
    // 02
    static func dragonSlayerFriendly(profile: FriendlyProfile, stage: Int) -> Friendly {
        let damage = (100.0.compound(multiply: 1.2, index: stage)*3.0).toRoundedInt().nearest(5)
        let dulling = (Double(damage)/12.0).toRoundedInt()
        let dragonSlayer = Weapon(
            name: Strings("weapon.dragonSlayer.name").local,
            description: Strings("weapon.dragonSlayer.description").local,
            basePill: DamageBasePill(damage: damage),
            durabilityPill: DullingDurabilityPill(damageLostPerUse: dulling),
            effectPills: [],
            buffPills: []
        )
        let price = Pricing.usingStage(stage: stage) {
            (Double(dragonSlayer.getBasePurchasePrice())*0.8).toRoundedInt()
        }
        return Friendly(
            contentID: profile.id,
            name: profile.friendlyName,
            description: profile.friendlyDescription,
            offers: [
                PurchaseWeaponOffer(weapon: dragonSlayer, price: price)
            ],
            offerLimit: 1
        )
    }
    
    // 03
    static func healthForGoldFriendly(profile: FriendlyProfile, stage: Int) -> Friendly {
        let health = 100
        let goldReward = Pricing.usingStage(stage: stage) {
            let fairPrice = abs(Pricing.foeDamageStat.getValue(amount: health))
            return Random.selectFromNormalDistribution(min: fairPrice, max: (Double(fairPrice)*1.5).toRoundedInt())
        }
        return Friendly(
            contentID: profile.id,
            name: profile.friendlyName,
            description: profile.friendlyDescription,
            offers: [
                HealthForGoldOffer(health: health, goldReward: goldReward)
            ],
            offerLimit: 10
        )
    }
    
    // 04
    static func shivFriendly(profile: FriendlyProfile, stage: Int) -> Friendly {
        let shiv = Weapon(
            name: Strings("weapon.simpleShiv.name").local,
            description: Strings("weapon.simpleShiv.description").local,
            basePill: DamageBasePill(damage: 15),
            durabilityPill: InfiniteDurabilityPill(),
            effectPills: [],
            buffPills: []
        )
        return Friendly(
            contentID: profile.id,
            name: profile.friendlyName,
            description: profile.friendlyDescription,
            offers: [
                FreeWeaponOffer(weapon: shiv)
            ],
            offerLimit: 1
        )
    }
    
    // 05
    static func sellPotionsFriendly(profile: FriendlyProfile, stage: Int) -> Friendly {
        return Friendly(
            contentID: profile.id,
            name: profile.friendlyName,
            description: profile.friendlyDescription,
            offers: [SellPotionsOffer()],
            offerLimit: 1
        )
    }
    
    // 06
    static func maxPointsForArmorPointsFriendly(profile: FriendlyProfile, stage: Int) -> Friendly {
        return Friendly(
            contentID: profile.id,
            name: profile.friendlyName,
            description: profile.friendlyDescription,
            offers: [MaxHealthForArmorPointsOffer()],
            offerLimit: Int.random(in: 1...3)
        )
    }
    
    // 07
    static func goldBlessingOrCurseFriendly(profile: FriendlyProfile, stage: Int) -> Friendly {
        let cursePriceFraction = 1.1
        let blessingPriceFraction = 0.9
        let gold = (1000 + (sqrt(Double(stage)*10_000_000)*0.5).toRoundedInt()).nearest(100)
        return Friendly(
            contentID: profile.id,
            name: profile.friendlyName,
            description: profile.friendlyDescription,
            offers: [
                GoldForPriceBuffOffer(gold: gold, priceFraction: cursePriceFraction),
                GoldForPriceBuffOffer(gold: -gold, priceFraction: blessingPriceFraction)
            ],
            offerLimit: Int.random(in: 1...3)
        )
    }
    
    // 08
    static func weaponDamageOrPotionCountFriendly(profile: FriendlyProfile, stage: Int) -> Friendly {
        let damage = (50.0.compound(multiply: 1.2, index: stage)).toRoundedInt()
        return Friendly(
            contentID: profile.id,
            name: profile.friendlyName,
            description: profile.friendlyDescription,
            offers: [
                BuffEveryWeaponDamageOffer(damage: damage),
                IncrementEveryPotionCountOffer(increment: 1)
            ],
            offerLimit: 1
        )
    }
    
    // 09
    static func freeItemsFriendly(profile: FriendlyProfile, stage: Int, lootFactory: LootFactoryBundle) -> Friendly {
        let potions = lootFactory.potionFactory.deliver(count: Int.random(in: 1...2))
        let consumables = lootFactory.consumableFactory.deliver(count: Int.random(in: 0...2))
        return Friendly(
            contentID: profile.id,
            name: profile.friendlyName,
            description: profile.friendlyDescription,
            offers: [FreeItemsOffer(potions: potions, consumables: consumables)],
            offerLimit: 1
        )
    }
    
}
