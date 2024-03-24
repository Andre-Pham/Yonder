//
//  LandmarkAnimation.swift
//  yonder
//
//  Created by Andre Pham on 22/3/2024.
//

import Foundation
import Combine

class LandmarkAnimation: AnimationQueue<LandmarkSequenceCode>, AfterPlayerTravelSubscriber {
    
    init() {
        let location = GameManager.instance.playerVM.player.location
        super.init(fileID: Self.getFileID(location: location), defaultAnimation: .idle)
        
        AfterPlayerTravelPublisher.subscribe(self)
    }
    
    func afterPlayerTravel(player: Player) {
        self.setFileID(to: Self.getFileID(location: player.location))
        // Clear the queue so previous locations' queued animations don't continue playing
        self.reinitialiseQueue()
    }
    
    private static func getFileID(location: Location) -> String? {
        switch location.type {
        case .shop, .enhancer, .restorer, .friendly, .boss, .challengeHostile, .hostile, .none:
            return nil
        case .starting:
            return "L0001"
        case .bridge:
            return "L0002"
        }
    }
    
}
