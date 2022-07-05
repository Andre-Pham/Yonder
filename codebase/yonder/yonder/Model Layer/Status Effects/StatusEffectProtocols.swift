//
//  StatusEffectProtocols.swift
//  yonder
//
//  Created by Andre Pham on 5/7/2022.
//

import Foundation

protocol AppliesEffect {
    
    func applyEffect(actor: ActorAbstract)
    
}

protocol PossibleIndicativeValue {
    
    func getIndicativeValue(target: ActorAbstract) -> Int?
    
}
