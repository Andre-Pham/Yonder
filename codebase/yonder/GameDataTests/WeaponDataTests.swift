//
//  WeaponDataTests.swift
//  GameDataTests
//
//  Created by Andre Pham on 25/3/2024.
//

import XCTest
@testable import yonder

final class WeaponDataTests: XCTestCase {

    func testWeaponData() throws {
        print("============================== WEAPON DATA ========================")
        let util = WeaponProfileRepoUtil()
        let result = util.getAllWeaponProfiles()
        print("Number of weapon profiles generated: \(result.count)")
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
            print("> Weapon count for \(region.rawValue.uppercased()) : \(count)")
            var weaponTypesCount = [WeaponProfileTag: Int]()
            for profile in result {
                if profile.matchesAreaTag(region) {
                    for tag in profile.weaponTags {
                        if weaponTypesCount[tag] == nil {
                            weaponTypesCount[tag] = 0
                        }
                        weaponTypesCount[tag]! += 1
                    }
                }
            }
            for tag in weaponTypesCount.keys {
                switch tag {
                case .damage:
                    print("    > damage weapons: \(weaponTypesCount[.damage]!)")
                case .damageAndRestoration:
                    print("    > damageAndRestoration weapons: \(weaponTypesCount[.damageAndRestoration]!)")
                case .restoration:
                    print("    > restoration weapons: \(weaponTypesCount[.restoration]!)")
                case .healthRestoration:
                    print("    > healthRestoration weapons: \(weaponTypesCount[.healthRestoration]!)")
                case .armorPointsRestoration:
                    print("    > armorPointsRestoration weapons: \(weaponTypesCount[.armorPointsRestoration]!)")
                case .collateral:
                    print("    > collateral weapons: \(weaponTypesCount[.collateral]!)")
                case .consumesFoe:
                    print("    > consumesFoe weapons: \(weaponTypesCount[.consumesFoe]!)")
                }
            }
        }
        print("============================== END WEAPON DATA ====================")
    }

}
