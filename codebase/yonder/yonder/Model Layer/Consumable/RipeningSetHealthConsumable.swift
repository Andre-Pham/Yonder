//
//  RipeningSetHealthConsumable.swift
//  yonder
//
//  Created by Andre Pham on 7/9/2022.
//

import Foundation

class RipeningSetHealthConsumable: ConsumableAbstract, OnTurnEndSubscriber {
    
    enum RipeningStage {
        case stage1
        case stage2
        case stage3
        case stage4
        
        func use(on actor: ActorAbstract) {
            switch self {
            case .stage1: actor.setHealth(to: actor.maxHealth/3)
            case .stage2: actor.setHealth(to: 2*actor.maxHealth/3)
            case .stage3: actor.setHealth(to: actor.maxHealth)
            case .stage4: return
            }
        }
        
        var name: String {
            switch self {
            case .stage1: return Strings.Consumable.RipeningSetHealth.Name.Stage1.local
            case .stage2: return Strings.Consumable.RipeningSetHealth.Name.Stage2.local
            case .stage3: return Strings.Consumable.RipeningSetHealth.Name.Stage3.local
            case .stage4: return Strings.Consumable.RipeningSetHealth.Name.Stage4.local
            }
        }
        
        var description: String {
            switch self {
            case .stage1: return Strings.Consumable.RipeningSetHealth.Description.Stage1.local
            case .stage2: return Strings.Consumable.RipeningSetHealth.Description.Stage2.local
            case .stage3: return Strings.Consumable.RipeningSetHealth.Description.Stage3.local
            case .stage4: return Strings.Consumable.RipeningSetHealth.Description.Stage4.local
            }
        }
    }
    
    private let stage2TurnsRequired = 8
    private let stage3TurnsRequired = 16
    private let stage4TurnsRequired = 24
    private var stage: RipeningStage = .stage1 {
        didSet {
            self.setName(to: self.stage.name)
            self.setDescription(to: self.stage.description)
        }
    }
    private var turnsPassed = 0 {
        didSet {
            if self.turnsPassed == self.stage2TurnsRequired {
                self.stage = .stage2
            } else if self.turnsPassed == self.stage3TurnsRequired {
                self.stage = .stage3
            } else if self.turnsPassed == self.stage4TurnsRequired {
                self.stage = .stage4
            }
            self.setEffectsDescription(to: self.getStageEffectsDescription())
        }
    }
    
    init(basePurchasePrice: Int) {
        super.init(
            name: self.stage.name,
            description: self.stage.description,
            effectsDescription: Strings.Consumable.RipeningSetHealth.EffectsDescription.Stage11Param.localWithArgs(self.stage2TurnsRequired),
            basePurchasePrice: basePurchasePrice
        )
        
        OnTurnEndPublisher.subscribe(self)
    }
    
    required init(_ original: ConsumableAbstractPart) {
        let original = original as! Self
        self.stage = original.stage
        self.turnsPassed = original.turnsPassed
        super.init(original)
        
        OnTurnEndPublisher.subscribe(self)
    }
    
    func getStageEffectsDescription() -> String {
        switch self.stage {
        case .stage1:
            return Strings.Consumable.RipeningSetHealth.EffectsDescription.Stage11Param.localWithArgs(self.stage2TurnsRequired - self.turnsPassed)
        case .stage2:
            return Strings.Consumable.RipeningSetHealth.EffectsDescription.Stage21Param.localWithArgs(self.stage3TurnsRequired - self.turnsPassed)
        case .stage3:
            return Strings.Consumable.RipeningSetHealth.EffectsDescription.Stage31Param.localWithArgs(self.stage4TurnsRequired - self.turnsPassed)
        case .stage4:
            return Strings.Consumable.RipeningSetHealth.EffectsDescription.Stage4.local
        }
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract?) {
        self.stage.use(on: owner)
        self.adjustRemainingUses(by: -1)
    }
    
    func isStackable(with consumable: ConsumableAbstract) -> Bool {
        if let consumable = consumable as? Self {
            return self.stage == consumable.stage && self.turnsPassed == consumable.turnsPassed
        }
        return false
    }
    
    func onTurnEnd(player: Player, playerUsed: ItemAbstract?, foe: Foe?) {
        if player.consumables.contains(where: { $0.id == self.id }) {
            self.turnsPassed += 1
        }
    }
    
}
