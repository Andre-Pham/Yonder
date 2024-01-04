//
//  FoeViewModel.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import Foundation
import Combine
import SwiftUI

class FoeViewModel: ActorViewModel {
    
    // foe can be used within the ViewModel layer, but Views should only interact with ViewModels (not the Model layer)
    private(set) var foe: Foe
    private var subscriptions: Set<AnyCancellable> = []
    
    private(set) var id: UUID
    private(set) var name: String
    private(set) var description: String
    public let typeName: String?
    public let typeDescription: String?
    public let typeImage: Image?
    @Published private(set) var health: Int
    @Published private(set) var maxHealth: Int
    @Published private(set) var isDead: Bool
    /// Gold stolen by goblins
    @Published private(set) var goldSteal: Int? = nil
    
    @Published private(set) var weaponViewModel: WeaponViewModel
    @Published private(set) var lootOptionsViewModel: LootOptionsViewModel?
    @Published private(set) var lootChoiceViewModel: LootChoiceViewModel?
    
    public var damageStatIsVisible: Bool {
        // Don't use indicative damage, if the damage is 0 because of buffs that should be visible
        self.weaponViewModel.damage > 0
    }
    public var goldStealStatIsVisible: Bool {
        if let goldSteal = self.goldSteal {
            return goldSteal > 0
        }
        return false
    }
    
    init(_ foe: Foe) {
        self.foe = foe
        
        // Set properties to match Interactor
        
        self.id = self.foe.id
        self.name = self.foe.name
        self.description = self.foe.description
        self.typeName = self.foe.typeName
        self.typeDescription = self.foe.typeDescription
        self.typeImage = self.foe.typeImageResource?.image
        self.health = self.foe.health
        self.maxHealth = self.foe.maxHealth
        self.isDead = self.foe.isDead
        
        // Set other view models
        
        self.weaponViewModel = WeaponViewModel(self.foe.getWeapon())
        if let lootOptions = self.foe.loot {
            self.lootOptionsViewModel = LootOptionsViewModel(lootOptions)
        } else {
            self.lootOptionsViewModel = nil
        }
        if let lootChoice = self.foe.lootChoice {
            self.lootChoiceViewModel = LootChoiceViewModel(lootChoice)
        } else {
            self.lootChoiceViewModel = nil
        }
        
        super.init(self.foe)
        
        // Add Subscribers
        
        self.foe.$health.sink(receiveValue: { newValue in
            self.health = newValue
            self.isDead = self.foe.isDead
        }).store(in: &self.subscriptions)
        
        self.foe.$maxHealth.sink(receiveValue: { newValue in
            self.maxHealth = newValue
        }).store(in: &self.subscriptions)
        
        // Setup goblin
        
        if let goblinEffectPill = self.foe.getWeapon().effectPills.first(where: { $0 is GoblinEffectPill }) {
            let pill = (goblinEffectPill as! GoblinEffectPill)
            self.goldSteal = pill.goldPerSteal
            self.weaponViewModel.$damage.sink(receiveValue: { newValue in
                self.goldSteal = newValue == 0 ? pill.goldPerSteal : 0
            }).store(in: &self.subscriptions)
        }
    }
    
    func getIndicativeDamage() -> Int {
        return self.foe.getIndicativeDamage(of: self.foe.getWeapon(), opposition: GameManager.instance.playerVM.player)
    }
    
}
