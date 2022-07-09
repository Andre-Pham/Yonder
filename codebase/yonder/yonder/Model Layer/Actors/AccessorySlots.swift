//
//  AccessorySlots.swift
//  yonder
//
//  Created by Andre Pham on 7/7/2022.
//

import Foundation

class AccessorySlots {
    
    public let accessorySlotCount = 4
    @DidSetPublished private(set) var accessories = [Accessory]()
    @DidSetPublished private(set) var peripheralAccessory: Accessory = NoAccessory(type: .peripheral)
    var allAccessories: [Accessory] {
        var accessories = Array(self.accessories)
        accessories.append(self.peripheralAccessory)
        return accessories
    }
    var maxArmorPoints: Int {
        return self.allAccessories.reduce(0) { $0 + $1.armorPointsBonus }
    }
    var accessorySlotsFull: Bool {
        return self.accessories.count >= self.accessorySlotCount
    }
    
    func insert(_ accessory: Accessory, replacing: UUID?) -> Accessory? {
        switch accessory.type {
        case .regular:
            if let replacing = replacing {
                return self.replaceAccessory(id: replacing, newAccessory: accessory)
            } else if !self.accessorySlotsFull {
                self.accessories.append(accessory)
            } else {
                return nil
            }
        case .peripheral:
            let replaced = self.peripheralAccessory
            self.peripheralAccessory = accessory
            return replaced is NoAccessory ? nil : replaced
        }
        return nil
    }
    
    func hasEquipped(_ accessory: Accessory) -> Bool {
        return self.allAccessories.contains(where: { $0.id == accessory.id })
    }
    
    func remove(_ accessory: Accessory) {
        switch accessory.type {
        case .peripheral:
            self.peripheralAccessory = NoAccessory(type: .peripheral)
        case .regular:
            if let position = self.accessories.firstIndex(where: { $0.id == accessory.id }) {
                self.accessories.remove(at: position)
            }
        }
    }
    
    private func replaceAccessory(id: UUID, newAccessory: Accessory) -> Accessory? {
        if let accessoryIndex = self.accessories.firstIndex(where: { $0.id == id }) {
            let replaced = self.accessories[accessoryIndex]
            self.accessories[accessoryIndex] = newAccessory
            return replaced
        }
        return nil
    }
    
}
