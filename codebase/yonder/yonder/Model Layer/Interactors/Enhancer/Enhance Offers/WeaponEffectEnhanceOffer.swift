//
//  WeaponEffectEnhanceOffer.swift
//  yonder
//
//  Created by Andre Pham on 8/4/2022.
//

import Foundation

class WeaponEffectEnhanceOffer: EnhanceOffer {
    
    private let effectPill: WeaponEffectPill
    
    init(price: Int, effectPill: WeaponEffectPill) {
        self.effectPill = effectPill
        super.init(
            price: price,
            name: Strings("enhanceOffer.weaponEffect.name").local,
            description: Strings("enhanceOffer.weaponEffect.description1Param").localWithArgs(effectPill.effectsDescription)
        )
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case effectPill
    }

    required init(dataObject: DataObject) {
        self.effectPill = dataObject.getObject(Field.effectPill.rawValue, type: WeaponEffectPillAbstract.self) as! any WeaponEffectPill
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.effectPill.rawValue, value: self.effectPill)
    }

    // MARK: - Functions
    
    func getEnhanceables(from player: Player) -> [Enhanceable] {
        return player.weapons
    }
    
    func acceptOffer(player: Player, enhanceableID: UUID) {
        if let weapon = player.weapons.first(where: { $0.id == enhanceableID }),
           self.canBePurchased(price: self.price, purchaser: player) {
            
            weapon.addEffect(self.effectPill)
            player.modifyGoldAdjusted(by: -self.price)
        }
    }
    
}
