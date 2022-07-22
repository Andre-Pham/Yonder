//
//  Accessory.swift
//  yonder
//
//  Created by Andre Pham on 7/7/2022.
//

import Foundation

class Accessory: EffectsDescribed, Purchasable, Named, Described, Enhanceable, Clonable {
    
    public let name: String
    public let description: String
    public let type: AccessoryType
    @DidSetPublished private(set) var healthBonus: Int
    @DidSetPublished private(set) var armorPointsBonus: Int
    public let basePurchasePrice: Int
    @DidSetPublished private(set) var buffs: [BuffAbstract]
    private(set) var effectPills: [EquipmentPillAbstract]
    public let id = UUID()
    
    /// To be called by subclasses only.
    /// - Parameters:
    ///   - type: The type of accessory which determines the slot in which it may be equipped
    ///   - healthBonus: The health this provides as a bonus
    ///   - armorPointsBonus: The armor points this provides as a bonus
    ///   - basePurchasePrice: The base purchase price of this before additional costs
    ///   - buffs: The buffs this gives when worn
    ///   - effectPills: The effects this gives when worn
    init(name: String, description: String, type: AccessoryType, healthBonus: Int, armorPointsBonus: Int, basePurchasePrice: Int, buffs: [BuffAbstract], effectPills: [EquipmentPillAbstract]) {
        self.name = name
        self.description = description
        self.type = type
        self.healthBonus = healthBonus
        self.armorPointsBonus = armorPointsBonus
        self.basePurchasePrice = basePurchasePrice
        self.buffs = buffs
        self.effectPills = effectPills
    }
    
    required init(_ original: Accessory) {
        self.name = original.name
        self.description = original.description
        self.type = original.type
        self.healthBonus = original.healthBonus
        self.armorPointsBonus = original.armorPointsBonus
        self.basePurchasePrice = original.basePurchasePrice
        self.buffs = original.buffs.clone()
        self.effectPills = original.effectPills.map { $0.clone() }
    }
    
    func getEffectsDescription() -> String? {
        var descriptionLines = [String]()
        descriptionLines.append(contentsOf: self.buffs.compactMap { $0.getEffectsDescription() })
        descriptionLines.append(contentsOf: self.effectPills.map { $0.effectsDescription })
        return descriptionLines.isEmpty ? nil : descriptionLines.joined(separator: "\n")
    }
    
    func addBuff(buff: BuffAbstract) {
        self.buffs.append(buff)
    }
    
    func adjustArmorPointBonus(by armorPoints: Int) {
        self.armorPointsBonus += armorPoints
    }
    
    func adjustHealthBonus(by health: Int) {
        self.healthBonus += health
    }
    
    func getPurchaseInfo() -> PurchasableItemInfo {
        return PurchasableItemInfo(name: self.name, description: self.description, type: .accessory)
    }
    
    func getEnhanceInfo() -> EnhanceInfo {
        return EnhanceInfo(id: self.id, name: self.name)
    }
    
    func beReceived(by receiver: Player, amount: Int) {
        // Under purchasing circumstances
        // 1. Have the player select the accessory slot
        // 2. Remove the accessory in that slot, if applicable
        // 3. Call this
        receiver.equipAccessory(self, replacing: nil)
    }
    
}
