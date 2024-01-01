//
//  ArmorProfileRepoUtil.swift
//  yonder
//
//  Created by Andre Pham on 1/1/2024.
//

import Foundation
import SwiftyJSON

class ArmorProfileRepoUtil {
    
    private static let INDEX_FILENAME = "ARMOR-DATA-INDEX"
    
    /// Dataclass for armor metadata.
    /// Doesn't represent all available data - refer to /documentation/Metadata Formats.md
    struct ArmorMetadata {
        let id: String
        let armorName: String
        let armorType: String
        let regionProfileTag: String
        let armorProfileTag: String
    }
    
    func getAllArmorProfiles() -> [ArmorProfile] {
        let everyArmorMetadata = self.getEveryArmorMetadata()
        var armorProfiles = [ArmorProfile]()
        for armorMetadata in everyArmorMetadata {
            var regionTags = [RegionProfileTag]()
            var armorTag: ArmorProfileTag? = nil
            var armorType: ArmorType? = nil
            if armorMetadata.regionProfileTag == "all" {
                regionTags.append(.all)
            } else if armorMetadata.regionProfileTag == "desert" {
                regionTags.append(.desert)
            } else if armorMetadata.regionProfileTag == "cavern" {
                regionTags.append(.cavern)
            } else if armorMetadata.regionProfileTag == "faction5" {
                regionTags.append(.faction5)
            } else if armorMetadata.regionProfileTag == "faction6" {
                regionTags.append(.faction6)
            } else if armorMetadata.regionProfileTag == "dungeon" {
                regionTags.append(.dungeon)
            } else if armorMetadata.regionProfileTag == "faction2" {
                regionTags.append(.faction2)
            } else if armorMetadata.regionProfileTag == "faction4" {
                regionTags.append(.faction4)
            } else if armorMetadata.regionProfileTag == "nether" {
                regionTags.append(.nether)
            } else if armorMetadata.regionProfileTag == "shadow" {
                regionTags.append(.shadow)
            } else if armorMetadata.regionProfileTag == "mech" {
                regionTags.append(.mech)
            } else if armorMetadata.regionProfileTag == "forest" {
                regionTags.append(.forest)
            } else if armorMetadata.regionProfileTag == "none" {
                regionTags.append(.none)
            } else if armorMetadata.regionProfileTag == "frost" {
                regionTags.append(.frost)
            } else {
                assertionFailure("A armor's metadata's regionProfileTag doesn't match any in-game regionProfileTag")
            }
            if armorMetadata.armorProfileTag == "heavyweight" {
                armorTag = .heavyweight
            } else if armorMetadata.armorProfileTag == "lightweight" {
                armorTag = .lightweight
            } else {
                assertionFailure("A armor's metadata's armorProfileTag doesn't match any in-game armorProfileTag")
            }
            if armorMetadata.armorType == "head" {
                armorType = .head
            } else if armorMetadata.armorType == "body" {
                armorType = .body
            } else if armorMetadata.armorType == "legs" {
                armorType = .legs
            } else {
                assertionFailure("A armor's metadata's armorProfileTag doesn't match any in-game armorProfileTag")
            }
            guard let armorType, let armorTag else {
                continue
            }
            let armorProfile = ArmorProfile(
                id: armorMetadata.id,
                armorName: armorMetadata.armorName,
                regionTags: regionTags,
                armorTag: armorTag,
                armorType: armorType
            )
            armorProfiles.append(armorProfile)
        }
        return armorProfiles
    }
    
    private func getEveryArmorMetadata() -> [ArmorMetadata] {
        guard let indexURL = Bundle.main.url(forResource: Self.INDEX_FILENAME, withExtension: "json"),
              let indexData = try? Data(contentsOf: indexURL) else {
            assertionFailure("Armor index file could not be loaded")
            return []
        }
        guard let indexJSON = try? JSON(data: indexData) else {
            assertionFailure("JSON could not be retrieved from armor index file")
            return []
        }
        guard let armorsFileNames = indexJSON["armor_metadata_files"].arrayObject as? [String] else {
            assertionFailure("Armor file name field could not be found in armor index file")
            return []
        }
        var everyArmorMetadata = [ArmorMetadata]()
        for armorsFileName in armorsFileNames {
            guard let armorsMetadataURL = Bundle.main.url(forResource: armorsFileName, withExtension: "json"),
                  let armorsMetadataData = try? Data(contentsOf: armorsMetadataURL) else {
                assertionFailure("Armor metadata file \(armorsFileName).json could not be loaded")
                continue
            }
            guard let armorsMetadataJSON = try? JSON(data: armorsMetadataData) else {
                assertionFailure("JSON could not be retrieved from armor metadata file \(armorsFileName).json")
                continue
            }
            guard let armorsMetadataJSONArray = armorsMetadataJSON.array else {
                assertionFailure("JSON file for armor metadata file \(armorsFileName).json isn't an array")
                continue
            }
            for armorJSON in armorsMetadataJSONArray {
                guard let id = armorJSON["id"].string,
                      let name = armorJSON["armorName"].string,
                      let armorType = armorJSON["armorType"].string,
                      let regionProfileTag = armorJSON["regionProfileTag"].string,
                      let armorProfileTag = armorJSON["armorProfileTag"].string else {
                    assertionFailure("Data from armor from armor metadata file \(armorsFileName).json could not be read")
                    continue
                }
                let armorMetadata = ArmorMetadata(id: id, armorName: name, armorType: armorType, regionProfileTag: regionProfileTag, armorProfileTag: armorProfileTag)
                everyArmorMetadata.append(armorMetadata)
            }
        }
        return everyArmorMetadata
    }
    
}
