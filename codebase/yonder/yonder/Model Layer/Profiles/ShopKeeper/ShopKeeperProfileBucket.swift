//
//  ShopKeeperProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 10/11/2022.
//

import Foundation

class ShopKeeperProfileBucket: Storable {
    
    private var profiles = [ShopKeeperProfile]()
    
    init() {
        self.profiles = ProfileRepository.profiles
    }
    
    func grabProfile(areaTag: RegionProfileTag) -> ShopKeeperProfile {
        let randomProfile = RandomProfile(prefix: "Shop Keeper")
        return ShopKeeperProfile(
            id: 0,
            shopKeeperName: randomProfile.name,
            shopKeeperDescription: randomProfile.description,
            regionTags: []
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
    
    func restoreProfile(_ profile: ShopKeeperProfile) {
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
    
    public static var profiles: [ShopKeeperProfile] {
        return [
            // TODO: Populate
        ]
    }
    
}
