//
//  Map.swift
//  yonder
//
//  Created by Andre Pham on 21/11/21.
//

import Foundation

func createTestMap() -> Map {
    let TEST_LOCATION_BLACK1 = Location(locationBridgeAccessibility: .noBridge)
    let TEST_LOCATION_BLACK2 = Location(locationBridgeAccessibility: .noBridge)
    let TEST_LOCATION_BLACK3 = Location(locationBridgeAccessibility: .rightBridge)
    let TEST_LOCATION_BLACK4 = Location(locationBridgeAccessibility: .leftBridge)
    let TEST_LOCATION_BLACK5 = Location(locationBridgeAccessibility: .noBridge)
    let TEST_LOCATION_BLACK6 = Location(locationBridgeAccessibility: .noBridge)

    let TEST_LOCATION_PURPLE1 = Location(locationBridgeAccessibility: .noBridge)
    let TEST_LOCATION_PURPLE2 = Location(locationBridgeAccessibility: .noBridge)
    let TEST_LOCATION_PURPLE3 = Location(locationBridgeAccessibility: .noBridge)
    let TEST_LOCATION_PURPLE4 = Location(locationBridgeAccessibility: .rightBridge)
    let TEST_LOCATION_PURPLE5 = Location(locationBridgeAccessibility: .leftBridge)
    let TEST_LOCATION_PURPLE6 = Location(locationBridgeAccessibility: .noBridge)
    let TEST_LOCATION_PURPLE7 = Location(locationBridgeAccessibility: .noBridge)

    let TEST_LOCATION_BLUE1 = Location(locationBridgeAccessibility: .noBridge)
    let TEST_LOCATION_BLUE2 = Location(locationBridgeAccessibility: .noBridge)
    let TEST_LOCATION_BLUE3 = Location(locationBridgeAccessibility: .leftBridge)
    let TEST_LOCATION_BLUE4 = Location(locationBridgeAccessibility: .rightBridge)
    let TEST_LOCATION_BLUE5 = Location(locationBridgeAccessibility: .noBridge)
    let TEST_LOCATION_BLUE6 = Location(locationBridgeAccessibility: .noBridge)
    let TEST_LOCATION_BLUE7 = Location(locationBridgeAccessibility: .noBridge)
    let TEST_LOCATION_BLUE8 = Location(locationBridgeAccessibility: .noBridge)

    // Automate this part by having pre-defined structures for areas
    let TEST_AREA_BLACK = Area(rootLocation: TEST_LOCATION_BLACK1, tipLocation: TEST_LOCATION_BLACK6)
    TEST_AREA_BLACK.addNextLocations(from: TEST_LOCATION_BLACK1, to: [TEST_LOCATION_BLACK2, TEST_LOCATION_BLACK3])
    TEST_AREA_BLACK.addNextLocations(from: TEST_LOCATION_BLACK2, to: [TEST_LOCATION_BLACK4, TEST_LOCATION_BLACK5])
    TEST_AREA_BLACK.addNextLocations(from: TEST_LOCATION_BLACK3, to: [TEST_LOCATION_BLACK6])
    TEST_AREA_BLACK.addNextLocations(from: TEST_LOCATION_BLACK4, to: [TEST_LOCATION_BLACK6])
    TEST_AREA_BLACK.addNextLocations(from: TEST_LOCATION_BLACK5, to: [TEST_LOCATION_BLACK6])
    let TEST_AREA_PURPLE = Area(rootLocation: TEST_LOCATION_PURPLE1, tipLocation: TEST_LOCATION_PURPLE7)
    TEST_AREA_PURPLE.addNextLocations(from: TEST_LOCATION_PURPLE1, to: [
        TEST_LOCATION_PURPLE2, TEST_LOCATION_PURPLE3, TEST_LOCATION_PURPLE4
    ])
    TEST_AREA_PURPLE.addNextLocations(from: TEST_LOCATION_PURPLE2, to: [TEST_LOCATION_PURPLE5])
    TEST_AREA_PURPLE.addNextLocations(from: TEST_LOCATION_PURPLE3, to: [TEST_LOCATION_PURPLE6])
    TEST_AREA_PURPLE.addNextLocations(from: TEST_LOCATION_PURPLE4, to: [TEST_LOCATION_PURPLE6])
    TEST_AREA_PURPLE.addNextLocations(from: TEST_LOCATION_PURPLE5, to: [TEST_LOCATION_PURPLE7])
    TEST_AREA_PURPLE.addNextLocations(from: TEST_LOCATION_PURPLE6, to: [TEST_LOCATION_PURPLE7])
    let TEST_AREA_BLUE = Area(rootLocation: TEST_LOCATION_BLUE1, tipLocation: TEST_LOCATION_BLUE8)
    TEST_AREA_BLUE.addNextLocations(from: TEST_LOCATION_BLUE1, to: [TEST_LOCATION_BLUE2])
    TEST_AREA_BLUE.addNextLocations(from: TEST_LOCATION_BLUE2, to: [TEST_LOCATION_BLUE3, TEST_LOCATION_BLUE4])
    TEST_AREA_BLUE.addNextLocations(from: TEST_LOCATION_BLUE3, to: [TEST_LOCATION_BLUE6, TEST_LOCATION_BLUE5])
    TEST_AREA_BLUE.addNextLocations(from: TEST_LOCATION_BLUE4, to: [TEST_LOCATION_BLUE5, TEST_LOCATION_BLUE7])
    TEST_AREA_BLUE.addNextLocations(from: TEST_LOCATION_BLUE5, to: [TEST_LOCATION_BLUE7])
    TEST_AREA_BLUE.addNextLocations(from: TEST_LOCATION_BLUE6, to: [TEST_LOCATION_BLUE8])
    TEST_AREA_BLUE.addNextLocations(from: TEST_LOCATION_BLUE7, to: [TEST_LOCATION_BLUE8])

    let TEST_SEGMENT = Segment(leftArea: TEST_AREA_BLACK, middleArea: TEST_AREA_PURPLE, rightArea: TEST_AREA_BLUE)
    let TEST_TAVERN_AREA = TavernArea()
    let TAVERN_LOCATION1 = Location(locationBridgeAccessibility: .noBridge)
    let TAVERN_LOCATION2 = Location(locationBridgeAccessibility: .noBridge)
    TEST_TAVERN_AREA.addRootLocations([TAVERN_LOCATION1])
    TEST_TAVERN_AREA.addTipLocations([TAVERN_LOCATION2])
    TEST_TAVERN_AREA.createDirectedEdges(from: TAVERN_LOCATION1, to: [TAVERN_LOCATION2])
    let TEST_TERRITORY = Territory(segment: TEST_SEGMENT, followingTavernArea: TEST_TAVERN_AREA)
    return Map(territoriesInOrder: [TEST_TERRITORY])
}
