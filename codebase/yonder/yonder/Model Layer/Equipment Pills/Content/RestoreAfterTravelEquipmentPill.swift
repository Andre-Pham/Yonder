//
//  RestoreAfterTravelEquipmentPill.swift
//  yonder
//
//  Created by Andre Pham on 17/11/2022.
//

import Foundation

class RestoreAfterTravelEquipmentPill: EquipmentPill, OnPlayerTravelSubscriber {
    
    private let restoration: Int
    
    init(restoration: Int, sourceName: String) {
        self.restoration = restoration
        
        super.init(
            sourceName: sourceName,
            effectsDescription: Strings("equipmentPill.restoreAfterTravel.effectsDescription1Param").localWithArgs(restoration)
        )
        
        OnPlayerTravelPublisher.subscribe(self)
    }
    
    required init(_ original: EquipmentPillAbstract) {
        let original = original as! Self
        self.restoration = original.restoration
        
        super.init(original)
        
        OnPlayerTravelPublisher.subscribe(self)
    }
    
    func onPlayerTravel(player: Player, newLocation: Location) {
        if player.hasEquipmentEffect(self) {
            player.restoreAdjusted(sourceOwner: player, using: self, for: self.restoration)
        }
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        switch target {
        case .player:
            return Pricing.playerArmorPointsRestorationStat.getValue(amount: self.restoration, uses: Pricing.Stat.infiniteDuration)
        case .foe:
            // Foes don't travel
            return 0
        }
    }
    
}