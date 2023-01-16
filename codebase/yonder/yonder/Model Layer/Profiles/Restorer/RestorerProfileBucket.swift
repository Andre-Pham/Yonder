//
//  RestorerProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 11/11/2022.
//

import Foundation

class RestorerProfileBucket: Storable {
    
    private var profiles = [RestorerProfile]()
    
    init() {
        self.profiles = ProfileRepository.profiles
    }
    
    func grabProfile(areaTag: AreaProfileTag, restoreOptions: [Restorer.RestoreOption]) -> RestorerProfile {
        let randomProfile = RandomProfile(prefix: "Restorer")
        return RestorerProfile(
            id: 0,
            restorerName: randomProfile.name,
            restorerDescription: randomProfile.description,
            areaTags: [],
            restoreOptions: []
        )
        
        var matchingIndices = [Int]()
        let allocation = RestoreOptionsAllocation(options: restoreOptions)
        for (index, profile) in self.profiles.enumerated() {
            if (profile.matchesAreaTag(areaTag) && profile.restoreOptions.optionsCode == allocation.optionsCode) {
                matchingIndices.append(index)
            }
        }
        let selectedIndex = Int.random(in: 0..<matchingIndices.count)
        return self.profiles.remove(at: selectedIndex)
    }
    
    func restoreProfile(_ profile: RestorerProfile) {
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
    
    public static var profiles: [RestorerProfile] {
        return [
            // TODO: Populate
        ]
    }
    
}
