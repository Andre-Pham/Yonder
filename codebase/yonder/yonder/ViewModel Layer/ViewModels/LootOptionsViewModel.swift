//
//  LootOptionsViewModel.swift
//  yonder
//
//  Created by Andre Pham on 17/7/2022.
//

import Foundation
import Combine
import SwiftUI

class LootOptionsViewModel: ObservableObject {
    
    // lootOptions can be used within the ViewModel layer, but Views should only interact with ViewModels (not the Model layer)
    private(set) var lootOptions: LootOptions
    private var subscriptions: Set<AnyCancellable> = []
    
    // Loot bags don't need updating - they won't change
    public let lootBagViewModels: [LootBagViewModel]
    @Published private(set) var isLooted: Bool
    
    init(_ lootOptions: LootOptions) {
        self.lootOptions = lootOptions
        
        self.lootBagViewModels = lootOptions.lootBags.map { LootBagViewModel($0) }
        self.isLooted = lootOptions.isLooted
        
        self.lootOptions.$isLooted.sink(receiveValue: { newValue in
            self.isLooted = newValue
        }).store(in: &self.subscriptions)
    }
    
    func take(_ lootBag: LootBagViewModel, playerViewModel: PlayerViewModel) {
        self.lootOptions.take(lootBag.id, player: playerViewModel.player)
    }
    
}
