//
//  ItemViewModel.swift
//  yonder
//
//  Created by Andre Pham on 3/2/2022.
//

import Foundation
import SwiftUI
import Combine

class ItemViewModel: ObservableObject {
    
    // item can be used within the ViewModel layer, but Views should only interact with ViewModels (not the Model layer)
    private(set) var item: Item
    var subscriptions: Set<AnyCancellable> = [] // Public so children can access
    
    @Published private(set) var damage: Int
    @Published private(set) var restoration: Int
    @Published private(set) var healthRestoration: Int
    @Published private(set) var armorPointsRestoration: Int
    @Published private(set) var remainingUses: Int
    private(set) var id: UUID
    @Published private(set) var name: String
    @Published private(set) var description: String
    private(set) var remainingUsesDescription: String
    private(set) var inspectTag: String
    private(set) var damageImage: Image
    private(set) var restorationImage: Image
    private(set) var healthRestorationImage: Image
    private(set) var armorPointsRestorationImage: Image
    private(set) var remainingUsesImage: Image
    private(set) var infiniteRemainingUses: Bool
    @Published private(set) var effectsDescription: String? = nil
    public let requiresFoeForUsage: Bool
    
    init(
        _ item: Item,
        remainingUsesDescription: String,
        inspectTag: String,
        damageImage: Image,
        restorationImage: Image,
        healthRestorationImage: Image,
        armorPointsRestorationImage: Image,
        remainingUsesImage: Image
    ) {
        self.item = item
        self.remainingUsesDescription = remainingUsesDescription
        self.inspectTag = inspectTag
        self.damageImage = damageImage
        self.restorationImage = restorationImage
        self.healthRestorationImage = healthRestorationImage
        self.armorPointsRestorationImage = armorPointsRestorationImage
        self.remainingUsesImage = remainingUsesImage
        self.requiresFoeForUsage = item.requiresFoeForUsage
        
        // Set properties to match Item
        
        self.damage = self.item.damage
        self.restoration = self.item.restoration
        self.healthRestoration = self.item.healthRestoration
        self.armorPointsRestoration = self.item.armorPointsRestoration
        self.remainingUses = self.item.remainingUses
        self.id = self.item.id
        self.name = self.item.name
        self.description = self.item.description
        self.infiniteRemainingUses = self.item.infiniteRemainingUses
        
        // Add Subscribers
        
        self.item.$damage.sink(receiveValue: { newValue in
            self.damage = newValue
        }).store(in: &self.subscriptions)
        
        self.item.$restoration.sink(receiveValue: { newValue in
            self.restoration = newValue
        }).store(in: &self.subscriptions)
        
        self.item.$healthRestoration.sink(receiveValue: { newValue in
            self.healthRestoration = newValue
        }).store(in: &self.subscriptions)
        
        self.item.$armorPointsRestoration.sink(receiveValue: { newValue in
            self.armorPointsRestoration = newValue
        }).store(in: &self.subscriptions)
        
        self.item.$remainingUses.sink(receiveValue: { newValue in
            self.remainingUses = newValue
        }).store(in: &self.subscriptions)
        
        self.item.$name.sink(receiveValue: { newValue in
            self.name = newValue
        }).store(in: &self.subscriptions)
        
        self.item.$description.sink(receiveValue: { newValue in
            self.description = newValue
        }).store(in: &self.subscriptions)
    }
    
    func setEffectsDescription(to description: String?) {
        self.effectsDescription = description
    }
    
}
