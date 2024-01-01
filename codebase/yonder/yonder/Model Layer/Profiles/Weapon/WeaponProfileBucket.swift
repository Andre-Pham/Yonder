//
//  WeaponProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

class WeaponProfileBucket: Storable {
    
    private var profiles = [WeaponProfile]()
    
    init() {
        self.profiles = ProfileRepository.profiles
    }
    
    func grabProfile(areaTag: RegionProfileTag, weaponTag: WeaponProfileTag) -> WeaponProfile {
        var matchingIndices = [Int]()
        for (index, profile) in self.profiles.enumerated() {
            if (profile.matchesAreaTag(areaTag) && profile.weaponTags.contains(where: { $0 == weaponTag })) {
                matchingIndices.append(index)
            }
        }
        guard let selectedIndex = matchingIndices.randomElement() else {
            assertionFailure("Ran out of weapon profiles with the desired area tag and weapon tag")
            guard !self.profiles.isEmpty else {
                // If there are no weapon profiles something is seriously (seriously) wrong - bail
                fatalError("Ran out of weapon profiles")
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
    
    public static var profiles: [WeaponProfile] {
        let util = WeaponProfileRepoUtil()
        let result = util.getAllWeaponProfiles()
        return result
    }
    
}
