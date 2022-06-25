//
//  Item.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

typealias ItemAbstract = ItemAbstractPart & EffectsDescribed

class ItemAbstractPart: Named, Described {
    
    public let name: String
    public let description: String
    @DidSetPublished private(set) var damage: Int
    @DidSetPublished private(set) var healthRestoration: Int
    @DidSetPublished private(set) var armorPointsRestoration: Int
    @DidSetPublished private(set) var remainingUses: Int
    /// Indicates if the item has infinite uses or not - not actually used in logic, but as an indicator for rendering the UI
    private(set) var infiniteRemainingUses: Bool
    public let id = UUID()
    
    init(name: String, description: String, remainingUses: Int = 0, damage: Int = 0, healthRestoration: Int = 0, armorPointsRestoration: Int = 0, infiniteRemainingUses: Bool = false) {
        self.name = name
        self.description = description
        self.remainingUses = remainingUses
        self.damage = damage
        self.healthRestoration = healthRestoration
        self.armorPointsRestoration = armorPointsRestoration
        self.infiniteRemainingUses = infiniteRemainingUses
    }
    
    func adjustRemainingUses(by uses: Int) {
        self.remainingUses += uses
    }
    
    func setRemainingUses(to uses: Int) {
        self.remainingUses = uses
    }
    
    func setDamage(to damage: Int) {
        self.damage = damage
    }
    
    func setHealthRestoration(to healthRestoration: Int) {
        self.healthRestoration = healthRestoration
    }
    
    func setArmorPointsRestoration(to armorPointsRestoration: Int) {
        self.armorPointsRestoration = armorPointsRestoration
    }
    
    func setInfiniteRemainingUses(to status: Bool) {
        self.infiniteRemainingUses = status
    }
    
    func adjustDamage(by damage: Int) {
        self.damage += damage
    }
    
    func adjustHealthRestoration(by healthRestoration: Int) {
        self.healthRestoration += healthRestoration
    }
    
    func adjustArmorPointsRestoration(by armorPointsRestoration: Int) {
        self.armorPointsRestoration += armorPointsRestoration
    }
    
}
