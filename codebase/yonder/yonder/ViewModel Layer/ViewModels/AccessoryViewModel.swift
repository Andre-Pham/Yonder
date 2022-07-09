//
//  AccessoryViewModel.swift
//  yonder
//
//  Created by Andre Pham on 9/7/2022.
//

import Foundation
import Combine

class AccessoryViewModel: ObservableObject {
    
    // armor can be used within the ViewModel layer, but Views should only interact with ViewModels (not the Model layer)
    private(set) var accessory: Accessory
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var healthBonus: Int
    @Published private(set) var armorPointsBonus: Int
    public let name: String
    public let description: String
    public let id: UUID
    @Published private(set) var effectsDescription: String?
    @Published private(set) var buffViewModels: [BuffViewModel] {
        didSet {
            // Changes to any BuffViewModel will be published to the UI
            for buff in self.buffViewModels {
                buff.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() }).store(in: &self.subscriptions)
            }
        }
    }
    var accessoryTypeDescription: String {
        switch self.accessory.type {
        case .peripheral:
            return Strings.Accessory.AccessoryType.Peripheral.Name.local
        case .regular:
            return Strings.Accessory.AccessoryType.Regular.Name.local
        }
    }
    var noStats: Bool {
        return !(self.healthBonus > 0 || self.armorPointsBonus > 0)
    }
    
    init(_ accessory: Accessory) {
        self.accessory = accessory
        
        self.healthBonus = accessory.healthBonus
        self.armorPointsBonus = accessory.armorPointsBonus
        self.name = accessory.name
        self.description = accessory.description
        self.id = accessory.id
        self.effectsDescription = accessory.getEffectsDescription()
        self.buffViewModels = self.accessory.buffs.map { BuffViewModel($0) }
        
        self.accessory.$healthBonus.sink(receiveValue: { newValue in
            self.healthBonus = newValue
        }).store(in: &self.subscriptions)
        
        self.accessory.$armorPointsBonus.sink(receiveValue: { newValue in
            self.armorPointsBonus = newValue
        }).store(in: &self.subscriptions)
        
        self.accessory.$buffs.sink(receiveValue: { newValue in
            self.buffViewModels = newValue.map { BuffViewModel($0) }
            self.effectsDescription = self.accessory.getEffectsDescription()
        }).store(in: &self.subscriptions)
    }
    
}
