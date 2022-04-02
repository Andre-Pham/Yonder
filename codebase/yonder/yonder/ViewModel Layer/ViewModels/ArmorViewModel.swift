//
//  ArmorViewModel.swift
//  yonder
//
//  Created by Andre Pham on 6/2/2022.
//

import Foundation
import Combine

class ArmorViewModel: ObservableObject {
    
    // armor can be used within the ViewModel layer, but Views should only interact with ViewModels (not the Model layer)
    private(set) var armor: ArmorAbstract
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var armorPoints: Int
    private(set) var id: UUID
    private(set) var type: ArmorType
    private(set) var name: String
    private(set) var description: String
    @Published private(set) var effectsDescription: String?
    
    init(_ armor: ArmorAbstract) {
        self.armor = armor
        
        // Set properties to match Item
        
        self.armorPoints = self.armor.armorPoints
        self.id = self.armor.id
        self.type = self.armor.type
        self.name = self.armor.name
        self.description = self.armor.description
        self.effectsDescription = self.armor.effectsDescription
        
        // Add Subscribers
        
        self.armor.$armorPoints.sink(receiveValue: { newValue in
            self.armorPoints = newValue
        }).store(in: &self.subscriptions)
        
        self.armor.$effectsDescription.sink(receiveValue: { newValue in
            self.effectsDescription = newValue
        }).store(in: &self.subscriptions)
        
    }
    
}
