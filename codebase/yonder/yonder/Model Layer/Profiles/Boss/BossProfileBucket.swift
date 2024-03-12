//
//  BossProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 12/3/2024.
//

import Foundation

class BossProfileBucket: Storable {
    
    private var profiles = [BossProfile]()
    
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
    
    func grabProfile(areaTag: RegionProfileTag) -> BossProfile {
        for (index, profile) in self.profiles.enumerated() {
            if profile.matchesAreaTag(areaTag) {
                return self.profiles.remove(at: index)
            }
        }
        fatalError("If we reach this point it's not even worth trying to recover - no bosses for this region!")
    }
    
}

fileprivate class ProfileRepository {
    
    public static var profiles: [BossProfile] {
        let util = NPCProfileRepoUtil()
        let bossIDs = util.getBossContentIDs()
        var result = [BossProfile]()
        for id in bossIDs {
            guard let bossMetadata = util.getBossMetadata(contentID: id) else {
                assertionFailure("Couldn't retrieve foe \(id) metadata")
                continue
            }
            guard let regionTag = RegionProfileTag(rawValue: bossMetadata.type) else {
                assertionFailure("Boss metadata has type \(bossMetadata.type) with no corresponding RegionProfileTag")
                continue
            }
            result.append(BossProfile(
                id: bossMetadata.id,
                bossName: bossMetadata.name,
                bossDescription: bossMetadata.description,
                regionTags: [regionTag]
            ))
        }
        return result
    }
    
}
