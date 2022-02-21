//
//  WeaponViewModel.swift
//  yonder
//
//  Created by Andre Pham on 3/2/2022.
//

import Foundation
import Combine

class WeaponViewModel: ItemViewModel {
    
    private(set) var type: WeaponType
    
    init(_ weapon: Weapon) {
        self.type = weapon.type
        
        super.init(weapon)
    }
    
}
