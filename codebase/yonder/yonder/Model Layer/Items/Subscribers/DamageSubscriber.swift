//
//  DamageSubscriber.swift
//  yonder
//
//  Created by Andre Pham on 13/7/2022.
//

import Foundation

protocol DamageSubscriber {
    
    func onDamageChange(_ item: ItemAbstract, old: Int)
    
}
