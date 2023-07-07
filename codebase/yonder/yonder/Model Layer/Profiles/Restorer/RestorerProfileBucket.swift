//
//  RestorerProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 11/11/2022.
//

import Foundation
import SwiftyJSON

class RestorerProfileBucket: Storable, InteractorProfileBucket {
    
    private var profiles = [RestorerProfile]()
    
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
    
    func grabProfile(areaTag: RegionProfileTag, restoreOptions: [Restorer.RestoreOption]) -> RestorerProfile {
        // Search for profiles within the area that exactly meet the restore options
        for (index, profile) in self.profiles.enumerated() {
            if profile.regionTags.contains(areaTag) && profile.matchesRestoreOptions(restoreOptions) {
                return self.profiles.remove(at: index)
            }
        }
        // Then search for profiles within the area that contain all the restore options
        // E.g. if a profile has armor and health and the request is just health, it's still valid
        for (index, profile) in self.profiles.enumerated() {
            if profile.regionTags.contains(areaTag) && profile.containsRestoreOptions(restoreOptions) {
                return self.profiles.remove(at: index)
            }
        }
        // Then search for any profile that belongs to all regions that exactly meet the restore option
        for (index, profile) in self.profiles.enumerated() {
            if profile.regionTags.contains(.all) && profile.matchesRestoreOptions(restoreOptions) {
                return self.profiles.remove(at: index)
            }
        }
        // Then search for any profile that contain all the restore options
        for (index, profile) in self.profiles.enumerated() {
            if profile.regionTags.contains(.all) && profile.containsRestoreOptions(restoreOptions) {
                return self.profiles.remove(at: index)
            }
        }
        assertionFailure("Not enough restorers if we reach this point")
        // Then search for any profile in general
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
    
    public static var profiles: [RestorerProfile] {
        let util = ProfileRepoUtil()
        let interactorIDs = util.getInteractorContentIDs()
        var result = [RestorerProfile]()
        for id in interactorIDs {
            guard let interactorMetadata = util.getInteractorMetadata(contentID: id) else {
                assertionFailure("Couldn't retrieve interactor \(id) metadata")
                continue
            }
            guard interactorMetadata.roles.contains("restorer") else {
                // We're only interested in restorers
                continue
            }
            guard let regionTag = RegionProfileTag(rawValue: interactorMetadata.type) else {
                assertionFailure("Interactor metadata has type \(interactorMetadata.type) with no corresponding RegionProfileTag")
                continue
            }
            var restoreOptions = [Restorer.RestoreOption]()
            for tag in interactorMetadata.restorerTags {
                if tag == "armor" {
                    restoreOptions.append(.armorPoints)
                } else if tag == "health" {
                    restoreOptions.append(.health)
                } else {
                    assertionFailure("Restorer tag '\(tag)' could not be converted into a restore option")
                }
            }
            result.append(RestorerProfile(
                id: id,
                restorerName: interactorMetadata.name,
                restorerDescription: interactorMetadata.description,
                regionTags: [regionTag],
                restoreOptions: restoreOptions
            ))
        }
        return result
    }
    
}
