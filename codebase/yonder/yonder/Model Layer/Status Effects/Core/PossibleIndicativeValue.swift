//
//  PossibleIndicativeValue.swift
//  yonder
//
//  Created by Andre Pham on 17/9/2022.
//

import Foundation

protocol PossibleIndicativeValue {
    
    func getIndicativeValue(target: ActorAbstract) -> Int?
    
}
