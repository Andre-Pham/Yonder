//
//  Map.swift
//  yonder
//
//  Created by Andre Pham on 21/11/21.
//

import Foundation

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

let TEST_AREA_BLACK = Area(rootLocation: TEST_LOCATION_BLACK1, tipLocation: TEST_LOCATION_BLACK6)
let TEST_AREA_PURPLE = Area(rootLocation: TEST_LOCATION_PURPLE1, tipLocation: TEST_LOCATION_PURPLE7)
let TEST_AREA_BLUE = Area(rootLocation: TEST_LOCATION_BLUE1, tipLocation: TEST_LOCATION_BLUE8)

let TEST_SEGMENT = Segment(leftArea: TEST_AREA_BLACK, middleArea: TEST_AREA_PURPLE, rightArea: TEST_AREA_BLUE)
