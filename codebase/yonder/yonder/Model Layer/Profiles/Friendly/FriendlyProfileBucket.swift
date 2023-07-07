//
//  FriendlyProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation
import SwiftyJSON

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
    
    private static let INDEX_FILENAME = "NPC-DATA-INDEX"
    
    public static var profiles: [FriendlyProfile] {
        guard let indexURL = Bundle.main.url(forResource: Self.INDEX_FILENAME, withExtension: "json"),
              let indexData = try? Data(contentsOf: indexURL) else {
            fatalError("Index file could not be loaded")
        }
        guard let indexJSON = try? JSON(data: indexData) else {
            fatalError("JSON could not be retrieved from index file")
        }
        guard let interactorIDs: [String] = indexJSON["interactor_ids"].arrayObject as? [String] else {
            fatalError("Interactor IDs couldn't be read from index file")
        }
        var result = [FriendlyProfile]()
        for id in interactorIDs {
            guard let interactorMetadataURL = Bundle.main.url(forResource: id, withExtension: "json"),
                  let interactorMetadataData = try? Data(contentsOf: interactorMetadataURL) else {
                assertionFailure("Metadata file for interactor \(id) could not be loaded")
                continue
            }
            guard let interactorMetadataJSON = try? JSON(data: interactorMetadataData) else {
                assertionFailure("JSON could not be retrieved from foe \(id) metadata file")
                continue
            }
            guard let name = interactorMetadataJSON["name"].string,
                  let description = interactorMetadataJSON["description"].string,
                  let type = interactorMetadataJSON["type"].string,
                  let roles: [String] = interactorMetadataJSON["roles"].arrayObject as? [String],
                  let friendlyTags: [String] = interactorMetadataJSON["friendlyTags"].arrayObject as? [String],
                  let checkID = interactorMetadataJSON["id"].string else {
                assertionFailure("Data from foe \(id) could not be read")
                continue
            }
            assert(id == checkID, "IDs should match between filename and file json for interactor \(id)")
            guard let regionTag = RegionProfileTag(rawValue: type) else {
                assertionFailure("Interactor metadata has type \(type) with no corresponding RegionProfileTag")
                continue
            }
            guard roles.contains("friendly") else {
                // We're only interested in restorers
                continue
            }
            var friendlyProfileTags = [FriendlyProfileTag]()
            for tag in friendlyTags {
                if let friendlyProfileTag = FriendlyProfileTag(rawValue: tag) {
                    friendlyProfileTags.append(friendlyProfileTag)
                } else {
                    assertionFailure("Friendly tag '\(tag)' could not be converted into a FriendlyProfileTag")
                }
            }
            result.append(FriendlyProfile(
                id: id,
                friendlyName: name,
                friendlyDescription: description,
                regionTags: [regionTag],
                friendlyTags: friendlyProfileTags
            ))
        }
        return result
    }
    
}
