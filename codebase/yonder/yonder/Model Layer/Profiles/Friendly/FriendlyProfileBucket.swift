//
//  FriendlyProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation

class FriendlyProfileBucket: Storable, InteractorProfileBucket {
    
    private var profiles = [FriendlyProfile]()
    
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
    
    func grabProfile(areaTag: RegionProfileTag, friendlyTag: FriendlyProfileTag) -> FriendlyProfile {
        // Search for profiles within the area that contains the friendly profile tag
        for (index, profile) in self.profiles.enumerated() {
            if profile.regionTags.contains(areaTag) && profile.friendlyTags.contains(friendlyTag) {
                return self.profiles.remove(at: index)
            }
        }
        // Then search for any profile that contains the friendly profile tag
        for (index, profile) in self.profiles.enumerated() {
            if profile.regionTags.contains(.all) && profile.friendlyTags.contains(friendlyTag) {
                return self.profiles.remove(at: index)
            }
        }
        assertionFailure("Not enough friendlies if we reach this point")
        // Then search for any profile within the area
        for (index, profile) in self.profiles.enumerated() {
            if profile.regionTags.contains(areaTag) {
                return self.profiles.remove(at: index)
            }
        }
        // Then search for any profile
        for (index, profile) in self.profiles.enumerated() {
            if profile.regionTags.contains(.all) {
                return self.profiles.remove(at: index)
            }
        }
        fatalError("If we reach this point it's not even worth trying to recover")
    }
    
    func markProfileIDUsed(id: String) {
        if let index = self.profiles.firstIndex(where: { $0.id == id }) {
            self.profiles.remove(at: index)
        }
    }
    
}

fileprivate class ProfileRepository {
    
    public static var profiles: [FriendlyProfile] {
        let util = ProfileRepoUtil()
        let interactorIDs = util.getInteractorContentIDs()
        var result = [FriendlyProfile]()
        for id in interactorIDs {
            guard let interactorMetadata = util.getInteractorMetadata(contentID: id) else {
                assertionFailure("Couldn't retrieve interactor \(id) metadata")
                continue
            }
            guard interactorMetadata.roles.contains("friendly") else {
                // We're only interested in friendlies
                continue
            }
            guard let regionTag = RegionProfileTag(rawValue: interactorMetadata.type) else {
                assertionFailure("Interactor metadata has type \(interactorMetadata.type) with no corresponding RegionProfileTag")
                continue
            }
            var friendlyProfileTags = [FriendlyProfileTag]()
            for tag in interactorMetadata.friendlyTags {
                if let friendlyProfileTag = FriendlyProfileTag(rawValue: tag) {
                    friendlyProfileTags.append(friendlyProfileTag)
                } else {
                    assertionFailure("Friendly tag '\(tag)' could not be converted into a FriendlyProfileTag")
                }
            }
            result.append(FriendlyProfile(
                id: interactorMetadata.id,
                friendlyName: interactorMetadata.name,
                friendlyDescription: interactorMetadata.description,
                regionTags: [regionTag],
                friendlyTags: friendlyProfileTags
            ))
        }
        return result
    }
    
}
