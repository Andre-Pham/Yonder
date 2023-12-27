//
//  ShopKeeperProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 10/11/2022.
//

import Foundation

class ShopKeeperProfileBucket: Storable, InteractorProfileBucket {
    
    private var profiles = [ShopKeeperProfile]()
    
    init() {
        self.profiles = ProfileRepository.profiles
        self.profiles.shuffle()
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
    
    // MARK: - Functions
    
    func grabProfile(areaTag: RegionProfileTag) -> ShopKeeperProfile {
        // Search for profiles with the matching area
        for (index, profile) in self.profiles.enumerated() {
            if profile.regionTags.contains(areaTag) {
                return self.profiles.remove(at: index)
            }
        }
        // Search for any other profile
        for (index, profile) in self.profiles.enumerated() {
            if profile.regionTags.contains(.all) {
                return self.profiles.remove(at: index)
            }
        }
        fatalError("Not enough shop keepers - if we reach this point it's not even worth trying to recover")
    }
    
    func markProfileIDUsed(id: String) {
        if let index = self.profiles.firstIndex(where: { $0.id == id }) {
            self.profiles.remove(at: index)
        }
    }
    
}

fileprivate class ProfileRepository {
    
    public static var profiles: [ShopKeeperProfile] {
        let util = NPCProfileRepoUtil()
        let interactorIDs = util.getInteractorContentIDs()
        var result = [ShopKeeperProfile]()
        for id in interactorIDs {
            guard let interactorMetadata = util.getInteractorMetadata(contentID: id) else {
                assertionFailure("Couldn't retrieve interactor \(id) metadata")
                continue
            }
            guard interactorMetadata.roles.contains("shop") else {
                // We're only interested in shop keepers
                continue
            }
            guard let regionTag = RegionProfileTag(rawValue: interactorMetadata.type) else {
                assertionFailure("Interactor metadata has type \(interactorMetadata.type) with no corresponding RegionProfileTag")
                continue
            }
            result.append(ShopKeeperProfile(
                id: id,
                shopKeeperName: interactorMetadata.name,
                shopKeeperDescription: interactorMetadata.description,
                regionTags: [regionTag]
            ))
        }
        return result
    }
    
}
