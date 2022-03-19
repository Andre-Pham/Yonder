//
//  Potion.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

typealias PotionAbstract = PotionAbstractPart & Usable & Purchasable

class PotionAbstractPart: ItemAbstract {
    
    func isStackable(with potion: PotionAbstract) -> Bool {
        return self.damage == potion.damage && self.healthRestoration == potion.healthRestoration && self.name == potion.name && self.description == potion.description
    }
    
}
