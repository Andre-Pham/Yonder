//
//  ArmorProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 9/11/2022.
//

import Foundation

class ArmorProfileBucket: Storable {
    
    private var profiles = [ArmorProfile]()
    
    init() {
        self.profiles = ProfileRepository.profiles
    }
    
    func grabProfile(areaTag: RegionProfileTag, armorTag: ArmorProfileTag, armorType: ArmorType) -> ArmorProfile {
        let randomProfile = RandomProfile(prefix: "Armor")
        return ArmorProfile(
            id: 0,
            armorName: randomProfile.name,
            armorDescription: randomProfile.description,
            regionTags: [],
            armorTag: .heavyweight,
            armorType: .body
        )
        
        var matchingIndices = [Int]()
        for (index, profile) in self.profiles.enumerated() {
            if (profile.matchesAreaTag(areaTag) &&
                profile.armorTag == armorTag &&
                profile.armorType == armorType
            ) {
                matchingIndices.append(index)
            }
        }
        let selectedIndex = Int.random(in: 0..<matchingIndices.count)
        return self.profiles.remove(at: selectedIndex)
    }
    
    func restoreProfile(_ profile: ArmorProfile) {
        self.profiles.append(profile)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case profileIDs
    }

    required init(dataObject: DataObject) {
        let ids: [Int] = dataObject.get(Field.profileIDs.rawValue)
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
    
    public static var profiles: [ArmorProfile] {
        return [
            // TODO: Populate
        ]
    }
    
}
