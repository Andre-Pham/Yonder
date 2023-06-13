//
//  Armor.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

class Armor: EffectsDescribed, Purchasable, Named, Described, Enhanceable, Clonable, Storable {
    
    public let name: String
    public let description: String
    public let type: ArmorType
    @DidSetPublished private(set) var armorPoints: Int {
        willSet {
            OnArmorArmorPointsChangePublisher.publish(armor: self, change: newValue - self.armorPoints)
        }
    }
    @DidSetPublished private(set) var armorBuffs: [Buff]
    @DidSetPublished private(set) var equipmentPills: [EquipmentPill]
    @DidSetPublished private(set) var armorAttributes: [ArmorAttribute]
    public let id = UUID()
    
    /// - Parameters:
    ///   - name: The name of the armor (flavor)
    ///   - description: Flavor text description of the armor
    ///   - type: Where the armor is worn
    ///   - armorPoints: The 'health' of the armor
    ///   - armorBuffs: The buffs/debuffs the armor gives when worn
    ///   - equipmentPills: The effects this gives when worn
    ///   - armorAttributes: Attributes that apply to the armor
    init(name: String, description: String, type: ArmorType, armorPoints: Int, armorBuffs: [Buff], equipmentPills: [EquipmentPill], armorAttributes: [ArmorAttribute] = []) {
        self.name = name
        self.description = description
        self.type = type
        self.armorPoints = armorPoints
        self.armorBuffs = armorBuffs
        self.equipmentPills = equipmentPills
        self.armorAttributes = armorAttributes
    }
    
    required init(_ original: Armor) {
        self.name = original.name
        self.description = original.description
        self.type = original.type
        self.armorPoints = original.armorPoints
        self.armorBuffs = original.armorBuffs.map { $0.clone() }
        self.equipmentPills = original.equipmentPills.map { $0.clone() }
        self.armorAttributes = Array(original.armorAttributes)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case name
        case description
        case type
        case armorPoints
        case armorBuffs
        case equipmentPills
        case armorAttributes
    }

    required init(dataObject: DataObject) {
        self.name = dataObject.get(Field.name.rawValue)
        self.description = dataObject.get(Field.description.rawValue)
        self.type = ArmorType(rawValue: dataObject.get(Field.type.rawValue)) ?? .body
        self.armorPoints = dataObject.get(Field.armorPoints.rawValue)
        self.armorBuffs = dataObject.getObjectArray(Field.armorBuffs.rawValue, type: BuffAbstract.self) as! [any Buff]
        self.equipmentPills = dataObject.getObjectArray(Field.equipmentPills.rawValue, type: EquipmentPillAbstract.self) as! [any EquipmentPill]
        let attributes: [ArmorAttribute?] = dataObject.get(Field.armorAttributes.rawValue).map { ArmorAttribute(rawValue: $0) }
        self.armorAttributes = attributes.compactMap({ $0 })
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.name.rawValue, value: self.name)
            .add(key: Field.description.rawValue, value: self.description)
            .add(key: Field.type.rawValue, value: self.type.rawValue)
            .add(key: Field.armorPoints.rawValue, value: self.armorPoints)
            .add(key: Field.armorBuffs.rawValue, value: self.armorBuffs as [BuffAbstract])
            .add(key: Field.equipmentPills.rawValue, value: self.equipmentPills as [EquipmentPillAbstract])
            .add(key: Field.armorAttributes.rawValue, value: self.armorAttributes.map { $0.rawValue })
    }

    // MARK: - Functions
    
    func getEffectsDescription() -> String? {
        var descriptionLines = [String]()
        descriptionLines.append(contentsOf: self.armorBuffs.compactMap { $0.getEffectsDescription() })
        descriptionLines.append(contentsOf: self.equipmentPills.map { $0.effectsDescription })
        descriptionLines.append(contentsOf: self.armorAttributes.compactMap { $0.description })
        return descriptionLines.isEmpty ? nil : descriptionLines.joined(separator: "\n")
    }
    
    func addBuff(buff: Buff) {
        let toAdd = buff.clone()
        toAdd.updateSource(to: self.name)
        self.armorBuffs.append(toAdd)
    }
    
    func addEquipmentPill(_ pill: EquipmentPill) {
        let toAdd = pill.clone()
        toAdd.updateSource(to: self.name)
        self.equipmentPills.append(toAdd)
    }
    
    func hasEffect(_ equipmentPill: EquipmentPill) -> Bool {
        return self.equipmentPills.contains(where: { $0.id == equipmentPill.id })
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
    
    func getBasePurchasePrice() -> Int {
        // Purchases are always made by the player, and armors' buffs apply to their owner
        // hence buff target is player, along with the health, armor points and equipment pills
        var totalValue = Pricing.playerArmorPointsStat.getValue(amount: self.armorPoints)
        for buff in self.armorBuffs {
            totalValue += buff.getValue(whenTargeting: .player)
        }
        for pill in self.equipmentPills {
            totalValue += pill.getValue(whenTargeting: .player)
        }
        return totalValue
    }
    
}
