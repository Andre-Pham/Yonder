//
//  NPCDataTests.swift
//  GameDataTests
//
//  Created by Andre Pham on 25/3/2024.
//

import XCTest
@testable import yonder

final class NPCDataTests: XCTestCase {

    func testBossData() throws {
        print("============================== BOSS DATA ==========================")
        let util = NPCProfileRepoUtil()
        let bossIDs = util.getBossContentIDs()
        var result = [BossProfile]()
        for id in bossIDs {
            guard let bossMetadata = util.getBossMetadata(contentID: id) else {
                XCTFail("Couldn't retrieve foe \(id) metadata")
                continue
            }
            guard let regionTag = RegionProfileTag(rawValue: bossMetadata.type) else {
                XCTFail("Boss metadata has type \(bossMetadata.type) with no corresponding RegionProfileTag")
                continue
            }
            result.append(BossProfile(
                id: bossMetadata.id,
                bossName: bossMetadata.name,
                bossDescription: bossMetadata.description,
                regionTags: [regionTag]
            ))
        }
        print("-- Successfully read all boss IDs --")
        print("Number of boss IDs: \(bossIDs.count)")
        print("Number of boss profiles generated: \(result.count)/\(bossIDs.count)")
        var regionProfileTags = Set<RegionProfileTag>()
        var duplicates = false
        for profile in result {
            for tag in profile.regionTags {
                if regionProfileTags.contains(tag) {
                    duplicates = true
                }
                regionProfileTags.insert(tag)
            }
        }
        print("Unique regions covered: \(regionProfileTags.count)")
        print("Any bosses with duplicate regions: \(duplicates)")
        print("============================== END BOSS DATA ======================")
    }
    
