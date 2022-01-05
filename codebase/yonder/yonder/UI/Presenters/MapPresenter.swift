//
//  MapPresenter.swift
//  yonder
//
//  Created by Andre Pham on 6/1/2022.
//

import Foundation

// TODO: - These functions are "messy"... functions need taking a look at

class MapPresenter: ObservableObject {
    
    private(set) var map: Map
    private let columnsCount: Int
    
    init(_ map: Map, columnsCount: Int) {
        self.map = map
        self.columnsCount = columnsCount
    }
    
    func getAllLocationConnections() -> [LocationConnection] {
        var result = [LocationConnection]()
        
        for (territoryIndex, territory) in self.map.territoriesInOrder.enumerated() {
            var segmentConnections = [LocationConnection]()
            for (areaIndex, area) in territory.segment.allAreas.enumerated() {
                segmentConnections.append(contentsOf: self.getLocationConnections(area: area, areaPosition: areaIndex, correspondingTerritoryPosition: territoryIndex))
            }
            result.append(contentsOf: segmentConnections)
        }
        
        return result.sorted(by: { $0.locationHexagonIndex > $1.locationHexagonIndex })
    }
    
    private func getLocationConnections(area: Area, areaPosition: Int, correspondingTerritoryPosition: Int) -> [LocationConnection] {
        var result: [LocationConnection] = area.locations.map { LocationConnection(location: $0, mapGridColumnsCount: columnsCount, areaPosition: areaPosition, territoryPosition: correspondingTerritoryPosition) }
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

extension MapPresenter {
    
    struct LocationConnection {
        
        private let mapGridColumnsCount: Int
        private let areaPosition: Int
        private let territoryPosition: Int
        let location: LocationAbstract
        var locationHexagonIndex: Int {
            return coordinatesToHexagonIndex(location.hexagonCoordinate!)
        }
        var locationHexagonCoordinate: HexagonCoordinate {
            return location.hexagonCoordinate!
        }
        private(set) var previousLocations = [LocationAbstract]()
        var previousLocationsHexagonIndices: [Int] {
            return previousLocations.map { coordinatesToHexagonIndex($0.hexagonCoordinate!) }
        }
        var previousLocationsHexagonCoordinates: [HexagonCoordinate] {
            return previousLocations.map { $0.hexagonCoordinate! }
        }
        
        init(location: LocationAbstract, mapGridColumnsCount: Int, areaPosition: Int, territoryPosition: Int) {
            self.location = location
            self.mapGridColumnsCount = mapGridColumnsCount
            self.areaPosition = areaPosition
            self.territoryPosition = territoryPosition
        }
        
        mutating func addPreviousLocation(_ location: LocationAbstract) {
            self.previousLocations.append(location)
        }
        
        func coordinatesToHexagonIndex(_ coordinates: HexagonCoordinate) -> Int {
            return Int((Double(coordinates.x)/2).rounded(.down)) + coordinates.y*mapGridColumnsCount + self.areaPosition*3 + (2*mapGridColumnsCount*self.territoryPosition)*13
        }
        
    }
    
}
