//
//  FoeProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation

class FoeProfileBucket: Storable {
    
    private var profiles = [FoeProfile]()
    
    init() {
        self.profiles = ProfileRepository.profiles
    }
    
    func grabProfile(areaTag: AreaProfileTag, foeTag: FoeProfileTag) -> FoeProfile {
        let randomProfile = RandomProfile(prefix: "Foe")
        return FoeProfile(
            id: 0,
            foeName: randomProfile.name,
            foeDescription: randomProfile.description,
            foeTags: [],
            areaTags: []
        )
        
        var matchingIndices = [Int]()
        for (index, profile) in self.profiles.enumerated() {
            if profile.matchesAreaTag(areaTag) && profile.foeTags.contains(where: { $0 == foeTag }) {
                matchingIndices.append(index)
            }
        }
        let selectedIndex = Int.random(in: 0..<matchingIndices.count)
        return self.profiles.remove(at: selectedIndex)
    }
    
    func restoreProfile(_ profile: FoeProfile) {
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
    
    public static var profiles: [FoeProfile] {
        return [
            // TODO: Populate
        ]
    }
    
}
