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
    
    func grabProfile(areaTag: AreaProfileTag, accessoryTag: AccessoryProfileTag, accessoryType: AccessoryType) -> AccessoryProfile {
        let randomProfile = RandomProfile(prefix: "Accessory")
        return AccessoryProfile(
            id: 0,
            accessoryName: randomProfile.name,
            accessoryDescription: randomProfile.description,
            areaTags: [],
            accessoryTag: .everything,
            accessoryType: .regular
        )
        
        var matchingIndices = [Int]()
        for (index, profile) in self.profiles.enumerated() {
            if (profile.matchesAreaTag(areaTag) &&
                profile.accessoryTag == accessoryTag &&
                profile.accessoryType == accessoryType
            ) {
                matchingIndices.append(index)
            }
        }
        let selectedIndex = Int.random(in: 0..<matchingIndices.count)
        return self.profiles.remove(at: selectedIndex)
    }
    
    func restoreProfile(_ profile: AccessoryProfile) {
        self.profiles.append(profile)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case profileIDs
    }

    required init(dataObject: DataObject) {
        let ids: [Int] = dataObject.get(Field.profileIDs.rawValue)
        for id in ids {
            if let profile = ProfileRepository.profiles.first(where: { $0.id == id }) {
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
        return [
            // TODO: Populate
            
            // Note to self:
            // accessoryType should play a role in the profile, e.g. a shield would be a peripheral accessory, a ring would be a regular accessory
            // areaTags are the areas that you could find this accessory in, e.g. "snow ring" would be odd to find in the firelands
            // (I need to add an "all" option for area profile tags)
        ]
    }
    
}
