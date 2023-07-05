//
//  FoeProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation
import SwiftyJSON

class FoeProfileBucket: Storable {
    
    private var profiles = [FoeProfile]()
    
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
    
    func grabProfile(areaTag: RegionProfileTag, foeTag: FoeProfileTag) -> FoeProfile {
        switch foeTag {
        case .brute:
            // Find all profiles that are either brute or brute + obtuse
            // (If we look for just brutes, and below look for just obtuse, starvation will occur for profiles that are both)
            for (index, profile) in self.profiles.enumerated() {
                if profile.matchesAreaTag(areaTag) && profile.foeTags.contains(foeTag) {
                    return self.profiles.remove(at: index)
                }
            }
            // If no matches, find all profiles that are obtuse
            for (index, profile) in self.profiles.enumerated() {
                if profile.matchesAreaTag(areaTag) && profile.foeTags.contains(.obtuse) {
                    return self.profiles.remove(at: index)
                }
            }
            break
        case .goblin:
            // Find all profiles that are either thief or thief + acute
            for (index, profile) in self.profiles.enumerated() {
                if profile.matchesAreaTag(areaTag) && profile.foeTags.contains(foeTag) {
                    return self.profiles.remove(at: index)
                }
            }
            // If no matches, find all profiles that are acute
            for (index, profile) in self.profiles.enumerated() {
                if profile.matchesAreaTag(areaTag) && profile.foeTags.contains(.acute) {
                    return self.profiles.remove(at: index)
                }
            }
            break
        case .acute, .obtuse:
            let counterpart: FoeProfileTag = foeTag == .acute ? .goblin : .brute
            // Find all profiles that are just acute/obtuse
            for (index, profile) in self.profiles.enumerated() {
                if profile.matchesAreaTag(areaTag) && profile.foeTags.contains(foeTag) && !profile.foeTags.contains(counterpart) {
                    return self.profiles.remove(at: index)
                }
            }
            // If no matches, find all profiles that are acute/obtuse + thief/brute (both)
            let pairedFilter: FoeProfileTag = foeTag == .acute ? .goblin : .brute
            for (index, profile) in self.profiles.enumerated() {
                if profile.matchesAreaTag(areaTag) && profile.foeTags.contains(foeTag) && profile.foeTags.contains(pairedFilter) {
                    return self.profiles.remove(at: index)
                }
            }
            break
        case .none:
            // Gets caught at the end by returning any .none profile
            break
        }
        // If still no matches (or .none), find all profiles that are regular
        for (index, profile) in self.profiles.enumerated() {
            if profile.matchesAreaTag(areaTag) && profile.foeTags.contains(.none) {
                return self.profiles.remove(at: index)
            }
        }
        // If still no matches, find any profile within the region
        assertionFailure("There really aren't enough enemies (profiles) for this region")
        for (index, profile) in self.profiles.enumerated() {
            if profile.matchesAreaTag(areaTag) {
                return self.profiles.remove(at: index)
            }
        }
        fatalError("If we reach this point it's not even worth trying to recover")
    }
    
}

fileprivate class ProfileRepository {
    
    private static let INDEX_FILENAME = "NPC-DATA-INDEX"
    
    public static var profiles: [FoeProfile] {
        guard let indexURL = Bundle.main.url(forResource: Self.INDEX_FILENAME, withExtension: "json"),
              let indexData = try? Data(contentsOf: indexURL) else {
            fatalError("Index file could not be loaded")
        }
        guard let indexJSON = try? JSON(data: indexData) else {
            fatalError("JSON could not be retrieved from index file")
        }
        guard let foeIDs: [String] = indexJSON["foe_ids"].arrayObject as? [String] else {
            fatalError("Foe IDs couldn't be read from index file")
        }
        var result = [FoeProfile]()
        for id in foeIDs {
            guard let foeMetadataURL = Bundle.main.url(forResource: id, withExtension: "json"),
                  let foeMetadataData = try? Data(contentsOf: foeMetadataURL) else {
                assertionFailure("Metadata file for foe \(id) could not be loaded")
                continue
            }
            guard let foeMetadataJSON = try? JSON(data: foeMetadataData) else {
                assertionFailure("JSON could not be retrieved from foe \(id) metadata file")
                continue
            }
            guard let name = foeMetadataJSON["name"].string,
                  let description = foeMetadataJSON["description"].string,
                  let type = foeMetadataJSON["type"].string,
                  let brute = foeMetadataJSON["brute"].bool,
                  let thief = foeMetadataJSON["thief"].bool,
                  let acute = foeMetadataJSON["acute"].bool,
                  let obtuse = foeMetadataJSON["obtuse"].bool,
                  let checkID = foeMetadataJSON["id"].string else {
                assertionFailure("Data from foe \(id) could not be read")
                continue
            }
            assert(id == checkID, "IDs should match between filename and file json for foe \(id)")
            guard let regionTag = RegionProfileTag(rawValue: type) else {
                assertionFailure("Foe metadata has type \(type) with no corresponding RegionProfileTag")
                continue
            }
            var foeTags = [FoeProfileTag]()
            assert(!(acute && obtuse), "A foe cannot be both acute and obtuse at once (see foe \(id))")
            assert(!(brute && thief), "A foe cannot be both a brute and a thief at once (see foe \(id))")
            if brute {
                foeTags.append(.brute)
            }
            if thief {
                foeTags.append(.goblin)
            }
            if acute {
                foeTags.append(.acute)
            }
            if obtuse {
                foeTags.append(.obtuse)
            }
            if foeTags.isEmpty {
                foeTags.append(.none)
            }
            result.append(FoeProfile(
                id: id,
                foeName: name,
                foeDescription: description,
                foeTags: foeTags,
                regionTags: [regionTag]
            ))
        }
        return result
    }
    
}
