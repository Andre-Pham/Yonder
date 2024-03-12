//
//  RegionBasedFactory.swift
//  yonder
//
//  Created by Andre Pham on 13/3/2024.
//

import Foundation

/// When a factory generates content on-demand during the game that corresponds to a specific region.
/// Created so that factories may also deliver a region tag for on-demand profile retrieval when the npc/content is otherwise pre-generated.
protocol RegionBasedFactory {
    
    func deliverRegionTag() -> RegionProfileTag
    
}
