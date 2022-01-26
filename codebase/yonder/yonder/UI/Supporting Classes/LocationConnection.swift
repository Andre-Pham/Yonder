//
//  LocationConnection.swift
//  yonder
//
//  Created by Andre Pham on 14/1/2022.
//

import Foundation
import SwiftUI

/// Used to generate an array of `LocationConnection` where each index corresponds to a hexagon index in the map grid. Hexagons in the map grid that don't contain a location are `nil` in the array.
class LocationConnectionGenerator {
    
    private let map: Map
    private let hexagonCount: Int
    private let columnsCount: Int
    
    init(map: Map, hexagonCount: Int, columnsCount: Int) {
        self.map = map
        self.hexagonCount = hexagonCount
        self.columnsCount = columnsCount
    }
    
    func getAllLocationConnections() -> [LocationConnection?] {
        var allLocationConnections = [LocationConnection]()
        
        for (territoryIndex, territory) in self.map.territoriesInOrder.enumerated() {
            var segmentConnections = [LocationConnection]()
            for (areaIndex, area) in territory.segment.allAreas.enumerated() {
                segmentConnections.append(contentsOf: self.getAreaLocationConnections(
                    area: area,
                    previousTavernArea: self.map.getPreviousTavernAreaToTerritory(at: territoryIndex),
                    areaPosition: areaIndex,
                    correspondingTerritoryPosition: territoryIndex))
            }
            allLocationConnections.append(contentsOf: segmentConnections)
            
            allLocationConnections.append(self.getBridgeLocationConnection(
                segment: territory.segment,
                correspondingTerritoryPosition: territoryIndex))
            
            allLocationConnections.append(contentsOf: self.getTavernAreaLocationConnections(
                territory: territory,
                correspondingTerritoryPosition: territoryIndex))
        }
        
        // LocationConnections corresponding to each hexagon index - hexagon indices with no location are nil
        var result: [LocationConnection?] = Array(repeating: nil, count: self.hexagonCount)
        for locationConnection in allLocationConnections {
            result[locationConnection.locationHexagonIndex] = locationConnection
        }
        return result
    }
    
    private func getAreaLocationConnections(area: Area, previousTavernArea: TavernArea?, areaPosition: Int, correspondingTerritoryPosition: Int) -> [LocationConnection] {
        let result: [LocationConnection] = area.locations.map {
            LocationConnection(
                location: $0,
                mapGridColumnsCount: self.columnsCount,
                areaPosition: areaPosition,
                territoryPosition: correspondingTerritoryPosition)
        }
        if let tavernArea = previousTavernArea {
            for location in tavernArea.tipLocations {
                for nextLocation in location.nextLocations {
                    if nextLocation.id == area.rootLocation.id {
                        result[0].addPreviousLocation(location, flipConnectionLeft: areaPosition == 1, previousTavernArea: true)
                    }
                }
            }
        }
        for location in area.locations {
            for nextLocation in location.nextLocations {
                for (index, compareLocation) in area.locations.enumerated() {
                    if nextLocation.id == compareLocation.id {
                        result[index].addPreviousLocation(location)
                    }
                }
            }
        }
        for (index, location) in area.locations.enumerated() {
            if let bridgeLocation = location.bridgeLocation,
               bridgeLocation.hexagonCoordinate!.y < location.hexagonCoordinate!.y {
                
                result[index].addPreviousLocation(bridgeLocation, flipConnectionLeft: areaPosition == 1)
            }
        }
        return result
    }
    
    private func getBridgeLocationConnection(segment: Segment, correspondingTerritoryPosition: Int) -> LocationConnection {
        let result = LocationConnection(
            location: segment.bridgeLocation,
            mapGridColumnsCount: self.columnsCount,
            areaPosition: 0,
            territoryPosition: correspondingTerritoryPosition)
        
        var positiveGradientTravel = false
        
        for location in segment.leftArea.rightBridgeLocations {
            if let nextLocation = location.bridgeLocation,
                nextLocation.id == segment.bridgeLocation.id &&
                location.hexagonCoordinate!.y < segment.bridgeLocation.hexagonCoordinate!.y {
                
                result.addPreviousLocation(location)
                positiveGradientTravel = true
            }
        }
        
        if !positiveGradientTravel {
            for location in segment.rightArea.leftBridgeLocations {
                if let nextLocation = location.bridgeLocation,
                    nextLocation.id == segment.bridgeLocation.id &&
                    location.hexagonCoordinate!.y < segment.bridgeLocation.hexagonCoordinate!.y {
                    
                    result.addPreviousLocation(location, flipConnectionRight: true)
                }
            }
        }
        
        return result
    }
    
