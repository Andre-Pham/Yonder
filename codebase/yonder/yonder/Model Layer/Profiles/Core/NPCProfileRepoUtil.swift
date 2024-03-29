//
//  NPCProfileRepoUtil.swift
//  yonder
//
//  Created by Andre Pham on 8/7/2023.
//

import Foundation
import SwiftyJSON

class NPCProfileRepoUtil {
    
    private static let INDEX_FILENAME = "NPC-DATA-INDEX"
    
    /// Dataclass for foe metadata.
    /// Doesn't represent all available data - refer to /documentation/Metadata Formats.md
    struct FoeMetadata {
        let id: String
        let name: String
        let description: String
        let type: String
        let brute: Bool
        let thief: Bool
        let acute: Bool
        let obtuse: Bool
    }
    
    /// Dataclass for boss metadata.
    /// Doesn't represent all available data - refer to /documentation/Metadata Formats.md
    struct BossMetadata {
        let id: String
        let name: String
        let description: String
        let type: String
    }
    
    /// Dataclass for interactor metadata.
    /// Doesn't represent all available data - refer to /documentation/Metadata Formats.md
    struct InteractorMetadata {
        let id: String
        let name: String
        let description: String
        let type: String
        let roles: [String]
        let shopTags: [String]
        let restorerTags: [String]
        let friendlyTags: [String]
        let enhancerTags: [String]
    }
    
    func getFoeMetadata(contentID: String) -> FoeMetadata? {
        let foeMetadataJSON = self.getFoeMetadataJSON(contentID: contentID)
        guard let name = foeMetadataJSON["name"].string,
              let description = foeMetadataJSON["description"].string,
              let type = foeMetadataJSON["type"].string,
              let brute = foeMetadataJSON["brute"].bool,
              let thief = foeMetadataJSON["thief"].bool,
              let acute = foeMetadataJSON["acute"].bool,
              let obtuse = foeMetadataJSON["obtuse"].bool,
              let checkID = foeMetadataJSON["id"].string else {
            assertionFailure("Data from foe \(contentID) could not be read")
            return nil
        }
        assert(contentID == checkID, "IDs should match between filename and file json for foe \(contentID)")
        return FoeMetadata(
            id: contentID,
            name: name,
            description: description,
            type: type,
            brute: brute,
            thief: thief,
            acute: acute,
            obtuse: obtuse
        )
    }
    
    func getBossMetadata(contentID: String) -> BossMetadata? {
        let bossMetadataJSON = self.getBossMetadataJSON(contentID: contentID)
        guard let name = bossMetadataJSON["name"].string,
              let description = bossMetadataJSON["description"].string,
              let type = bossMetadataJSON["type"].string,
              let checkID = bossMetadataJSON["id"].string else {
            assertionFailure("Data from foe \(contentID) could not be read")
            return nil
        }
        assert(contentID == checkID, "IDs should match between filename and file json for boss \(contentID)")
        return BossMetadata(id: contentID, name: name, description: description, type: type)
    }
    
    func getInteractorMetadata(contentID: String) -> InteractorMetadata? {
        let interactorMetadataJSON = self.getInteractorMetadataJSON(contentID: contentID)
        guard let name = interactorMetadataJSON["name"].string,
              let description = interactorMetadataJSON["description"].string,
              let type = interactorMetadataJSON["type"].string,
              let roles: [String] = interactorMetadataJSON["roles"].arrayObject as? [String],
              let checkID = interactorMetadataJSON["id"].string else {
            assertionFailure("Data from interactor \(contentID) could not be read")
            return nil
        }
        assert(contentID == checkID, "IDs should match between filename and file json for interactor \(contentID)")
        let shopTags: [String]? = interactorMetadataJSON["shopTags"].arrayObject as? [String]
        assert(shopTags != nil, "Shop tags couldn't be retrieved")
        let restorerTags: [String]? = interactorMetadataJSON["restorerTags"].arrayObject as? [String]
        assert(restorerTags != nil, "Restorer tags couldn't be retrieved")
        let friendlyTags: [String]? = interactorMetadataJSON["friendlyTags"].arrayObject as? [String]
        assert(friendlyTags != nil, "Friendly tags couldn't be retrieved")
        let enhancerTags: [String]? = interactorMetadataJSON["enhancerTags"].arrayObject as? [String]
        assert(enhancerTags != nil, "Enhancer tags couldn't be retrieved")
        return InteractorMetadata(
            id: contentID,
            name: name,
            description: description,
            type: type,
            roles: roles,
            shopTags: shopTags ?? [],
            restorerTags: restorerTags ?? [],
            friendlyTags: friendlyTags ?? [],
            enhancerTags: enhancerTags ?? []
        )
    }
    
