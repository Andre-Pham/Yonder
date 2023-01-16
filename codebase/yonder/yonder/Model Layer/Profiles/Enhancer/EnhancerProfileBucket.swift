//
//  EnhancerProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 11/11/2022.
//

import Foundation

class EnhancerProfileBucket: Storable {
    
    private var profiles = [EnhancerProfile]()
    
    init() {
        self.profiles = ProfileRepository.profiles
    }
    
    func grabProfile(areaTag: AreaProfileTag) -> EnhancerProfile {
        let randomProfile = RandomProfile(prefix: "Enhancer")
        return EnhancerProfile(
            id: 0,
            enhancerName: randomProfile.name,
            enhancerDescription: randomProfile.description,
            areaTags: []
        )
        
        var matchingIndices = [Int]()
        for (index, profile) in self.profiles.enumerated() {
            if profile.matchesAreaTag(areaTag) {
                matchingIndices.append(index)
            }
        }
        let selectedIndex = Int.random(in: 0..<matchingIndices.count)
        return self.profiles.remove(at: selectedIndex)
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
    
    public static var profiles: [EnhancerProfile] {
        return [
            // TODO: Populate
        ]
    }
    
}
