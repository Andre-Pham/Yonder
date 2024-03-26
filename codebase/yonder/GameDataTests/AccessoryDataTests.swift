//
//  AccessoryDataTests.swift
//  GameDataTests
//
//  Created by Andre Pham on 25/3/2024.
//

import XCTest
@testable import yonder

final class AccessoryDataTests: XCTestCase {

    func testAccessoryData() throws {
        print("============================== ACCESSORY DATA =====================")
        let util = AccessoryProfileRepoUtil()
        let result = util.getAllAccessoryProfiles()
        print("Number of accessory profiles generated: \(result.count)")
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
            print("> Accessory count for \(region.rawValue.uppercased()) : \(count)")
            var accessoryTypesCount = [AccessoryProfileTag: (Int, Int)]()
            for profile in result {
                if profile.matchesAreaTag(region) {
                    if accessoryTypesCount[profile.accessoryTag] == nil {
                        accessoryTypesCount[profile.accessoryTag] = (0, 0)
                    }
                    switch profile.accessoryType {
                    case .regular:
                        accessoryTypesCount[profile.accessoryTag]!.0 += 1
                    case .peripheral:
                        accessoryTypesCount[profile.accessoryTag]!.1 += 1
                    }
                }
            }
            for tag in accessoryTypesCount.keys {
                switch tag {
                case .defensive:
                    let regular = accessoryTypesCount[.defensive]!.0
                    let peripheral = accessoryTypesCount[.defensive]!.1
                    print("    > defensive accessories: \(regular + peripheral) (REGULAR: \(regular)) (PERIPHERAL: \(peripheral))")
                case .offensive:
                    let regular = accessoryTypesCount[.offensive]!.0
                    let peripheral = accessoryTypesCount[.offensive]!.1
                    print("    > offensive accessories: \(regular + peripheral) (REGULAR: \(regular)) (PERIPHERAL: \(peripheral))")
                case .gold:
                    let regular = accessoryTypesCount[.gold]!.0
                    let peripheral = accessoryTypesCount[.gold]!.1
                    print("    > gold accessories: \(regular + peripheral) (REGULAR: \(regular)) (PERIPHERAL: \(peripheral))")
                case .health:
                    let regular = accessoryTypesCount[.health]!.0
                    let peripheral = accessoryTypesCount[.health]!.1
                    print("    > health accessories: \(regular + peripheral) (REGULAR: \(regular)) (PERIPHERAL: \(peripheral))")
                case .everything:
                    let regular = accessoryTypesCount[.everything]!.0
                    let peripheral = accessoryTypesCount[.everything]!.1
                    print("    > everything accessories: \(regular + peripheral) (REGULAR: \(regular)) (PERIPHERAL: \(peripheral))")
                case .special:
                    let regular = accessoryTypesCount[.special]!.0
                    let peripheral = accessoryTypesCount[.special]!.1
                    print("    > special accessories: \(regular + peripheral) (REGULAR: \(regular)) (PERIPHERAL: \(peripheral))")
                }
            }
        }
        print("============================== END ACCESSORY DATA =================")
    }

}
