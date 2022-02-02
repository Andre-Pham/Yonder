//
//  Item.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class ItemAbstract: Named, Described {
    
    // UI related
    public let name: String
    public let description: String
    
    @DidSetPublished private(set) var damage: Int
    @DidSetPublished private(set) var healthRestoration: Int
    @DidSetPublished private(set) var remainingUses: Int
    public let id = UUID()
    
    init(name: String, description: String, remainingUses: Int = 0, damage: Int = 0, healthRestoration: Int = 0) {
        self.name = name
        self.description = description
        self.remainingUses = remainingUses
        self.damage = damage
        self.healthRestoration = healthRestoration
    }
    
    func adjustRemainingUses(by uses: Int) {
        self.remainingUses += uses
    }
    
    func setRemainingUses(to uses: Int) {
        self.remainingUses = uses
    }
    
    func adjustDamage(by damage: Int) {
        self.damage += damage
    }
    
    func adjustHealthRestoration(by healthRestoration: Int) {
        self.healthRestoration += healthRestoration
    }
    
}
