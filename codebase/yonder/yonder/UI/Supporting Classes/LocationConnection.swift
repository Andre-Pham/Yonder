//
//  LocationConnection.swift
//  yonder
//
//  Created by Andre Pham on 14/1/2022.
//

import Foundation

class LocationConnectionGenerator {
    
    let map: Map
    let hexagonCount: Int
    let columnsCount: Int
    
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
                segmentConnections.append(contentsOf: self.getAreaLocationConnections(area: area, areaPosition: areaIndex, correspondingTerritoryPosition: territoryIndex))
            }
            allLocationConnections.append(contentsOf: segmentConnections)
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
    
}

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
    var previousLocationsHexagonIndices: [Int] {
        return self.previousLocations.map { self.coordinatesToHexagonIndex($0.hexagonCoordinate!) }
    }
    var previousLocationsHexagonCoordinates: [HexagonCoordinate] {
        return self.previousLocations.map { $0.hexagonCoordinate! }
    }
    
    init(location: LocationAbstract, mapGridColumnsCount: Int, areaPosition: Int, territoryPosition: Int) {
        self.location = location
        self.mapGridColumnsCount = mapGridColumnsCount
        self.areaPosition = areaPosition
        self.territoryPosition = territoryPosition
    }
    
    func addPreviousLocation(_ location: LocationAbstract) {
        self.previousLocations.append(location)
    }
    
    func coordinatesToHexagonIndex(_ coordinates: HexagonCoordinate) -> Int {
        return Int((Double(coordinates.x)/2).rounded(.down)) + coordinates.y*self.mapGridColumnsCount + self.areaPosition*3 + (2*self.mapGridColumnsCount*self.territoryPosition)*13
    }
    
}
