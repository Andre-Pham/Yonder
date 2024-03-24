//
//  AutomatedAnimationQueue.swift
//  yonder
//
//  Created by Andre Pham on 9/6/2023.
//

import Foundation
import Combine

class NPCAnimation: AnimationQueue<NPCSequenceCode>, AfterPlayerKillFoeSubscriber, OnActorAttackSubscriber, AfterPlayerTravelSubscriber {
    
    private var subscriptions: Set<AnyCancellable> = []
    private let optionsStateManager: OptionsStateManager
    
    init(optionsStateManager: OptionsStateManager) {
        self.optionsStateManager = optionsStateManager
        let location = GameManager.instance.playerVM.player.location
        super.init(fileID: Self.getFileID(location: location), defaultAnimation: .breathing)
        
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
    
    override func setupSequences() {
        super.setupSequences()
        self.getSequence(.death).setLoopBehaviour(to: false)
        self.getSequence(.attack).setLoopBehaviour(to: false)
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
        self.setFileID(to: Self.getFileID(location: player.location))
        
        // If the queue was ended due to a foe dying, this reinitialises it
        // It also clears the queue (always)
        self.reinitialiseQueue()
    }
    
    private static func getFileID(location: Location) -> String? {
        switch location.type {
        case .shop, .enhancer, .restorer, .friendly:
            let contentID = (location as? InteractorLocation)?.getInteractor()?.contentID
            return contentID
        case .none, .starting, .bridge:
            return nil
        case .hostile, .challengeHostile, .boss:
            let contentID = (location as? FoeLocation)?.foe.contentID
            return contentID
        }
    }
    
}
