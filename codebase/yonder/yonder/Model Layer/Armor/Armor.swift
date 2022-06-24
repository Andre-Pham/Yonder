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
    @DidSetPublished private(set) var armorBuffs: [BuffAbstract]
    @DidSetPublished private(set) var armorAttributes: [ArmorAttribute]
    public let id = UUID()
    
    /// To be called by subclasses only.
    /// - Parameters:
    ///   - type: Where the armor is worn
    ///   - armorPoints: The 'health' of the armor
    ///   - basePurchasePrice: The base purchase price of the armor before additional costs
    ///   - armorBuffs: The effects the armor gives when worn
    ///   - armorAttributes: Attributes that apply to the armor
    init(name: String, description: String, type: ArmorType, armorPoints: Int, basePurchasePrice: Int, armorBuffs: [BuffAbstract], armorAttributes: [ArmorAttribute] = []) {
        self.name = name
        self.description = description
        self.type = type
        self.armorPoints = armorPoints
        self.basePurchasePrice = basePurchasePrice
        self.armorBuffs = armorBuffs
        self.armorAttributes = armorAttributes
    }
    
    func getEffectsDescription() -> String? {
        var descriptionLines = [String]()
        descriptionLines.append(contentsOf: self.armorBuffs.compactMap { $0.getEffectsDescription() })
        descriptionLines.append(contentsOf: self.armorAttributes.compactMap { $0.description })
        return descriptionLines.isEmpty ? nil : descriptionLines.joined(separator: "\n")
    }
    
    func addBuff(buff: BuffAbstract) {
        self.armorBuffs.append(buff)
    }
    
    func addAttribute(_ attribute: ArmorAttribute) {
        self.armorAttributes.append(attribute)
    }
    
    func adjustArmorPoints(by armorPoints: Int) {
        self.armorPoints += armorPoints
    }
    
    func getPurchaseInfo() -> PurchasableItemInfo {
        return PurchasableItemInfo(name: self.name, description: self.description, type: .armor)
    }
    
    func beReceived(by receiver: Player, amount: Int) {
        receiver.equipArmor(self)
    }
    
    func getEnhanceInfo() -> EnhanceInfo {
        return EnhanceInfo(id: self.id, name: self.name)
    }
    
    func hasAttribute(_ attribute: ArmorAttribute) -> Bool {
        return self.armorAttributes.contains(attribute)
    }
    
}
