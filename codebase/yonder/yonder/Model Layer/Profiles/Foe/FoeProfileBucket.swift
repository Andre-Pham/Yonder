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
    
    public static var profiles: [FoeProfile] {
        let util = NPCProfileRepoUtil()
        let foeIDs = util.getFoeContentIDs()
        var result = [FoeProfile]()
        for id in foeIDs {
            guard let foeMetadata = util.getFoeMetadata(contentID: id) else {
                assertionFailure("Couldn't retrieve foe \(id) metadata")
                continue
            }
            guard let regionTag = RegionProfileTag(rawValue: foeMetadata.type) else {
                assertionFailure("Foe metadata has type \(foeMetadata.type) with no corresponding RegionProfileTag")
                continue
            }
            var foeTags = [FoeProfileTag]()
            assert(!(foeMetadata.acute && foeMetadata.obtuse), "A foe cannot be both acute and obtuse at once (see foe \(id))")
            assert(!(foeMetadata.brute && foeMetadata.thief), "A foe cannot be both a brute and a thief at once (see foe \(id))")
            if foeMetadata.brute {
                foeTags.append(.brute)
            }
            if foeMetadata.thief {
                foeTags.append(.goblin)
            }
            if foeMetadata.acute {
                foeTags.append(.acute)
            }
            if foeMetadata.obtuse {
                foeTags.append(.obtuse)
            }
            if foeTags.isEmpty {
                foeTags.append(.none)
            }
            result.append(FoeProfile(
                id: foeMetadata.id,
                foeName: foeMetadata.name,
                foeDescription: foeMetadata.description,
                foeTags: foeTags,
                regionTags: [regionTag]
            ))
        }
        return result
    }
    
}
