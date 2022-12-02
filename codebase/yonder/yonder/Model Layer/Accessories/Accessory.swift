//
//  Accessory.swift
//  yonder
//
//  Created by Andre Pham on 7/7/2022.
//

import Foundation

class Accessory: EffectsDescribed, Purchasable, Named, Described, Enhanceable, Clonable, Storable {
    
    public let name: String
    public let description: String
    public let type: AccessoryType
    @DidSetPublished private(set) var healthBonus: Int
    @DidSetPublished private(set) var armorPointsBonus: Int
    @DidSetPublished private(set) var buffs: [Buff]
    @DidSetPublished private(set) var equipmentPills: [EquipmentPill]
    public let id = UUID()
    
    /// To be called by subclasses only.
    /// - Parameters:
    ///   - type: The type of accessory which determines the slot in which it may be equipped
    ///   - healthBonus: The health this provides as a bonus
    ///   - armorPointsBonus: The armor points this provides as a bonus
    ///   - buffs: The buffs/debuffs this gives when worn
    ///   - equipmentPills: The effects this gives when worn
    init(name: String, description: String, type: AccessoryType, healthBonus: Int, armorPointsBonus: Int, buffs: [Buff], equipmentPills: [EquipmentPill]) {
        self.name = name
        self.description = description
        self.type = type
        self.healthBonus = healthBonus
        self.armorPointsBonus = armorPointsBonus
        self.buffs = buffs
        self.equipmentPills = equipmentPills
    }
    
    required init(_ original: Accessory) {
        self.name = original.name
        self.description = original.description
        self.type = original.type
        self.healthBonus = original.healthBonus
        self.armorPointsBonus = original.armorPointsBonus
        self.buffs = original.buffs.map { $0.clone() }
        self.equipmentPills = original.equipmentPills.map { $0.clone() }
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case name
        case description
        case type
        case healthBonus
        case armorPointsBonus
        case buffs
        case equipmentPills
    }

    required init(dataObject: DataObject) {
        self.name = dataObject.get(Field.name.rawValue)
        self.description = dataObject.get(Field.description.rawValue)
        self.type = AccessoryType(rawValue: dataObject.get(Field.type.rawValue)) ?? .regular
        self.healthBonus = dataObject.get(Field.healthBonus.rawValue)
        self.armorPointsBonus = dataObject.get(Field.armorPointsBonus.rawValue)
        self.buffs = dataObject.getObjectArray(Field.buffs.rawValue, type: BuffAbstract.self) as! [any Buff]
        self.equipmentPills = dataObject.getObjectArray(Field.equipmentPills.rawValue, type: EquipmentPillAbstract.self) as! [any EquipmentPill]
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.name.rawValue, value: self.name)
            .add(key: Field.description.rawValue, value: self.description)
            .add(key: Field.type.rawValue, value: self.type.rawValue)
            .add(key: Field.healthBonus.rawValue, value: self.healthBonus)
            .add(key: Field.armorPointsBonus.rawValue, value: self.armorPointsBonus)
            .add(key: Field.buffs.rawValue, value: self.buffs)
            .add(key: Field.equipmentPills.rawValue, value: self.equipmentPills)
    }

    // MARK: - Functions
    
    func getEffectsDescription() -> String? {
        var descriptionLines = [String]()
        descriptionLines.append(contentsOf: self.buffs.compactMap { $0.getEffectsDescription() })
        descriptionLines.append(contentsOf: self.equipmentPills.map { $0.effectsDescription })
        return descriptionLines.isEmpty ? nil : descriptionLines.joined(separator: "\n")
    }
    
    func addBuff(buff: Buff) {
        let toAdd = buff.clone()
        toAdd.updateSource(to: self.name)
        self.buffs.append(toAdd)
    }
    
    func addEquipmentPill(_ pill: EquipmentPill) {
        let toAdd = pill.clone()
        toAdd.updateSource(to: self.name)
        self.equipmentPills.append(toAdd)
    }
    
    func hasEffect(_ equipmentPill: EquipmentPill) -> Bool {
        return self.equipmentPills.contains(where: { $0.id == equipmentPill.id })
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
    
    func getBasePurchasePrice() -> Int {
        // Purchases are always made by the player, and accessories' buffs apply to their owner
        // hence buff target is player, along with the health, armor points and equipment pills
        var totalValue = Pricing.playerHealthStat.getValue(amount: self.healthBonus) + Pricing.playerArmorPointsStat.getValue(amount: self.armorPointsBonus)
        for buff in self.buffs {
            totalValue += buff.getValue(whenTargeting: .player)
        }
        for pill in self.equipmentPills {
            totalValue += pill.getValue(whenTargeting: .player)
        }
        return totalValue
    }
    
}
