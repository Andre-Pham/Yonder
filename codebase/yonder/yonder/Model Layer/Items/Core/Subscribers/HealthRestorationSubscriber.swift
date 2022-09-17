//
//  HealthRestorationSubscriber.swift
//  yonder
//
//  Created by Andre Pham on 14/7/2022.
//

import Foundation

protocol HealthRestorationSubscriber {
    
    func onHealthRestorationChange(_ item: ItemAbstract, old: Int)
    
}
