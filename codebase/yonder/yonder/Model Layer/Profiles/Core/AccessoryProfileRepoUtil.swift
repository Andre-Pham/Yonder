//
//  AccessoryProfileRepoUtil.swift
//  yonder
//
//  Created by Andre Pham on 1/1/2024.
//

import Foundation
import SwiftyJSON

class AccessoryProfileRepoUtil {
    
    private static let INDEX_FILENAME = "ACCESSORY-DATA-INDEX"
    
    /// Dataclass for accessory metadata.
    /// Doesn't represent all available data - refer to /documentation/Metadata Formats.md
    struct AccessoryMetadata {
        let id: String
        let accessoryName: String
        let accessoryType: String
        let regionProfileTag: String
        let accessoryProfileTag: String
    }
    
    func getAllAccessoryProfiles() -> [AccessoryProfile] {
        let everyAccessoryMetadata = self.getEveryAccessoryMetadata()
        var accessoryProfiles = [AccessoryProfile]()
        for accessoryMetadata in everyAccessoryMetadata {
            var regionTags = [RegionProfileTag]()
            var accessoryTag: AccessoryProfileTag? = nil
            var accessoryType: AccessoryType? = nil
            if accessoryMetadata.regionProfileTag == "all" {
                regionTags.append(.all)
            } else if accessoryMetadata.regionProfileTag == "desert" {
                regionTags.append(.desert)
            } else if accessoryMetadata.regionProfileTag == "cavern" {
                regionTags.append(.cavern)
            } else if accessoryMetadata.regionProfileTag == "faction5" {
                regionTags.append(.faction5)
            } else if accessoryMetadata.regionProfileTag == "faction6" {
                regionTags.append(.faction6)
            } else if accessoryMetadata.regionProfileTag == "dungeon" {
                regionTags.append(.dungeon)
            } else if accessoryMetadata.regionProfileTag == "faction2" {
                regionTags.append(.faction2)
            } else if accessoryMetadata.regionProfileTag == "faction4" {
                regionTags.append(.faction4)
            } else if accessoryMetadata.regionProfileTag == "nether" {
                regionTags.append(.nether)
            } else if accessoryMetadata.regionProfileTag == "shadow" {
                regionTags.append(.shadow)
            } else if accessoryMetadata.regionProfileTag == "mech" {
                regionTags.append(.mech)
            } else if accessoryMetadata.regionProfileTag == "forest" {
                regionTags.append(.forest)
            } else if accessoryMetadata.regionProfileTag == "none" {
                regionTags.append(.none)
            } else if accessoryMetadata.regionProfileTag == "frost" {
                regionTags.append(.frost)
            } else {
                assertionFailure("A accessory's metadata's regionProfileTag doesn't match any in-game regionProfileTag")
            }
            if accessoryMetadata.accessoryProfileTag == "defensive" {
                accessoryTag = .defensive
            } else if accessoryMetadata.accessoryProfileTag == "offensive" {
                accessoryTag = .offensive
            } else if accessoryMetadata.accessoryProfileTag == "gold" {
                accessoryTag = .gold
            } else if accessoryMetadata.accessoryProfileTag == "health" {
                accessoryTag = .health
            } else if accessoryMetadata.accessoryProfileTag == "everything" {
                accessoryTag = .everything
            } else if accessoryMetadata.accessoryProfileTag == "special" {
                accessoryTag = .special
            } else {
                assertionFailure("A accessory's metadata's accessoryProfileTag doesn't match any in-game accessoryProfileTag")
            }
            if accessoryMetadata.accessoryType == "regular" {
                accessoryType = .regular
            } else if accessoryMetadata.accessoryType == "peripheral" {
                accessoryType = .peripheral
            } else {
                assertionFailure("A accessory's metadata's accessoryProfileTag doesn't match any in-game accessoryProfileTag")
            }
            guard let accessoryType, let accessoryTag else {
                continue
            }
            let accessoryProfile = AccessoryProfile(
                id: accessoryMetadata.id,
                accessoryName: accessoryMetadata.accessoryName,
                regionTags: regionTags,
                accessoryTag: accessoryTag,
                accessoryType: accessoryType
            )
            accessoryProfiles.append(accessoryProfile)
        }
        return accessoryProfiles
    }
    
    private func getEveryAccessoryMetadata() -> [AccessoryMetadata] {
        guard let indexURL = Bundle.main.url(forResource: Self.INDEX_FILENAME, withExtension: "json"),
              let indexData = try? Data(contentsOf: indexURL) else {
            assertionFailure("Accessory index file could not be loaded")
            return []
        }
        guard let indexJSON = try? JSON(data: indexData) else {
            assertionFailure("JSON could not be retrieved from accessory index file")
            return []
        }
        guard let accessorysFileNames = indexJSON["accessory_metadata_files"].arrayObject as? [String] else {
            assertionFailure("Accessory file name field could not be found in accessory index file")
            return []
        }
        var everyAccessoryMetadata = [AccessoryMetadata]()
        for accessorysFileName in accessorysFileNames {
            guard let accessorysMetadataURL = Bundle.main.url(forResource: accessorysFileName, withExtension: "json"),
                  let accessorysMetadataData = try? Data(contentsOf: accessorysMetadataURL) else {
                assertionFailure("Accessory metadata file \(accessorysFileName).json could not be loaded")
                continue
            }
            guard let accessorysMetadataJSON = try? JSON(data: accessorysMetadataData) else {
                assertionFailure("JSON could not be retrieved from accessory metadata file \(accessorysFileName).json")
                continue
            }
            guard let accessorysMetadataJSONArray = accessorysMetadataJSON.array else {
                assertionFailure("JSON file for accessory metadata file \(accessorysFileName).json isn't an array")
                continue
            }
            for accessoryJSON in accessorysMetadataJSONArray {
                guard let id = accessoryJSON["id"].string,
                      let name = accessoryJSON["accessoryName"].string,
                      let accessoryType = accessoryJSON["accessoryType"].string,
                      let regionProfileTag = accessoryJSON["regionProfileTag"].string,
                      let accessoryProfileTag = accessoryJSON["accessoryProfileTag"].string else {
                    assertionFailure("Data from accessory from accessory metadata file \(accessorysFileName).json could not be read")
                    continue
                }
                let accessoryMetadata = AccessoryMetadata(id: id, accessoryName: name, accessoryType: accessoryType, regionProfileTag: regionProfileTag, accessoryProfileTag: accessoryProfileTag)
                everyAccessoryMetadata.append(accessoryMetadata)
            }
        }
        return everyAccessoryMetadata
    }
    
}
