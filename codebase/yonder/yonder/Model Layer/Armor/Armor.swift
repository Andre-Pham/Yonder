//
//  Armor.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class ArmorAbstract: EffectsDescribed, Purchasable, Named, Described, Enhanceable {
    
    public let name: String
    public let description: String
    public let type: ArmorType
    @DidSetPublished private(set) var armorPoints: Int
    public let basePurchasePrice: Int
    private(set) var armorBuffs: [BuffAbstract]
    public let id = UUID()
    @DidSetPublished private(set) var effectsDescription: String?
    
    /// To be called by subclasses only.
    /// - Parameters:
    ///     - type: Where the armor is worn
    ///     - armorPoints: The 'health' of the armor
    ///     - armorBuffs: The effects the armor gives when worn
    init(name: String, description: String, type: ArmorType, armorPoints: Int, basePurchasePrice: Int, armorBuffs: [BuffAbstract]) {
        self.name = name
        self.description = description
        self.type = type
        self.armorPoints = armorPoints
        self.basePurchasePrice = basePurchasePrice
        self.armorBuffs = armorBuffs
        self.effectsDescription = ArmorAbstract.getEffectsDescription(buffs: armorBuffs)
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
        self.effectsDescription = ArmorAbstract.getEffectsDescription(buffs: self.armorBuffs)
    }
    
    func adjustArmorPoints(by armorPoints: Int) {
        self.armorPoints += armorPoints
    }
    
    func getPurchaseInfo() -> PurchaseableItemInfo {
        return PurchaseableItemInfo(name: self.name, description: self.description)
    }
    
    func beRecieved(by reciever: Player, amount: Int) {
        reciever.equipArmor(self)
    }
    
    func getEnhanceInfo() -> EnhanceInfo {
        return EnhanceInfo(id: self.id, name: self.name)
    }
    
}

enum ArmorType {
    case head
    case body
    case legs
}