    private func getTavernAreaLocationConnections(territory: Territory, correspondingTerritoryPosition: Int) -> [LocationConnection] {
        let tavernArea = territory.tavernArea
        let areas = territory.segment.allAreas
        
        let result: [LocationConnection] = tavernArea.locations.map {
            LocationConnection(
                location: $0,
                mapGridColumnsCount: self.columnsCount,
                areaPosition: 0, // Coordinates are defined already horizontally aligned
                territoryPosition: correspondingTerritoryPosition)
        }
        for location in tavernArea.locations {
            for nextLocation in location.nextLocations {
                for (index, compareLocation) in tavernArea.locations.enumerated() {
                    if (nextLocation.id == compareLocation.id &&
                        // Tavern areas have undirected paths, meaning paths go backwards, which shouldn't be drawn
                        location.hexagonCoordinate!.y <= compareLocation.hexagonCoordinate!.y) {
                        
                        result[index].addPreviousLocation(location)
                    }
                }
            }
        }
        for (areaIndex, area) in areas.enumerated() {
            for nextLocation in area.tipLocation.nextLocations {
                for (index, compareLocation) in tavernArea.locations.enumerated() {
                    if nextLocation.id == compareLocation.id {
                        result[index].addPreviousLocation(area.tipLocation, flipConnectionRight: areaIndex == 1)
                    }
                }
            }
        }
        return result
    }
    
}

/// Represents a `Location` on the map grid, and its connections to its predecessors.
/// Represents only the grid/rendering aspect of the locations. For information about the actual locations, refer to LocationViewModel.
///
/// Use to retrieve information about a location's hexagon coordinate, as well as the hexagon coordinates of its location predecessors in order to draw lines between them on the map grid.
class LocationConnection {
    
    let ROWS_IN_AREA = 11
    let ROWS_BETWEEN_AREAS = 5
    let COLUMNS_BETWEEN_AREA_TIPS = 6
    
    private let mapGridColumnsCount: Int
    private let areaPosition: Int
    private let territoryPosition: Int
    private let location: LocationAbstract
    var locationHexagonIndex: Int {
        return self.coordinatesToHexagonIndex(self.location.hexagonCoordinate!)
    }
    var locationHexagonCoordinate: HexagonCoordinate {
        return self.location.hexagonCoordinate!
    }
    private var previousLocations = [LocationAbstract]()
    private(set) var previousLocationIndicesFromRightArea = [Int]()
    private(set) var previousLocationIndicesFromLeftArea = [Int]()
    private(set) var previousLocationIndicesFromPreviousTavernArea = [Int]()
    var previousLocationsHexagonIndices: [Int] {
        return self.previousLocations.map { self.coordinatesToHexagonIndex($0.hexagonCoordinate!) }
    }
    var previousLocationsHexagonCoordinates: [HexagonCoordinate] {
        var result = self.previousLocations.map { $0.hexagonCoordinate! }
        
        for locationIndex in self.previousLocationIndicesFromRightArea {
            let coords = result[locationIndex]
            result[locationIndex] = HexagonCoordinate(coords.x + self.COLUMNS_BETWEEN_AREA_TIPS, coords.y)
        }
        
        for locationIndex in self.previousLocationIndicesFromLeftArea {
            let coords = result[locationIndex]
            result[locationIndex] = HexagonCoordinate(coords.x - self.COLUMNS_BETWEEN_AREA_TIPS, coords.y)
        }
        
        for locationIndex in self.previousLocationIndicesFromPreviousTavernArea {
            let coords = result[locationIndex]
            result[locationIndex] = HexagonCoordinate(coords.x, coords.y - 2*(self.ROWS_IN_AREA + self.ROWS_BETWEEN_AREAS))
        }
        
        return result
    }
    var previousLocationsIDs: [UUID] {
        return self.previousLocations.map { $0.id }
    }
    
    init(location: LocationAbstract, mapGridColumnsCount: Int, areaPosition: Int, territoryPosition: Int) {
        self.location = location
        self.mapGridColumnsCount = mapGridColumnsCount
        self.areaPosition = areaPosition
        self.territoryPosition = territoryPosition
    }
    
    func addPreviousLocation(_ location: LocationAbstract, flipConnectionRight: Bool = false, flipConnectionLeft: Bool = false, previousTavernArea: Bool = false) {
        self.previousLocations.append(location)
        
        if flipConnectionRight {
            self.previousLocationIndicesFromRightArea.append(self.previousLocations.count-1)
        }
        if flipConnectionLeft {
            self.previousLocationIndicesFromLeftArea.append(self.previousLocations.count-1)
        }
        if previousTavernArea {
            self.previousLocationIndicesFromPreviousTavernArea.append(self.previousLocations.count-1)
        }
    }
    
    func coordinatesToHexagonIndex(_ coordinates: HexagonCoordinate) -> Int {
        return Int((Double(coordinates.x)/2).rounded(.down)) + coordinates.y*self.mapGridColumnsCount + self.areaPosition*self.COLUMNS_BETWEEN_AREA_TIPS/2 + (2*self.mapGridColumnsCount*self.territoryPosition)*(self.ROWS_BETWEEN_AREAS + self.ROWS_IN_AREA)
    }
    
    func getLocationViewModel() -> LocationViewModel {
        return LocationViewModel(self.location)
    }
    
}
