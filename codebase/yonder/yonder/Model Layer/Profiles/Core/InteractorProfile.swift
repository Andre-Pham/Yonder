//
//  InteractorProfile.swift
//  yonder
//
//  Created by Andre Pham on 5/7/2023.
//

import Foundation

protocol InteractorProfileBucket {
    
    /// All interactor profile buckets share the same source of profiles (NPC Data). This is because a single profile can match different roles.
    /// For instance, a "travelling warrior" may be a merchant or an enhancer.
    /// It doesn't make sense to label this example as only a merchant or only an enhancer. Labelling them as either is more flexible.
    /// This means the ShopKeeperProfileBucket and the EnhancerProfileBucket both will be initiated with (in this example) "travelling warrior" in their buckets.
    /// When one of them have travelling warrior taken out of their bucket, the ContentManager (triggered by the player travelling and initialising location content) will call this method to remove any profile with travelling warrior's id, so that travelling warrior doesn't show up more than once within a game.
    func markProfileIDUsed(id: String)
    
}
