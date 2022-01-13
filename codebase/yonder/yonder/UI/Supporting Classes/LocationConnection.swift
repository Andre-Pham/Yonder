//
//  LocationConnection.swift
//  yonder
//
//  Created by Andre Pham on 14/1/2022.
//

import Foundation

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
                    areaPosition: areaIndex,
                    correspondingTerritoryPosition: territoryIndex))
            }
            allLocationConnections.append(contentsOf: segmentConnections)
            
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
    
    private func getAreaLocationConnections(area: Area, areaPosition: Int, correspondingTerritoryPosition: Int) -> [LocationConnection] {
        let result: [LocationConnection] = area.locations.map {
            LocationConnection(
                location: $0,
                mapGridColumnsCount: self.columnsCount,
                areaPosition: areaPosition,
                territoryPosition: correspondingTerritoryPosition)
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
                        result[index].addPreviousLocation(area.tipLocation, rightArea: areaIndex%2 == 1)
                    }
                }
            }
        }
        return result
    }
    
}

/// Represents a `Location` on the map grid, and its connections to its predecessors.
///
/// Use to retrieve information about a location's hexagon coordinate, as well as the hexagon coordinates of its location predecessors in order to draw lines between them on the map grid.
class LocationConnection {
    
    private let mapGridColumnsCount: Int
    private let areaPosition: Int
    private let territoryPosition: Int
    let location: LocationAbstract
    var locationHexagonIndex: Int {
        return self.coordinatesToHexagonIndex(self.location.hexagonCoordinate!)
    }
    var locationHexagonCoordinate: HexagonCoordinate {
        return self.location.hexagonCoordinate!
    }
    private(set) var previousLocations = [LocationAbstract]()
    private(set) var previousLocationIndicesFromRightArea = [Int]()
    var previousLocationsHexagonIndices: [Int] {
        return self.previousLocations.map { self.coordinatesToHexagonIndex($0.hexagonCoordinate!) }
    }
    var previousLocationsHexagonCoordinates: [HexagonCoordinate] {
        var result = self.previousLocations.map { $0.hexagonCoordinate! }
        
        for locationIndex in self.previousLocationIndicesFromRightArea {
            let coords = result[locationIndex]
            result[locationIndex] = HexagonCoordinate(coords.x + 6, coords.y)
        }
        
        return result
    }
    
    init(location: LocationAbstract, mapGridColumnsCount: Int, areaPosition: Int, territoryPosition: Int) {
        self.location = location
        self.mapGridColumnsCount = mapGridColumnsCount
        self.areaPosition = areaPosition
        self.territoryPosition = territoryPosition
    }
    
    func addPreviousLocation(_ location: LocationAbstract, rightArea: Bool = false) {
        self.previousLocations.append(location)
        
        if rightArea {
            self.previousLocationIndicesFromRightArea.append(self.previousLocations.count-1)
        }
    }
    
    func coordinatesToHexagonIndex(_ coordinates: HexagonCoordinate) -> Int {
        return Int((Double(coordinates.x)/2).rounded(.down)) + coordinates.y*self.mapGridColumnsCount + self.areaPosition*3 + (2*self.mapGridColumnsCount*self.territoryPosition)*16
    }
    
}
