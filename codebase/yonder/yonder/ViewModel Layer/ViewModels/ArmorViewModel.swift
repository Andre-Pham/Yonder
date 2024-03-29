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
    private(set) var armor: Armor
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var armorPoints: Int
    private(set) var id: UUID
    private(set) var type: ArmorType
    private(set) var name: String
    private(set) var description: String
    private(set) var inspectTag: String
    @Published private(set) var effectsDescription: String?
    @Published private(set) var buffViewModels: [BuffViewModel] {
        didSet {
            // Changes to any BuffViewModel will be published to the UI
            for buff in self.buffViewModels {
                buff.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() }).store(in: &self.subscriptions)
            }
        }
    }
    @Published private(set) var equipmentEffectViewModels: [EquipmentEffectViewModel]
    
    init(_ armor: Armor) {
        self.armor = armor
        
        // Set properties to match Item
        
        self.armorPoints = self.armor.armorPoints
        self.id = self.armor.id
        self.type = self.armor.type
        self.name = self.armor.name
        self.description = self.armor.description
        switch self.type {
        case .head:
            self.inspectTag = Strings("inspect.tag.armor.head").local
        case .body:
            self.inspectTag = Strings("inspect.tag.armor.body").local
        case .legs:
            self.inspectTag = Strings("inspect.tag.armor.legs").local
        }
        self.effectsDescription = self.armor.getEffectsDescription()
        self.buffViewModels = self.armor.armorBuffs.map { BuffViewModel($0) }
        self.equipmentEffectViewModels = self.armor.equipmentPills.map { EquipmentEffectViewModel($0) }
        
        // Add Subscribers
        
        self.armor.$armorPoints.sink(receiveValue: { newValue in
            self.armorPoints = newValue
        }).store(in: &self.subscriptions)
        
        self.armor.$armorBuffs.sink(receiveValue: { newValue in
            self.effectsDescription = self.armor.getEffectsDescription()
            self.buffViewModels = newValue.map { BuffViewModel($0) }
        }).store(in: &self.subscriptions)
        
        self.armor.$equipmentPills.sink(receiveValue: { newValue in
            self.effectsDescription = self.armor.getEffectsDescription()
            self.equipmentEffectViewModels = self.armor.equipmentPills.map { EquipmentEffectViewModel($0) }
        }).store(in: &self.subscriptions)
        
        self.armor.$armorAttributes.sink(receiveValue: { newValue in
            self.effectsDescription = self.armor.getEffectsDescription()
        }).store(in: &self.subscriptions)
    }
    
}
