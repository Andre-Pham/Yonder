//
//  EnhancerFactory.swift
//  yonder
//
//  Created by Andre Pham on 11/11/2022.
//

import Foundation

class EnhancerFactory {
    
    private let stage: Int
    private let areaTags: AreaProfileTagAllocation
    private let enhancerProfileBucket: EnhancerProfileBucket
    private var enhancerSupply = [Enhancer]()
    
    init(stage: Int, areaTags: AreaProfileTagAllocation, enhancerProfileBucket: EnhancerProfileBucket) {
        self.stage = stage
        self.areaTags = areaTags
        self.enhancerProfileBucket = enhancerProfileBucket
    }
    
    private func buildEnhancer(stage: Int, tags: AreaProfileTagAllocation) -> Enhancer {
        let profile = self.enhancerProfileBucket.grabProfile(areaTag: tags.getTag())
        var offers = [EnhanceOffer]()
        let offerCount = Int.random(in: 2...4)
        while offers.count < offerCount {
            // Order doesn't affect outcome because the loop doesn't immediately break if the offer count is reached
            if Random.roll(1, in: 10) {
                offers.append(EnhanceOffers.newWeaponDamage(stage: stage))
            }
            if Random.roll(1, in: 30) {
                offers.append(EnhanceOffers.newWeaponLifesteal(stage: stage))
            }
            // TODO: Add remaining enhance offers
        }
        return Enhancer(
            name: profile.enhancerName,
            description: profile.enhancerDescription,
            offers: Array(offers.prefix(offerCount))
        )
    }
    
    func deliver() -> Enhancer {
        return self.buildEnhancer(stage: self.stage, tags: self.areaTags)
    }
    
    func deliver(count: Int) -> [Enhancer] {
        var enhancers = [Enhancer]()
        enhancers.populate(count: count) {
            self.buildEnhancer(stage: self.stage, tags: self.areaTags)
        }
        return enhancers
    }
    
}
