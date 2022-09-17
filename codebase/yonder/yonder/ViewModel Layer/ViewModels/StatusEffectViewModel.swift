//
//  StatusEffectViewModel.swift
//  yonder
//
//  Created by Andre Pham on 24/6/2022.
//

import Foundation
import Combine

class StatusEffectViewModel: ObservableObject {
    
    private(set) var statusEffect: StatusEffect
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var timeRemaining: Int
    public let initialTimeRemaining: Int
    public let name: String
    public let effectsDescription: String?
    public let id: UUID
    
    init(_ statusEffect: StatusEffect) {
        self.statusEffect = statusEffect
        
        self.timeRemaining = statusEffect.timeRemaining
        self.initialTimeRemaining = statusEffect.initialTimeRemaining
        self.name = statusEffect.name
        self.effectsDescription = statusEffect.getEffectsDescription()
        self.id = statusEffect.id
        
        self.statusEffect.$timeRemaining.sink(receiveValue: { newValue in
            self.timeRemaining = newValue
        }).store(in: &self.subscriptions)
    }
    
    func getIndicativeValue(playerViewModel: PlayerViewModel) -> Int? {
        return self.statusEffect.getIndicativeValue(target: playerViewModel.player)
    }
    
}
