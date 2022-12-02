//
//  RipeningSetHealthConsumable.swift
//  yonder
//
//  Created by Andre Pham on 7/9/2022.
//

import Foundation

class RipeningSetHealthConsumable: Consumable, OnPlayerTravelSubscriber {
    
    enum RipeningStage: Int {
        case stage1 = 1
        case stage2 = 2
        case stage3 = 3
        case stage4 = 4
        
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
            case .stage1: return Strings("consumable.ripeningSetHealth.name.stage1").local
            case .stage2: return Strings("consumable.ripeningSetHealth.name.stage2").local
            case .stage3: return Strings("consumable.ripeningSetHealth.name.stage3").local
            case .stage4: return Strings("consumable.ripeningSetHealth.name.stage4").local
            }
        }
        
        var description: String {
            switch self {
            case .stage1: return Strings("consumable.ripeningSetHealth.description.stage1").local
            case .stage2: return Strings("consumable.ripeningSetHealth.description.stage2").local
            case .stage3: return Strings("consumable.ripeningSetHealth.description.stage3").local
            case .stage4: return Strings("consumable.ripeningSetHealth.description.stage4").local
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
    
    init(amount: Int) {
        super.init(
            name: self.stage.name,
            description: self.stage.description,
            effectsDescription: Strings("consumable.ripeningSetHealth.effectsDescription.stage11Param").localWithArgs(self.stage2TurnsRequired),
            remainingUses: amount
        )
        
        OnPlayerTravelPublisher.subscribe(self)
    }
    
    required init(_ original: ConsumableAbstract) {
        let original = original as! Self
        self.stage = original.stage
        self.turnsPassed = original.turnsPassed
        super.init(original)
        
        OnPlayerTravelPublisher.subscribe(self)
    }
    
    // MARK: - Serialisation
    
    private enum Field: String {
        case stage
        case turnsPassed
    }
    
    required init(dataObject: DataObject) {
        self.stage = RipeningStage(rawValue: dataObject.get(Field.stage.rawValue)) ?? .stage1
        self.turnsPassed = dataObject.get(Field.turnsPassed.rawValue)
        super.init(dataObject: dataObject)
        
        OnPlayerTravelPublisher.subscribe(self)
    }
    
    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.stage.rawValue, value: self.stage.rawValue)
            .add(key: Field.turnsPassed.rawValue, value: self.turnsPassed)
    }
    
    // MARK: - Functions
    
    func getStageEffectsDescription() -> String {
        switch self.stage {
        case .stage1:
            return Strings("consumable.ripeningSetHealth.effectsDescription.stage11Param").localWithArgs(self.stage2TurnsRequired - self.turnsPassed)
        case .stage2:
            return Strings("consumable.ripeningSetHealth.effectsDescription.stage21Param").localWithArgs(self.stage3TurnsRequired - self.turnsPassed)
        case .stage3:
            return Strings("consumable.ripeningSetHealth.effectsDescription.stage31Param").localWithArgs(self.stage4TurnsRequired - self.turnsPassed)
        case .stage4:
            return Strings("consumable.ripeningSetHealth.effectsDescription.stage4").local
        }
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract?) {
        self.stage.use(on: owner)
        self.adjustRemainingUses(by: -1)
    }
    
    func isStackable(with consumable: Consumable) -> Bool {
        if let consumable = consumable as? Self {
            return self.stage == consumable.stage && self.turnsPassed == consumable.turnsPassed
        }
        return false
    }
    
    func onPlayerTravel(player: Player, newLocation: Location) {
        if player.consumables.contains(where: { $0.id == self.id }) {
            self.turnsPassed += 1
        }
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerHealthRestorationStat.getValue(amount: Pricing.playerHealthStat.baseStatAmount/2, uses: self.remainingUses)
    }
    
}
