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
        var matchingIndices = [Int]()
        for (index, profile) in self.profiles.enumerated() {
            if (profile.matchesAreaTag(areaTag) &&
                profile.armorTag == armorTag &&
                profile.armorType == armorType
            ) {
                matchingIndices.append(index)
            }
        }
        guard let selectedIndex = matchingIndices.randomElement() else {
            assertionFailure("Ran out of armor profiles with the desired area tag and weapon tag")
            guard !self.profiles.isEmpty else {
                // If there are no armor profiles something is seriously (seriously) wrong - bail
                fatalError("Ran out of armor profiles")
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
    
    public static var profiles: [ArmorProfile] {
        let util = ArmorProfileRepoUtil()
        let result = util.getAllArmorProfiles()
        return result
    }
    
}
