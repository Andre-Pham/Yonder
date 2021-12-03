//
//  Item.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class ItemAbstract {
    
    private(set) var damage: Int
    private(set) var healthRestoration: Int
    private(set) var remainingUses: Int
    public let id = UUID()
    
    init(remainingUses: Int = 0, damage: Int = 0, healthRestoration: Int = 0) {
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
