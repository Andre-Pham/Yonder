//
//  OnNoWeaponDurabilityPublisher.swift
//  yonder
//
//  Created by Andre Pham on 27/8/2022.
//

import Foundation

class OnNoWeaponDurabilityPublisher {
    
    static private var subscribers = [WeakOnNoWeaponDurabilitySubscriber]()
    
    static func subscribe(_ subscriber: OnNoWeaponDurabilitySubscriber) {
        self.subscribers.append(WeakOnNoWeaponDurabilitySubscriber(value: subscriber))
    }
    
    static func publish(weapon: Weapon) {
        for sub in Self.subscribers {
            sub.value?.onNoWeaponDurability(weapon: weapon)
        }
    }
    
}


protocol OnNoWeaponDurabilitySubscriber: AnyObject {
    
    func onNoWeaponDurability(weapon: Weapon)
    
}


private class WeakOnNoWeaponDurabilitySubscriber {
    
    private(set) weak var value: OnNoWeaponDurabilitySubscriber?

    init(value: OnNoWeaponDurabilitySubscriber?) {
        self.value = value
    }
    
}
