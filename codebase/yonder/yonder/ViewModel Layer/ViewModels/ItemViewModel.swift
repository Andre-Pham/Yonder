//
//  ItemViewModel.swift
//  yonder
//
//  Created by Andre Pham on 3/2/2022.
//

import Foundation
import Combine

class ItemViewModel: ObservableObject {
    
    // item can be used within the ViewModel layer, but Views should only interact with ViewModels (not the Model layer)
    private(set) var item: ItemAbstract
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var damage: Int
    @Published private(set) var healthRestoration: Int
    @Published private(set) var remainingUses: Int
    private(set) var id: UUID
    private(set) var name: String
    private(set) var description: String
    @Published private(set) var effectsDescription: String?
    
    init(_ item: ItemAbstract) {
        self.item = item
        
        // Set properties to match Item
        
        self.damage = self.item.damage
        self.healthRestoration = self.item.healthRestoration
        self.remainingUses = self.item.remainingUses
        self.id = self.item.id
        self.name = self.item.name
        self.description = self.item.description
        self.effectsDescription = self.item.effectsDescription
        
        // Add Subscribers
        
        self.item.$damage.sink(receiveValue: { newValue in
            self.damage = newValue
        }).store(in: &self.subscriptions)
        
        self.item.$healthRestoration.sink(receiveValue: { newValue in
            self.healthRestoration = newValue
        }).store(in: &self.subscriptions)
        
        self.item.$remainingUses.sink(receiveValue: { newValue in
            self.remainingUses = newValue
        }).store(in: &self.subscriptions)
        
        self.item.$effectsDescription.sink(receiveValue: { newValue in
            self.effectsDescription = newValue
        }).store(in: &self.subscriptions)
    }
    
}
