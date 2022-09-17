//
//  RestorationSubscriber.swift
//  yonder
//
//  Created by Andre Pham on 16/9/2022.
//

import Foundation

protocol RestorationSubscriber {
    
    func onRestorationChange(_ item: Item, old: Int)
    
}
