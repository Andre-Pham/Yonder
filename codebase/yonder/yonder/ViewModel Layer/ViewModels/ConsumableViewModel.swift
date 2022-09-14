//
//  ConsumableViewModel.swift
//  yonder
//
//  Created by Andre Pham on 9/9/2022.
//

import Foundation
import Combine

class ConsumableViewModel: ObservableObject {
    
    // consumable can be used within the ViewModel layer, but Views should only interact with ViewModels (not the Model layer)
    private(set) var consumable: ConsumableAbstract
    private var subscriptions: Set<AnyCancellable> = []
    
    public let name: String
    public let description: String
    public let id: UUID
    public let effectsDescription: String?
    @Published private(set) var stack: Int
    
    init(_ consumable: ConsumableAbstract) {
        self.consumable = consumable
        
        self.name = consumable.name
        self.description = consumable.description
        self.id = consumable.id
        self.effectsDescription = consumable.getEffectsDescription()
        self.stack = consumable.stack
        
        self.consumable.$stack.sink(receiveValue: { newValue in
            self.stack = newValue
        }).store(in: &self.subscriptions)
    }
    
}
