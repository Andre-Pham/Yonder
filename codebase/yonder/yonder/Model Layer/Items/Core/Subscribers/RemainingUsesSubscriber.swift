//
//  RemainingUsesSubscriber.swift
//  yonder
//
//  Created by Andre Pham on 14/7/2022.
//

import Foundation

protocol RemainingUsesSubscriber {
    
    func onRemainingUsesChange(_ item: Item, old: Int)
    
}
