//
//  Armor.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

typealias ArmorAbstract = ArmorAbstractPart & Purchasable & Named & Described

class ArmorAbstractPart: EffectsDescribed {
    
    public let type: ArmorType
    @DidSetPublished private(set) var armorPoints: Int
    private(set) var armorBuffs: [BuffAbstract]
    public let id = UUID()
    @DidSetPublished private(set) var effectsDescription: String?
    
    /// To be called by subclasses only.
    /// - Parameters:
    ///     - type: Where the armor is worn
    ///     - armorPoints: The 'health' of the armor
    ///     - armorBuffs: The effects the armor gives when worn
    init(type: ArmorType, armorPoints: Int, armorBuffs: [BuffAbstract]) {
        self.type = type
        self.armorPoints = armorPoints
        self.armorBuffs = armorBuffs
        self.effectsDescription = ArmorAbstractPart.getEffectsDescription(buffs: armorBuffs)
    }
    
    private static func getEffectsDescription(buffs: [BuffAbstract]) -> String? {
        var effectsDescription = ""
        for buff in buffs {
            if !effectsDescription.isEmpty {
                effectsDescription += "\n"
            }
            if let buffDescription = buff.effectsDescription {
                effectsDescription += buffDescription
            }
        }
        return effectsDescription.isEmpty ? nil : effectsDescription
    }
    
    func addBuff(buff: BuffAbstract) {
        self.armorBuffs.append(buff)
        self.effectsDescription = ArmorAbstractPart.getEffectsDescription(buffs: self.armorBuffs)
    }
    
    func adjustArmorPoints(by armorPoints: Int) {
        self.armorPoints += armorPoints
    }
    
}

enum ArmorType {
    case head
    case body
    case legs
}
