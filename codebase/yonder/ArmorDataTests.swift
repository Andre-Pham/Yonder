//
//  ArmorDataTests.swift
//  GameDataTests
//
//  Created by Andre Pham on 25/3/2024.
//

import XCTest
@testable import yonder

final class ArmorDataTests: XCTestCase {

    func testArmorData() throws {
        print("============================== ARMOR DATA =========================")
        let util = ArmorProfileRepoUtil()
        let result = util.getAllArmorProfiles()
        print("Number of armor profiles generated: \(result.count)")
        var regionCounts = [RegionProfileTag: Int]()
        for profile in result {
            for tag in profile.regionTags {
                if regionCounts[tag] == nil {
                    regionCounts[tag] = 0
                }
                regionCounts[tag]! += 1
            }
        }
        for (region, count) in regionCounts {
            print("-- \(region.rawValue.uppercased()) Region Breakdown --")
            print("> Armor count for \(region.rawValue.uppercased()) : \(count)")
            var armorTypesCount = [ArmorProfileTag: (Int, Int, Int)]()
            for profile in result {
                if profile.matchesAreaTag(region) {
                    if armorTypesCount[profile.armorTag] == nil {
                        armorTypesCount[profile.armorTag] = (0, 0, 0)
                    }
                    switch profile.armorType {
                    case .head:
                        armorTypesCount[profile.armorTag]!.0 += 1
                    case .body:
                        armorTypesCount[profile.armorTag]!.1 += 1
                    case .legs:
                        armorTypesCount[profile.armorTag]!.2 += 1
                    }
                }
            }
            for tag in armorTypesCount.keys {
                switch tag {
                case .heavyweight:
                    let head = armorTypesCount[.heavyweight]!.0
                    let body = armorTypesCount[.heavyweight]!.1
                    let legs = armorTypesCount[.heavyweight]!.2
                    print("    > heavyweight armor pieces: \(head + body + legs) (HEAD: \(head) | BODY: \(body) | LEGS: \(legs))")
                case .lightweight:
                    let head = armorTypesCount[.lightweight]!.0
                    let body = armorTypesCount[.lightweight]!.1
                    let legs = armorTypesCount[.lightweight]!.2
                    print("    > lightweight armor pieces: \(head + body + legs) (HEAD: \(head) | BODY: \(body) | LEGS: \(legs))")
                }
            }
        }
        print("============================== END ARMOR DATA =====================")
    }
    
}
