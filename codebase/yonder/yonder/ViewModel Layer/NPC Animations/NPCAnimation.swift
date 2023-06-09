//
//  AutomatedAnimationQueue.swift
//  yonder
//
//  Created by Andre Pham on 9/6/2023.
//

import Foundation
import Combine

class NPCAnimation: AnimationQueue, AfterPlayerKillFoeSubscriber, OnActorAttackSubscriber, AfterPlayerTravelSubscriber {
    
    private var subscriptions: Set<AnyCancellable> = []
    private let optionsStateManager: OptionsStateManager
    
    init?(optionsStateManager: OptionsStateManager) {
        self.optionsStateManager = optionsStateManager
        super.init(fileID: "E0001", defaultAnimation: .breathing)
        
        if let foeIsDead = GameManager.instance.foeViewModel?.isDead, foeIsDead {
            // If we start the game and the foe is already dead, skip straight to the end of the death sequence
            self.addToQueue(sequence: .death)
            self.endQueue()
            self.skipToEnd()
        }
        
        self.optionsStateManager.$weaponActionsActive.sink(receiveValue: { isActive in
            if isActive {
                self.changeDefaultSequence(to: .idle)
            } else {
                self.changeDefaultSequence(to: .breathing)
            }
        }).store(in: &self.subscriptions)
        
        AfterPlayerKillFoePublisher.subscribe(self)
        OnActorAttackPublisher.subscribe(self)
        AfterPlayerTravelPublisher.subscribe(self)
    }
    
    func afterPlayerKillFoe(player: Player, foe: Foe) {
        self.clearQueue()
        self.addToQueue(sequence: .death)
        self.endQueue()
    }
    
    func onActorAttack(actor: ActorAbstract, weapon: Weapon, target: ActorAbstract) {
        if actor is Foe {
            self.addToQueue(sequence: .attack)
        }
    }
    
    func afterPlayerTravel(player: Player) {
        // TODO: Change default animation and file ID and stuff here
        switch player.location.type {
        case .shop, .enhancer, .restorer, .friendly:
            break
        case .none, .quest, .bridge:
            // Set animation to none here
            break
        case .hostile, .challengeHostile, .boss:
            break
        }
        
        self.reinitialiseQueue()
    }
    
}
