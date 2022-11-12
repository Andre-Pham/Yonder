//
//  AllFriendlies.swift
//  yonder
//
//  Created by Andre Pham on 27/12/21.
//

import Foundation

enum Friendlies {
    
    static func newTestFriendly() -> Friendly {
        return Friendly(
            offers: [
                FreeGoldOffer(goldAmount: 500),
                PurchaseWeaponOffer(weapon: Weapon(basePill: DamageBasePill(damage: 500), durabilityPill: InfiniteDurabilityPill()), price: 400)
            ],
            offerLimit: 2)
    }
    
    static func newGoldOrRestorationFriendly(profile: FriendlyProfile, stage: Int) -> Friendly {
        let restorationAmount = 150.0.compound(multiply: 1.1, index: stage).toRoundedInt()
        let goldAmount = Pricing.usingStage(stage: stage) {
            // Bonus because otherwise immediate value of restoration is almost always better than potential value provided by gold
            (Double(Pricing.playerHealthRestorationStat.getValue(amount: restorationAmount))*1.25)
                .toRoundedInt()
        }
        return Friendly(
            name: profile.friendlyName,
            description: profile.friendlyDescription,
            offers: [
                FreeGoldOffer(goldAmount: goldAmount),
                FreeRestorationOffer(restorationAmount: restorationAmount)
            ],
            offerLimit: 1
        )
    }
    
    static func newDragonSlayerFriendly(profile: FriendlyProfile, stage: Int) -> Friendly {
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
            name: profile.friendlyName,
            description: profile.friendlyDescription,
            offers: [
                PurchaseWeaponOffer(weapon: dragonSlayer, price: price)
            ],
            offerLimit: 1
        )
    }
    
    static func newHealthForGoldFriendly(profile: FriendlyProfile, stage: Int) -> Friendly {
        let health = 100
        let goldReward = Pricing.usingStage(stage: stage) {
            let fairPrice = Pricing.foeDamageStat.getValue(amount: health)
            return Random.selectFromNormalDistribution(min: fairPrice, max: (Double(fairPrice)*1.5).toRoundedInt())
        }
        return Friendly(
            name: profile.friendlyName,
            description: profile.friendlyDescription,
            offers: [
                HealthForGoldOffer(health: health, goldReward: goldReward)
            ],
            offerLimit: 10
        )
    }
    
    static func newShivFriendly(profile: FriendlyProfile, stage: Int) -> Friendly {
        let shiv = Weapon(
            name: Strings("weapon.simpleShiv.name").local,
            description: Strings("weapon.simpleShiv.description").local,
            basePill: DamageBasePill(damage: 15),
            durabilityPill: InfiniteDurabilityPill(),
            effectPills: [],
            buffPills: []
        )
        return Friendly(
            name: profile.friendlyName,
            description: profile.friendlyDescription,
            offers: [
                FreeWeaponOffer(weapon: shiv)
            ],
            offerLimit: 1
        )
    }
    
    static func newSellPotionsFriendly(profile: FriendlyProfile, stage: Int) -> Friendly {
        return Friendly(
            name: profile.friendlyName,
            description: profile.friendlyDescription,
            offers: [SellPotionsOffer()],
            offerLimit: 1
        )
    }
    
    static func newMaxPointsForArmorPointsFriendly(profile: FriendlyProfile, stage: Int) -> Friendly {
        return Friendly(
            name: profile.friendlyName,
            description: profile.friendlyDescription,
            offers: [MaxHealthForArmorPointsOffer()],
            offerLimit: Int.random(in: 1...3)
        )
    }
    
}
