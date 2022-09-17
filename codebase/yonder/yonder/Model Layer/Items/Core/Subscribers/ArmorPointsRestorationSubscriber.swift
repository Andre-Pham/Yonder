//
//  ArmorPointsRestorationSubscriber.swift
//  yonder
//
//  Created by Andre Pham on 14/7/2022.
//

import Foundation

protocol ArmorPointsRestorationSubscriber {
    
    func onArmorPointsRestorationChange(_ item: Item, old: Int)
    
}
