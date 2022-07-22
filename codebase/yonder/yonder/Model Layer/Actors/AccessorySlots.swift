//
//  AccessorySlots.swift
//  yonder
//
//  Created by Andre Pham on 7/7/2022.
//

import Foundation

class AccessorySlots {
    
    public let accessorySlotCount = 4
    private var cachedInsertLocation: Int? = nil
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
                if let cachedInsertLocation = self.cachedInsertLocation {
                    self.accessories.insert(accessory, at: cachedInsertLocation)
                    self.cachedInsertLocation = nil
                } else {
                    self.accessories.append(accessory)
                }
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
    
    func hasEffect(_ equipmentPill: EquipmentPillAbstract) -> Bool {
        for accessory in self.allAccessories {
            if accessory.effectPills.contains(where: { $0.id == equipmentPill.id }) {
                return true
            }
        }
        return false
    }
    
    /// Remove a specified accessory. Optionally cache its location for the next equipped accessory to be inserted into.
    /// Typically removing an accessory precedes adding one in its place, hence the option to cache its location is given.
    /// (The accessory being removed can't always be replaced directly using `insert`, for example, in cases such as purchasing accessories.)
    /// - Parameters:
    ///   - accessory: The accessory to be removed
    ///   - cacheLocation: Whether or not to cache its location for the next equipped accessory to be inserted into
    func remove(_ accessory: Accessory, cacheLocation: Bool = false) {
        switch accessory.type {
        case .peripheral:
            self.peripheralAccessory = NoAccessory(type: .peripheral)
        case .regular:
            if let position = self.accessories.firstIndex(where: { $0.id == accessory.id }) {
                if cacheLocation {
                    self.cachedInsertLocation = position
                }
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
