//
//  EnhancerFactory.swift
//  yonder
//
//  Created by Andre Pham on 11/11/2022.
//

import Foundation

class EnhancerFactory {
    
    private let stage: Int
    private let regionTags: RegionTagAllocation
    private let enhancerProfileBucket: EnhancerProfileBucket
    
    init(stage: Int, regionTags: RegionTagAllocation, enhancerProfileBucket: EnhancerProfileBucket) {
        self.stage = stage
        self.regionTags = regionTags
        self.enhancerProfileBucket = enhancerProfileBucket
    }
    
    private func buildEnhancer(stage: Int, tags: RegionTagAllocation) -> Enhancer {
        let profile = self.enhancerProfileBucket.grabProfile(areaTag: tags.getTag())
        var offers = [EnhanceOffer]()
        let offerCount = Int.random(in: 2...4)
        while offers.count < offerCount {
            // Order doesn't affect outcome because the loop doesn't immediately break if the offer count is reached
            // It's less optimal to add lots of each and shuffle because that can cause many duplicate enhance offers
            
            // 01
            if Random.roll(1, in: 5) {
                offers.append(EnhanceOffers.damageForWeapon(stage: stage))
            }
            // 02
            if Random.roll(1, in: 15) {
                offers.append(EnhanceOffers.lifestealForWeapon(stage: stage))
            }
            // 03
            if Random.roll(1, in: 15) {
                offers.append(EnhanceOffers.burnForWeapon(stage: stage))
            }
            // 04
            if Random.roll(1, in: 5) {
                offers.append(EnhanceOffers.durabilityForWeapon(stage: stage))
            }
            // 05
            if Random.roll(1, in: 15) {
                offers.append(EnhanceOffers.growDamageForWeapon(stage: stage))
            }
            // 06
            if Random.roll(1, in: 10) {
                offers.append(EnhanceOffers.resistanceForArmor(stage: stage))
            }
            // 07
            if Random.roll(1, in: 10) {
                offers.append(EnhanceOffers.damagePercentForArmor(stage: stage))
            }
            // 08
            if Random.roll(1, in: 5) {
                offers.append(EnhanceOffers.armorPointsForArmor(stage: stage))
            }
            // 09
            if Random.roll(1, in: 15) {
                offers.append(EnhanceOffers.thornsForArmor(stage: stage))
            }
            // 10
            if Random.roll(1, in: 15) {
                offers.append(EnhanceOffers.bonusHealthForAccessory(stage: stage))
            }
            // 11
            if Random.roll(1, in: 15) {
                offers.append(EnhanceOffers.phoenixForEquipment(stage: stage))
            }
            // 12
            if Random.roll(1, in: 20) {
                offers.append(EnhanceOffers.doubleHealthRestorationForWeapon(stage: stage))
            }
            // 13
            if Random.roll(1, in: 20) {
                offers.append(EnhanceOffers.doubleArmorPointsRestorationForWeapon(stage: stage))
            }
            // 14
            if Random.roll(1, in: 15) {
                offers.append(EnhanceOffers.goldPercentBuffForAccessory(stage: stage))
            }
            // 15
            if Random.roll(1, in: 15) {
                offers.append(EnhanceOffers.pricePercentBuffForAccessory(stage: stage))
            }
        }
        if offers.count > offerCount {
            offers.shuffle()
            offers = Array(offers.prefix(offerCount))
        }
        return Enhancer(
            contentID: nil, // TODO: Add content id
            name: profile.enhancerName,
            description: profile.enhancerDescription,
            offers: offers
        )
    }
    
    func deliver() -> Enhancer {
        return self.buildEnhancer(stage: self.stage, tags: self.regionTags)
    }
    
    func deliver(count: Int) -> [Enhancer] {
        var enhancers = [Enhancer]()
        enhancers.populate(count: count) {
            self.buildEnhancer(stage: self.stage, tags: self.regionTags)
        }
        return enhancers
    }
    
}
