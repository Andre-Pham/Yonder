//
//  MultiplyGoldConsumable.swift
//  yonder
//
//  Created by Andre Pham on 7/9/2022.
//

import Foundation

class MultiplyGoldConsumable: ConsumableAbstract {
    
    private let goldFraction: Double
    
    init(basePurchasePrice: Int, goldFraction: Double) {
        self.goldFraction = goldFraction
        
        super.init(
            name: Strings.Consumable.MultiplyGold.Name.local,
            description: Strings.Consumable.MultiplyGold.Description.local,
            basePurchasePrice: basePurchasePrice
        )
    }
    
    required init(_ original: ConsumableAbstractPart) {
        let original = original as! Self
        self.goldFraction = original.goldFraction
        super.init(original)
    }
    
    func getEffectsDescription() -> String? {
        let percentage = (100.0*abs(1.0 - self.goldFraction)).toString(decimalPlaces: 0)
        return Strings.Consumable.MultiplyGold.EffectsDescription1Param.localWithArgs(percentage)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract?) {
        if let player = owner as? Player {
            player.modifyGoldAdjusted(by: Int(round(Double(player.gold)*abs(1.0 - self.goldFraction))))
            self.adjustStack(by: -1)
        }
    }
    
    func isStackable(with consumable: ConsumableAbstract) -> Bool {
        if let consumable = consumable as? Self {
            return self.goldFraction == consumable.goldFraction
        }
        return false
    }
    
}