    func testFoeData() throws {
        print("============================== FOE DATA ===========================")
        let util = NPCProfileRepoUtil()
        let foeIDs = util.getFoeContentIDs()
        var result = [FoeProfile]()
        for id in foeIDs {
            guard let foeMetadata = util.getFoeMetadata(contentID: id) else {
                XCTFail("Couldn't retrieve foe \(id) metadata")
                continue
            }
            guard let regionTag = RegionProfileTag(rawValue: foeMetadata.type) else {
                XCTFail("Foe metadata has type \(foeMetadata.type) with no corresponding RegionProfileTag")
                continue
            }
            var foeTags = [FoeProfileTag]()
            XCTAssert(!(foeMetadata.acute && foeMetadata.obtuse), "A foe cannot be both acute and obtuse at once (see foe \(id))")
            XCTAssert(!(foeMetadata.brute && foeMetadata.thief), "A foe cannot be both a brute and a thief at once (see foe \(id))")
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
        print("-- Successfully read all foe IDs --")
        print("Number of foe IDs: \(foeIDs.count)")
        print("Number of foe profiles generated: \(result.count)/\(foeIDs.count)")
        var regionCounts = [RegionProfileTag: Int]()
        for profile in result {
            for tag in profile.regionTags {
                if regionCounts[tag] == nil {
                    regionCounts[tag] = 0
                }
                regionCounts[tag]! += 1
            }
        }
        print("-- Region Breakdown (All Foes) --")
        let maxLocations = AreaArrangements.allCases.map({ $0.locationCount }).max()!
        var warning = false
        for (region, count) in regionCounts {
            print("> Foe count for \(region.rawValue.uppercased()) : \(count)")
            if count < maxLocations && region != .none && region != .all {
                print("    > WARNING: \(count) < \(maxLocations)")
                warning = true
            }
            XCTAssert(count*2 > maxLocations, "Critical amount of locations for region \(region.rawValue) - not enough foes for this region!!!")
        }
        if warning {
            print("One or more WARNINGs were triggered because there are less than the max location count in an area. This doesn't mean you require more foes, as not all locations in an area are foe locations. For location type proportions, see AreaPoolFactory.swift.")
        }
        
        let foeTypes: [(String, FoeProfileTag)] = [("Regular", .none), ("Acute", .acute), ("Obtuse", .obtuse), ("Brute", .brute), ("Theif", .goblin)]
        for foeType in foeTypes {
            print("-- Region Breakdown (\(foeType.0) Foes) --")
            var typeRegionCounts = [RegionProfileTag: Int]()
            for profile in result {
                for tag in profile.regionTags {
                    if profile.foeTags.contains(foeType.1) {
                        if typeRegionCounts[tag] == nil {
                            typeRegionCounts[tag] = 0
                        }
                        typeRegionCounts[tag]! += 1
                    }
                }
            }
            for (region, count) in typeRegionCounts {
                print("> \(foeType.0) foe count for \(region.rawValue.uppercased()) : \(count)")
            }
        }
        print("============================== END FOE DATA =======================")
    }
    
    func testShopKeeperData() throws {
        print("============================== SHOPKEEPER DATA ====================")
        let util = NPCProfileRepoUtil()
        let interactorIDs = util.getInteractorContentIDs()
        var result = [ShopKeeperProfile]()
        for id in interactorIDs {
            guard let interactorMetadata = util.getInteractorMetadata(contentID: id) else {
                XCTFail("Couldn't retrieve interactor \(id) metadata")
                continue
            }
            guard interactorMetadata.roles.contains("shop") else {
                // We're only interested in shop keepers
                continue
            }
            guard let regionTag = RegionProfileTag(rawValue: interactorMetadata.type) else {
                XCTFail("Interactor metadata has type \(interactorMetadata.type) with no corresponding RegionProfileTag")
                continue
            }
            result.append(ShopKeeperProfile(
                id: id,
                shopKeeperName: interactorMetadata.name,
                shopKeeperDescription: interactorMetadata.description,
                regionTags: [regionTag]
            ))
        }
        print("-- Successfully read all shopkeeper IDs --")
        print("Number of interactors IDs: \(interactorIDs.count)")
        print("Number of shopkeeper profiles generated: \(result.count) (\(((Double(result.count)/Double(interactorIDs.count))*100.0).toRoundedInt())% of all interactors)")
        var regionCounts = [RegionProfileTag: Int]()
        for profile in result {
            for tag in profile.regionTags {
                if regionCounts[tag] == nil {
                    regionCounts[tag] = 0
                }
                regionCounts[tag]! += 1
            }
        }
        print("-- Region Breakdown --")
        for (region, count) in regionCounts {
            print("> Shopkeeper count for \(region.rawValue.uppercased()) : \(count)")
        }
        print("============================== END SHOPKEEPER DATA ================")
    }
    
    func testEnhancerData() throws {
        print("============================== ENHANCER DATA ======================")
        let util = NPCProfileRepoUtil()
        let interactorIDs = util.getInteractorContentIDs()
        var result = [EnhancerProfile]()
        for id in interactorIDs {
            guard let interactorMetadata = util.getInteractorMetadata(contentID: id) else {
                XCTFail("Couldn't retrieve interactor \(id) metadata")
                continue
            }
            guard interactorMetadata.roles.contains("enhancer") else {
                // We're only interested in shop keepers
                continue
            }
            guard let regionTag = RegionProfileTag(rawValue: interactorMetadata.type) else {
                XCTFail("Interactor metadata has type \(interactorMetadata.type) with no corresponding RegionProfileTag")
                continue
            }
            result.append(EnhancerProfile(
                id: id,
                enhancerName: interactorMetadata.name,
                enhancerDescription: interactorMetadata.description,
                regionTags: [regionTag]
            ))
        }
        print("-- Successfully read all enhancer IDs --")
        print("Number of interactors IDs: \(interactorIDs.count)")
        print("Number of enhancer profiles generated: \(result.count) (\(((Double(result.count)/Double(interactorIDs.count))*100.0).toRoundedInt())% of all interactors)")
        var regionCounts = [RegionProfileTag: Int]()
        for profile in result {
            for tag in profile.regionTags {
                if regionCounts[tag] == nil {
                    regionCounts[tag] = 0
                }
                regionCounts[tag]! += 1
            }
        }
        print("-- Region Breakdown --")
        for (region, count) in regionCounts {
            print("> Enhancer count for \(region.rawValue.uppercased()) : \(count)")
        }
        print("============================== END ENHANCER DATA ==================")
    }
    
    func testFriendlyData() throws {
        print("============================== FRIENDLY DATA ======================")
        let util = NPCProfileRepoUtil()
        let interactorIDs = util.getInteractorContentIDs()
        var result = [FriendlyProfile]()
        for id in interactorIDs {
            guard let interactorMetadata = util.getInteractorMetadata(contentID: id) else {
                XCTFail("Couldn't retrieve interactor \(id) metadata")
                continue
            }
            guard interactorMetadata.roles.contains("friendly") else {
                // We're only interested in friendlies
                continue
            }
            guard let regionTag = RegionProfileTag(rawValue: interactorMetadata.type) else {
                XCTFail("Interactor metadata has type \(interactorMetadata.type) with no corresponding RegionProfileTag")
                continue
            }
            var friendlyProfileTags = [FriendlyProfileTag]()
            for tag in interactorMetadata.friendlyTags {
                if let friendlyProfileTag = FriendlyProfileTag(rawValue: tag) {
                    friendlyProfileTags.append(friendlyProfileTag)
                } else {
                    XCTFail("Friendly tag '\(tag)' could not be converted into a FriendlyProfileTag")
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
        print("-- Successfully read all friendly IDs --")
        print("Number of interactors IDs: \(interactorIDs.count)")
        print("Number of friendly profiles generated: \(result.count) (\(((Double(result.count)/Double(interactorIDs.count))*100.0).toRoundedInt())% of all interactors)")
        var regionCounts = [RegionProfileTag: Int]()
        for profile in result {
            for tag in profile.regionTags {
                if regionCounts[tag] == nil {
                    regionCounts[tag] = 0
                }
                regionCounts[tag]! += 1
            }
        }
        print("-- Region Breakdown --")
        for (region, count) in regionCounts {
            print("> Friendly count for \(region.rawValue.uppercased()) : \(count)")
        }
        print("============================== END FRIENDLY DATA ==================")
    }
    
    func testRestorerData() throws {
        print("============================== RESTORER DATA ======================")
        let util = NPCProfileRepoUtil()
        let interactorIDs = util.getInteractorContentIDs()
        var result = [RestorerProfile]()
        for id in interactorIDs {
            guard let interactorMetadata = util.getInteractorMetadata(contentID: id) else {
                XCTFail("Couldn't retrieve interactor \(id) metadata")
                continue
            }
            guard interactorMetadata.roles.contains("restorer") else {
                // We're only interested in restorers
                continue
            }
            guard let regionTag = RegionProfileTag(rawValue: interactorMetadata.type) else {
                XCTFail("Interactor metadata has type \(interactorMetadata.type) with no corresponding RegionProfileTag")
                continue
            }
            var restoreOptions = [Restorer.RestoreOption]()
            for tag in interactorMetadata.restorerTags {
                if tag == "armor" {
                    restoreOptions.append(.armorPoints)
                } else if tag == "health" {
                    restoreOptions.append(.health)
                } else {
                    XCTFail("Restorer tag '\(tag)' could not be converted into a restore option")
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
        print("-- Successfully read all restorer IDs --")
        print("Number of interactors IDs: \(interactorIDs.count)")
        print("Number of restorer profiles generated: \(result.count) (\(((Double(result.count)/Double(interactorIDs.count))*100.0).toRoundedInt())% of all interactors)")
        var regionCounts = [RegionProfileTag: Int]()
        for profile in result {
            for tag in profile.regionTags {
                if regionCounts[tag] == nil {
                    regionCounts[tag] = 0
                }
                regionCounts[tag]! += 1
            }
        }
        print("-- Region Breakdown --")
        for (region, count) in regionCounts {
            print("> Restorer count for \(region.rawValue.uppercased()) : \(count)")
        }
        print("============================== END RESTORER DATA ==================")
    }
    
    func testNPCAnimationAssets() throws {
        let util = NPCProfileRepoUtil()
        let interactorIDs = util.getInteractorContentIDs()
        let foeIDs = util.getFoeContentIDs()
        let bossIDs = util.getBossContentIDs()
        for id in interactorIDs {
            let animation = AnimationManager<NPCSequenceCode>(fileID: id, initialSequence: .breathing)
            XCTAssertFalse(animation.emptyAnimation, "Failed to retrieve assets for interactor \(id)")
            // Make sure setting it works to - just just initialisation
            animation.setFileID(to: id)
            XCTAssertFalse(animation.emptyAnimation, "Failed to retrieve assets for interactor \(id)")
        }
        for id in foeIDs {
            let animation = AnimationManager<NPCSequenceCode>(fileID: id, initialSequence: .breathing)
            XCTAssertFalse(animation.emptyAnimation, "Failed to retrieve assets for foe \(id)")
            // Make sure setting it works to - just just initialisation
            animation.setFileID(to: id)
            XCTAssertFalse(animation.emptyAnimation, "Failed to retrieve assets for foe \(id)")
        }
        for id in bossIDs {
            let animation = AnimationManager<NPCSequenceCode>(fileID: id, initialSequence: .breathing)
            XCTAssertFalse(animation.emptyAnimation, "Failed to retrieve assets for boss \(id)")
            // Make sure setting it works to - just just initialisation
            animation.setFileID(to: id)
            XCTAssertFalse(animation.emptyAnimation, "Failed to retrieve assets for boss \(id)")
        }
    }

}
