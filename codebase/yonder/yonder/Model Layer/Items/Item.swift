//
//  Item.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class ItemAbstract: Named, EffectsDescribed, Described {
    
    // UI related
    public let name: String
    public let description: String
    @DidSetPublished private(set) var effectsDescription: String?
    
    @DidSetPublished private(set) var damage: Int
    @DidSetPublished private(set) var healthRestoration: Int
    @DidSetPublished private(set) var remainingUses: Int
    public let id = UUID()
    
    init(name: String, description: String, effectsDescription: String?, remainingUses: Int = 0, damage: Int = 0, healthRestoration: Int = 0) {
        self.name = name
        self.description = description
        self.effectsDescription = effectsDescription
        self.remainingUses = remainingUses
        self.damage = damage
        self.healthRestoration = healthRestoration
    }
    
    func resetEffectsDescription(to description: String) {
        self.effectsDescription = description
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
    
    func adjustDamage(by damage: Int) {
        self.damage += damage
    }
    
    func adjustHealthRestoration(by healthRestoration: Int) {
        self.healthRestoration += healthRestoration
    }
    
}
