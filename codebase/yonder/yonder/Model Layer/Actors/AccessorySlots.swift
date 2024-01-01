//
//  AccessorySlots.swift
//  yonder
//
//  Created by Andre Pham on 7/7/2022.
//

import Foundation

class AccessorySlots: Storable {
    
    /// The number of accessory slots (the number of accessories that can be equipped)
    /// IMPORTANT: If this needs to be changed in the future, it may be in your interest to also update the drop rate of the accessory types - refer to AccessoryFactory
    public let accessorySlotCount = 4
    /// A cache for the position the next accessory should be saved to (typically removing an accessory precedes adding one in its place)
    private var cachedInsertLocation: Int? = nil
    /// Regular accessories
    @DidSetPublished private(set) var accessories = [Accessory]()
    /// Peripheral accessory
    @DidSetPublished private(set) var peripheralAccessory: Accessory = NoAccessory(type: .peripheral)
    /// Regular accessories and peripheral accessory
    var allAccessories: [Accessory] {
        var accessories = Array(self.accessories)
        if !(self.peripheralAccessory is NoAccessory) {
            accessories.append(self.peripheralAccessory)
        }
        return accessories
    }
    /// Armor points provided by all accessories
    var maxArmorPoints: Int {
        return self.allAccessories.reduce(0) { $0 + $1.armorPointsBonus }
    }
    /// True if the number of regular accessories has reached its limit
    var accessorySlotsFull: Bool {
        return self.accessories.count >= self.accessorySlotCount
    }
    
    init() { }
    
    // MARK: - Serialisation

    private enum Field: String {
        case cachedInsertLocation
        case accessories
        case peripheralAccessory
    }

    required init(dataObject: DataObject) {
        self.cachedInsertLocation = dataObject.get(Field.cachedInsertLocation.rawValue)
        self.accessories = dataObject.getObjectArray(Field.accessories.rawValue, type: Accessory.self)
        self.peripheralAccessory = dataObject.getObject(Field.peripheralAccessory.rawValue, type: Accessory.self)
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.cachedInsertLocation.rawValue, value: self.cachedInsertLocation)
            .add(key: Field.accessories.rawValue, value: self.accessories)
            .add(key: Field.peripheralAccessory.rawValue, value: self.peripheralAccessory)
    }

    // MARK: - Functions
    
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
    
    func hasEffect(_ equipmentPill: EquipmentPill) -> Bool {
        for accessory in self.allAccessories {
            if accessory.hasEffect(equipmentPill) {
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
