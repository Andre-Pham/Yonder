//
//  Weapon.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class Weapon: Item, Usable, Purchasable, Clonable, Enhanceable {
    
    private let basePill: WeaponBasePill
    @DidSetPublished private(set) var durabilityPill: WeaponDurabilityPill {
        didSet {
            WeaponPillBox.setDurabilityPills(weapon: self)
        }
    }
    @DidSetPublished private(set) var effectPills: [WeaponEffectPill] {
        didSet {
            WeaponPillBox.setEffectPills(weapon: self)
        }
    }
    @DidSetPublished private(set) var buffPills: [WeaponBuffPill] {
        didSet {
            WeaponPillBox.setBuffPills(weapon: self)
        }
    }
    var fullSummary: String {
        var summaryComponents = [String]()
        summaryComponents.append(self.name)
        if self.damage > 0 {
            summaryComponents.append(String(self.damage) + " " + Strings("stat.damage").local)
        }
        if self.healthRestoration > 0 {
            summaryComponents.append(String(self.healthRestoration) + " " + Strings("stat.healthRestoration").local)
        }
        if self.armorPointsRestoration > 0 {
            summaryComponents.append(String(self.armorPointsRestoration) + " " + Strings("stat.armorPointsRestoration").local)
        }
        if let effectsDescription = self.getEffectsDescription() {
            summaryComponents.append(effectsDescription)
        }
        return summaryComponents.joined(separator: "\n")
    }
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", basePill: WeaponBasePill, durabilityPill: WeaponDurabilityPill, effectPills: [WeaponEffectPill] = [], buffPills: [WeaponBuffPill] = []) {
        self.basePill = basePill
        self.durabilityPill = durabilityPill
        self.effectPills = effectPills
        self.buffPills = buffPills
        
        super.init(name: name, description: description)
        
        self.basePill.setup(weapon: self)
        self.durabilityPill.setupDurability(weapon: self)
        
        WeaponPillBox.setDurabilityPills(weapon: self)
        WeaponPillBox.setEffectPills(weapon: self)
        WeaponPillBox.setBuffPills(weapon: self)
    }
    
    required init(_ original: Weapon) {
        self.basePill = original.basePill.clone()
        self.durabilityPill = original.durabilityPill.clone()
        self.effectPills = original.effectPills.map { $0.clone() }
        self.buffPills = original.buffPills.map { $0.clone() }
        
        super.init(name: original.name, description: original.description)
        
        // These are still required to setup subscribers and such
        self.basePill.setup(weapon: self)
        self.durabilityPill.setupDurability(weapon: self)
        
        WeaponPillBox.setDurabilityPills(weapon: self)
        WeaponPillBox.setEffectPills(weapon: self)
        WeaponPillBox.setBuffPills(weapon: self)
        
        // The item's state needs to be restored, e.g. damage enhancements must be accounted for
        self.setName(to: original.name)
        self.setDescription(to: original.description)
        self.setDamage(to: original.damage)
        self.setRestoration(to: original.restoration)
        self.setHealthRestoration(to: original.healthRestoration)
        self.setArmorPointsRestoration(to: original.armorPointsRestoration)
        self.setInfiniteRemainingUses(to: original.infiniteRemainingUses)
        self.setRemainingUses(to: original.remainingUses)
    }
    
    // MARK: - Serialisation
    
    private enum Field: String {
        case basePill
        case durabilityPill
        case effectPills
        case buffPills
        // These aren't properties but need to be restored
        case name
        case description
        case damage
        case restoration
        case healthRestoration
        case armorPointsRestoration
        case infiniteRemainingUses
        case remainingUses
    }
    
    required init(dataObject: DataObject) {
        self.basePill = dataObject.getObject(Field.basePill.rawValue, type: WeaponBasePillAbstract.self) as! any WeaponBasePill
        self.durabilityPill = dataObject.getObject(Field.durabilityPill.rawValue, type: WeaponDurabilityPillAbstract.self) as! any WeaponDurabilityPill
        self.effectPills = dataObject.getObjectArray(Field.effectPills.rawValue, type: WeaponEffectPillAbstract.self) as! [any WeaponEffectPill]
        self.buffPills = dataObject.getObjectArray(Field.buffPills.rawValue, type: WeaponBuffPillAbstract.self) as! [any WeaponBuffPill]
        
        super.init(dataObject: dataObject)
        
        // These are still required to setup subscribers and such
        self.basePill.setup(weapon: self)
        self.durabilityPill.setupDurability(weapon: self)
        
        WeaponPillBox.setDurabilityPills(weapon: self)
        WeaponPillBox.setEffectPills(weapon: self)
        WeaponPillBox.setBuffPills(weapon: self)
        
        // The item's state needs to be restored, e.g. damage enhancements must be accounted for
        self.setName(to: dataObject.get(Field.name.rawValue))
        self.setDescription(to: dataObject.get(Field.description.rawValue))
        self.setDamage(to: dataObject.get(Field.damage.rawValue))
        self.setRestoration(to: dataObject.get(Field.restoration.rawValue))
        self.setHealthRestoration(to: dataObject.get(Field.healthRestoration.rawValue))
        self.setArmorPointsRestoration(to: dataObject.get(Field.armorPointsRestoration.rawValue))
        self.setInfiniteRemainingUses(to: dataObject.get(Field.infiniteRemainingUses.rawValue, onFail: false))
        self.setRemainingUses(to: dataObject.get(Field.remainingUses.rawValue))
    }
    
    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.basePill.rawValue, value: self.basePill as WeaponBasePillAbstract)
            .add(key: Field.durabilityPill.rawValue, value: self.durabilityPill as WeaponDurabilityPillAbstract)
            .add(key: Field.effectPills.rawValue, value: self.effectPills as [WeaponEffectPillAbstract])
            .add(key: Field.buffPills.rawValue, value: self.buffPills as [WeaponBuffPillAbstract])
            .add(key: Field.name.rawValue, value: self.name)
            .add(key: Field.description.rawValue, value: self.description)
            .add(key: Field.damage.rawValue, value: self.damage)
            .add(key: Field.restoration.rawValue, value: self.restoration)
            .add(key: Field.healthRestoration.rawValue, value: self.healthRestoration)
            .add(key: Field.armorPointsRestoration.rawValue, value: self.armorPointsRestoration)
            .add(key: Field.infiniteRemainingUses.rawValue, value: self.infiniteRemainingUses)
            .add(key: Field.remainingUses.rawValue, value: self.remainingUses)
    }
    
    // MARK: - Functions
    
    override func getIndicativeDamage(owner: ActorAbstract, opposition: ActorAbstract) -> Int {
        var damageApplied = self.damage
        for pill in self.buffPills {
            damageApplied = pill.applyDamage(weapon: self, owner: owner, opposition: opposition)
        }
        return damageApplied
    }
    
    override func getIndicativeRestoration(owner: ActorAbstract, opposition: ActorAbstract) -> Int {
        var restorationApplied = self.restoration
        for pill in self.buffPills {
            restorationApplied = pill.applyRestoration(weapon: self, owner: owner, opposition: opposition)
        }
        return restorationApplied
    }
    
    override func getIndicativeHealthRestoration(owner: ActorAbstract, opposition: ActorAbstract) -> Int {
        var healthApplied = self.healthRestoration
        for pill in self.buffPills {
            healthApplied = pill.applyHealthRestoration(weapon: self, owner: owner, opposition: opposition)
        }
        return healthApplied
    }
    
    override func getIndicativeArmorPointsRestoration(owner: ActorAbstract, opposition: ActorAbstract) -> Int {
        var armorPointsApplied = self.armorPointsRestoration
        for pill in self.buffPills {
            armorPointsApplied = pill.applyArmorPointsRestoration(weapon: self, owner: owner, opposition: opposition)
        }
        return armorPointsApplied
    }
    
    func getEffectsDescription() -> String? {
        var components = [String]()
        if let basePillEffectsDescription = self.basePill.effectsDescription {
            components.append(basePillEffectsDescription)
        }
        components.append(self.durabilityPill.effectsDescription)
        for effectPill in self.effectPills {
            components.append(effectPill.effectsDescription)
        }
        for buffPill in self.buffPills {
            components.append(buffPill.effectsDescription)
        }
        return components.joined(separator: "\n")
    }
    
    func getPreviewEffectsDescription() -> String? {
        var descriptions = [String]()
        for effectPill in self.effectPills {
            descriptions.append(effectPill.effectsDescription)
        }
        for buffPill in self.buffPills {
            descriptions.append(buffPill.effectsDescription)
        }
        return descriptions.isEmpty ? nil : descriptions.joined(separator: "\n")
    }
    
    func addEffect(_ effect: WeaponEffectPill) {
        self.effectPills.append(effect)
    }
    
    func addBuff(_ buff: WeaponBuffPill) {
        self.buffPills.append(buff)
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract) {
        // We only want buffs to apply to weapons that already have the relevant property
        // E.g a health staff that heals, a +10 damage weapon buff shouldn't suddenly cause the healing staff to deal damage
        if self.healthRestoration > 0 {
            owner.delayedRestorationValues.addRestorationAdjusted(type: .health, sourceOwner: owner, using: self, for: self.getIndicativeHealthRestoration(owner: owner, opposition: opposition))
        }
        if self.damage > 0 {
            opposition.delayedDamageValues.addDamageAdjusted(sourceOwner: owner, using: self, target: opposition, for: self.getIndicativeDamage(owner: owner, opposition: opposition))
        }
        if self.armorPointsRestoration > 0 {
            owner.delayedRestorationValues.addRestorationAdjusted(type: .armorPoints, sourceOwner: owner, using: self, for: self.getIndicativeArmorPointsRestoration(owner: owner, opposition: opposition))
        }
        if self.restoration > 0 {
            owner.delayedRestorationValues.addRestorationAdjusted(type: .overflow, sourceOwner: owner, using: self, for: self.getIndicativeRestoration(owner: owner, opposition: opposition))
        }
        
        for pill in self.effectPills {
            pill.apply(owner: owner, opposition: opposition)
        }
        // Durability pill comes after, otherwise stuff like dulling pill wouldn't work as intended
        self.durabilityPill.use(on: self)
    }
    
    func getPurchaseInfo() -> PurchasableItemInfo {
        return PurchasableItemInfo(name: self.name, description: self.description, type: .weapon)
    }
    
    func beReceived(by receiver: Player, amount: Int) {
        for _ in 0..<amount {
            receiver.addWeapon(self)
        }
    }
    
    func getBasePurchasePrice() -> Int {
        return self.remainingUses*(
            self.basePill.calculateBasePurchasePrice() +
            self.durabilityPill.calculateBasePurchasePrice() +
            self.effectPills.map { $0.calculateBasePurchasePrice() }.reduce(0, +) +
            self.buffPills.map { $0.calculateBasePurchasePrice() }.reduce(0, +)
        )
    }
    
    func getEnhanceInfo() -> EnhanceInfo {
        return EnhanceInfo(id: self.id, name: self.name)
    }
    
    func hasBasePill(_ pill: WeaponBasePill) -> Bool {
        return self.basePill.id == pill.id
    }
    
    func hasDurabilityPill(_ pill: WeaponDurabilityPill) -> Bool {
        return self.durabilityPill.id == pill.id
    }
    
    func hasEffectPill(_ pill: WeaponEffectPill) -> Bool {
        return self.effectPills.contains(where: { $0.id == pill.id })
    }
    
    func hasBuffPill(_ pill: WeaponBuffPill) -> Bool {
        return self.effectPills.contains(where: { $0.id == pill.id })
    }
    
    override func remainingUsesDidSet() {
        if self.remainingUses == 0 {
            OnNoWeaponDurabilityPublisher.publish(weapon: self)
        }
    }
    
}
