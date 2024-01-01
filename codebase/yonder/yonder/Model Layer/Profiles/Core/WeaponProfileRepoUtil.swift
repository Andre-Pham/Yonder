//
//  WeaponProfileRepoUtil.swift
//  yonder
//
//  Created by Andre Pham on 27/12/2023.
//

import Foundation
import SwiftyJSON

class WeaponProfileRepoUtil {
    
    private static let INDEX_FILENAME = "WEAPON-DATA-INDEX"
    
    /// Dataclass for weapon metadata.
    /// Doesn't represent all available data - refer to /documentation/Metadata Formats.md
    struct WeaponMetadata {
        let id: String
        let weaponName: String
        let regionProfileTag: String
        let weaponProfileTag: String
    }
    
    func getAllWeaponProfiles() -> [WeaponProfile] {
        let everyWeaponMetadata = self.getEveryWeaponMetadata()
        var weaponProfiles = [WeaponProfile]()
        for weaponMetadata in everyWeaponMetadata {
            var regionTags = [RegionProfileTag]()
            var weaponTags = [WeaponProfileTag]()
            if weaponMetadata.regionProfileTag == "all" {
                regionTags.append(.all)
            } else if weaponMetadata.regionProfileTag == "desert" {
                regionTags.append(.desert)
            } else if weaponMetadata.regionProfileTag == "cavern" {
                regionTags.append(.cavern)
            } else if weaponMetadata.regionProfileTag == "faction5" {
                regionTags.append(.faction5)
            } else if weaponMetadata.regionProfileTag == "faction6" {
                regionTags.append(.faction6)
            } else if weaponMetadata.regionProfileTag == "dungeon" {
                regionTags.append(.dungeon)
            } else if weaponMetadata.regionProfileTag == "faction2" {
                regionTags.append(.faction2)
            } else if weaponMetadata.regionProfileTag == "faction4" {
                regionTags.append(.faction4)
            } else if weaponMetadata.regionProfileTag == "nether" {
                regionTags.append(.nether)
            } else if weaponMetadata.regionProfileTag == "shadow" {
                regionTags.append(.shadow)
            } else if weaponMetadata.regionProfileTag == "mech" {
                regionTags.append(.mech)
            } else if weaponMetadata.regionProfileTag == "forest" {
                regionTags.append(.forest)
            } else if weaponMetadata.regionProfileTag == "none" {
                regionTags.append(.none)
            } else if weaponMetadata.regionProfileTag == "frost" {
                regionTags.append(.frost)
            } else {
                assertionFailure("A weapon's metadata's regionProfileTag doesn't match any in-game regionProfileTag")
            }
            if weaponMetadata.weaponProfileTag == "damage" {
                weaponTags.append(.damage)
            } else if weaponMetadata.weaponProfileTag == "damageAndRestoration" {
                weaponTags.append(.damageAndRestoration)
            } else if weaponMetadata.weaponProfileTag == "restoration" {
                weaponTags.append(.restoration)
            } else if weaponMetadata.weaponProfileTag == "healthRestoration" {
                weaponTags.append(.healthRestoration)
            } else if weaponMetadata.weaponProfileTag == "armorPointsRestoration" {
                weaponTags.append(.armorPointsRestoration)
            } else if weaponMetadata.weaponProfileTag == "collateral" {
                weaponTags.append(.collateral)
            } else if weaponMetadata.weaponProfileTag == "consumesFoe" {
                weaponTags.append(.consumesFoe)
            } else {
                assertionFailure("A weapon's metadata's weaponProfileTag doesn't match any in-game weaponProfileTag")
            }
            let weaponProfile = WeaponProfile(
                id: weaponMetadata.id,
                weaponName: weaponMetadata.weaponName,
                regionTags: regionTags,
                weaponTags: weaponTags
            )
            weaponProfiles.append(weaponProfile)
        }
        return weaponProfiles
    }
    
    private func getEveryWeaponMetadata() -> [WeaponMetadata] {
        guard let indexURL = Bundle.main.url(forResource: Self.INDEX_FILENAME, withExtension: "json"),
              let indexData = try? Data(contentsOf: indexURL) else {
            assertionFailure("Weapon index file could not be loaded")
            return []
        }
        guard let indexJSON = try? JSON(data: indexData) else {
            assertionFailure("JSON could not be retrieved from weapon index file")
            return []
        }
        guard let weaponsFileNames = indexJSON["weapon_metadata_files"].arrayObject as? [String] else {
            assertionFailure("Weapon file name field could not be found in weapon index file")
            return []
        }
        var everyWeaponMetadata = [WeaponMetadata]()
        for weaponsFileName in weaponsFileNames {
            guard let weaponsMetadataURL = Bundle.main.url(forResource: weaponsFileName, withExtension: "json"),
                  let weaponsMetadataData = try? Data(contentsOf: weaponsMetadataURL) else {
                assertionFailure("Weapon metadata file \(weaponsFileName).json could not be loaded")
                continue
            }
            guard let weaponsMetadataJSON = try? JSON(data: weaponsMetadataData) else {
                assertionFailure("JSON could not be retrieved from weapon metadata file \(weaponsFileName).json")
                continue
            }
            guard let weaponsMetadataJSONArray = weaponsMetadataJSON.array else {
                assertionFailure("JSON file for weapon metadata file \(weaponsFileName).json isn't an array")
                continue
            }
            for weaponJSON in weaponsMetadataJSONArray {
                guard let id = weaponJSON["id"].string,
                      let name = weaponJSON["weaponName"].string,
                      let regionProfileTag = weaponJSON["regionProfileTag"].string,
                      let weaponProfileTag = weaponJSON["weaponProfileTag"].string else {
                    assertionFailure("Data from weapon from weapon metadata file \(weaponsFileName).json could not be read")
                    continue
                }
                let weaponMetadata = WeaponMetadata(id: id, weaponName: name, regionProfileTag: regionProfileTag, weaponProfileTag: weaponProfileTag)
                everyWeaponMetadata.append(weaponMetadata)
            }
        }
        return everyWeaponMetadata
    }
    
}
