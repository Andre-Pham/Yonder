//
//  Weapon.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class Weapon: Item, Usable, Purchasable, Clonable, Enhanceable {
    
    private(set) var basePurchasePrice: Int = 0
    private let basePill: WeaponBasePill
    @DidSetPublished private(set) var durabilityPill: WeaponDurabilityPill
    @DidSetPublished private(set) var effectPills: [WeaponEffectPill]
    var fullSummary: String {
        var summaryComponents = [String]()
        summaryComponents.append(self.name)
        if self.damage > 0 {
            summaryComponents.append(String(self.damage) + " " + Strings.Stat.Damage.local)
        }
        if self.healthRestoration > 0 {
            summaryComponents.append(String(self.healthRestoration) + " " + Strings.Stat.HealthRestoration.local)
        }
        if self.armorPointsRestoration > 0 {
            summaryComponents.append(String(self.armorPointsRestoration) + " " + Strings.Stat.ArmorPointsRestoration.local)
        }
        if let effectsDescription = self.getEffectsDescription() {
            summaryComponents.append(effectsDescription)
        }
        return summaryComponents.joined(separator: "\n")
    }
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", basePill: WeaponBasePill, durabilityPill: WeaponDurabilityPill, effectPills: [WeaponEffectPill] = []) {
        self.basePill = basePill
        self.durabilityPill = durabilityPill
        self.effectPills = effectPills
        
        super.init(name: name, description: description)
        
        self.basePill.setup(weapon: self)
        self.durabilityPill.setupDurability(weapon: self)
        self.basePurchasePrice = self.getCurrentPrice() // Needs setup to get current price
    }
    
    required init(_ original: Weapon) {
        self.basePill = original.basePill.clone()
        self.durabilityPill = original.durabilityPill.clone()
        self.effectPills = original.effectPills.map { $0.clone() }
        
        super.init(name: original.name, description: original.description)
        
        // These are still required to setup subscribers and such
        self.basePill.setup(weapon: self)
        self.durabilityPill.setupDurability(weapon: self)
        self.basePurchasePrice = original.basePurchasePrice
        
        // The item's state needs to be restored
        self.setName(to: original.name)
        self.setDescription(to: original.description)
        self.setDamage(to: original.damage)
        self.setRestoration(to: original.restoration)
        self.setHealthRestoration(to: original.healthRestoration)
        self.setArmorPointsRestoration(to: original.armorPointsRestoration)
        self.setInfiniteRemainingUses(to: original.infiniteRemainingUses)
        self.setRemainingUses(to: original.remainingUses)
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
        return components.joined(separator: "\n")
    }
    
    func getEffectPillsDescription() -> String? {
        var descriptions = [String]()
        for effectPill in self.effectPills {
            descriptions.append(effectPill.effectsDescription)
        }
        return descriptions.isEmpty ? nil : descriptions.joined(separator: "\n")
    }
    
    func addEffect(_ effect: WeaponEffectPill) {
        self.effectPills.append(effect)
    }
    
    func getCurrentPrice() -> Int {
        return self.remainingUses*(
            self.basePill.getValue() +
            self.durabilityPill.getValue() +
            self.effectPills.map { $0.getValue() }.reduce(0, +))
    }
    
    func use(owner: ActorAbstract, opposition: ActorAbstract) {
        // We only want buffs to apply to weapons that already have the relevant property
        // E.g a health staff that heals, a +10 damage weapon buff shouldn't suddenly cause the healing staff to deal damage
        if self.healthRestoration > 0 {
            owner.delayedRestorationValues.addRestorationAdjusted(type: .health, sourceOwner: owner, using: self, for: self.healthRestoration)
        }
        if self.damage > 0 {
            opposition.delayedDamageValues.addDamageAdjusted(sourceOwner: owner, using: self, target: opposition, for: self.damage)
        }
        if self.armorPointsRestoration > 0 {
            owner.delayedRestorationValues.addRestorationAdjusted(type: .armorPoints, sourceOwner: owner, using: self, for: self.armorPointsRestoration)
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
    
    override func remainingUsesDidSet() {
        if self.remainingUses == 0 {
            OnNoWeaponDurabilityPublisher.publish(weapon: self)
        }
    }
    
}