    private func getFoeMetadataJSON(contentID: String) -> JSON {
        guard let foeMetadataURL = Bundle.main.url(forResource: contentID, withExtension: "json"),
              let foeMetadataData = try? Data(contentsOf: foeMetadataURL) else {
            assertionFailure("Metadata file for foe \(contentID) could not be loaded")
            return JSON()
        }
        guard let foeMetadataJSON = try? JSON(data: foeMetadataData) else {
            assertionFailure("JSON could not be retrieved from foe \(contentID) metadata file")
            return JSON()
        }
        return foeMetadataJSON
    }
    
    private func getBossMetadataJSON(contentID: String) -> JSON {
        guard let bossMetadataURL = Bundle.main.url(forResource: contentID, withExtension: "json"),
              let bossMetadataData = try? Data(contentsOf: bossMetadataURL) else {
            assertionFailure("Metadata file for boss \(contentID) could not be loaded")
            return JSON()
        }
        guard let bossMetadataJSON = try? JSON(data: bossMetadataData) else {
            assertionFailure("JSON could not be retrieved from boss \(contentID) metadata file")
            return JSON()
        }
        return bossMetadataJSON
    }
    
    private func getInteractorMetadataJSON(contentID: String) -> JSON {
        guard let interactorMetadataURL = Bundle.main.url(forResource: contentID, withExtension: "json"),
              let interactorMetadataData = try? Data(contentsOf: interactorMetadataURL) else {
            assertionFailure("Metadata file for interactor \(contentID) could not be loaded")
            return JSON()
        }
        guard let interactorMetadataJSON = try? JSON(data: interactorMetadataData) else {
            assertionFailure("JSON could not be retrieved from foe \(contentID) metadata file")
            return JSON()
        }
        return interactorMetadataJSON
    }
    
    func getFoeContentIDs() -> [String] {
        let indexJSON = self.getIndexJSON()
        guard let foeIDs: [String] = indexJSON["foe_ids"].arrayObject as? [String] else {
            fatalError("Foe IDs couldn't be read from index file")
        }
        return foeIDs
    }
    
    func getBossContentIDs() -> [String] {
        let indexJSON = self.getIndexJSON()
        guard let bossIDs: [String] = indexJSON["boss_ids"].arrayObject as? [String] else {
            fatalError("Boss IDs couldn't be read from index file")
        }
        return bossIDs
    }
    
    func getInteractorContentIDs() -> [String] {
        let indexJSON = self.getIndexJSON()
        guard let interactorIDs: [String] = indexJSON["interactor_ids"].arrayObject as? [String] else {
            fatalError("Interactor IDs couldn't be read from index file")
        }
        return interactorIDs
    }
    
    private func getIndexJSON() -> JSON {
        guard let indexURL = Bundle.main.url(forResource: Self.INDEX_FILENAME, withExtension: "json"),
              let indexData = try? Data(contentsOf: indexURL) else {
            fatalError("NPC index file could not be loaded")
        }
        guard let indexJSON = try? JSON(data: indexData) else {
            fatalError("JSON could not be retrieved from NPC index file")
        }
        return indexJSON
    }
    
}
