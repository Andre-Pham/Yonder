//
//  LootChoiceViewModel.swift
//  yonder
//
//  Created by Andre Pham on 4/1/2024.
//

import Foundation
import Combine
import SwiftUI

class LootChoiceViewModel: LootViewModel {
    
    // lootChoice can be used within the ViewModel layer, but Views should only interact with ViewModels (not the Model layer)
    private(set) var lootChoice: LootChoice
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var isLooted: Bool
    
    init(_ lootChoice: LootChoice) {
        self.lootChoice = lootChoice
        
        self.isLooted = lootChoice.isLooted
        
        super.init(lootChoice)
        
        self.lootChoice.$isLooted.sink(receiveValue: { newValue in
            self.isLooted = newValue
        }).store(in: &self.subscriptions)
    }
    
    func discardLoot() {
        self.lootChoice.markAsLooted()
    }
    
}
