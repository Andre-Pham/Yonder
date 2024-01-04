//
//  LootBagViewModel.swift
//  yonder
//
//  Created by Andre Pham on 17/7/2022.
//

import Foundation
import Combine
import SwiftUI

class LootBagViewModel: LootViewModel {
    
    // lootBag can be used within the ViewModel layer, but Views should only interact with ViewModels (not the Model layer)
    private(set) var lootBag: LootBag
    private var subscriptions: Set<AnyCancellable> = []
    
    public let name: String
    public let description: String
    
    init(_ lootBag: LootBag) {
        self.lootBag = lootBag
        
        self.name = lootBag.name
        self.description = lootBag.description
        
        super.init(lootBag)
    }
    
}
