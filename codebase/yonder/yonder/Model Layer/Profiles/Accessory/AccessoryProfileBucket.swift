//
//  AccessoryProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 9/11/2022.
//

import Foundation

class AccessoryProfileBucket: Storable {
    
    private var profiles = [AccessoryProfile]()
    
    init() {
        self.profiles = ProfileRepository.profiles
    }
    
    func grabProfile(areaTag: RegionProfileTag, accessoryTag: AccessoryProfileTag, accessoryType: AccessoryType) -> AccessoryProfile {
        var matchingIndices = [Int]()
        for (index, profile) in self.profiles.enumerated() {
            if (profile.matchesAreaTag(areaTag) &&
                profile.accessoryTag == accessoryTag &&
                profile.accessoryType == accessoryType
            ) {
                matchingIndices.append(index)
            }
        }
        guard let selectedIndex = matchingIndices.randomElement() else {
            assertionFailure("Ran out of accessory profiles with the desired area tag and weapon tag")
            guard !self.profiles.isEmpty else {
                // If there are no accessory profiles something is seriously (seriously) wrong - bail
                fatalError("Ran out of accessory profiles")
            }
            return self.profiles.randomElement()!
        }
        return self.profiles.remove(at: selectedIndex)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case profileIDs
    }

    required init(dataObject: DataObject) {
        let ids: [String] = dataObject.get(Field.profileIDs.rawValue)
        let allProfiles = ProfileRepository.profiles
        for id in ids {
            if let profile = allProfiles.first(where: { $0.id == id }) {
                self.profiles.append(profile)
            }
        }
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.profileIDs.rawValue, value: self.profiles.map({ $0.id }))
    }
    
}

fileprivate class ProfileRepository {
    
    public static var profiles: [AccessoryProfile] {
        let util = AccessoryProfileRepoUtil()
        let result = util.getAllAccessoryProfiles()
        return result
    }
    
}
