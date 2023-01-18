//
//  LocationConnection.swift
//  yonder
//
//  Created by Andre Pham on 14/1/2022.
//

import Foundation
import SwiftUI

/// Represents a `Location` on the map grid, and its connections to its predecessors.
/// Represents only the grid/rendering aspect of the locations. For information about the actual locations, refer to LocationViewModel.
///
/// Use to retrieve information about a location's hexagon coordinate, as well as the hexagon coordinates of its location predecessors in order to draw lines between them on the map grid.
class LocationConnection {
    
    let ROWS_IN_AREA = 11
    let ROWS_BETWEEN_AREAS = 5
    let COLUMNS_BETWEEN_AREA_TIPS = 6
    let ROWS_ADDED_BY_BOSS_AREA = 4
    
    private let mapGridColumnsCount: Int
    private let areaPosition: Int
    private let territoryPosition: Int
    private let location: Location
    var locationHexagonIndex: Int {
        return self.coordinatesToHexagonIndex(self.location.hexagonCoordinate!)
    }
    var locationHexagonCoordinate: HexagonCoordinate {
        return self.location.hexagonCoordinate!
    }
    var locationID: UUID {
        return self.location.id
    }
    private var previousLocations = [Location]()
    private(set) var previousLocationIndicesFromRightArea = [Int]()
    private(set) var previousLocationIndicesFromLeftArea = [Int]()
    private(set) var previousLocationIndicesFromPreviousTavernArea = [Int]()
    private(set) var previousLocationIndicesFromPreviousBossArea = [Int]()
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
        
        for locationIndex in self.previousLocationIndicesFromPreviousBossArea {
            let coords = result[locationIndex]
            result[locationIndex] = HexagonCoordinate(coords.x, coords.y - 2*(self.ROWS_IN_AREA + self.ROWS_BETWEEN_AREAS + self.ROWS_ADDED_BY_BOSS_AREA))
        }
        
        return result
    }
    
    init(location: Location, mapGridColumnsCount: Int, areaPosition: Int, territoryPosition: Int) {
        self.location = location
        self.mapGridColumnsCount = mapGridColumnsCount
        self.areaPosition = areaPosition
        self.territoryPosition = territoryPosition
    }
    
    /// - Parameters:
    ///   - previousTavernArea: True if the previous location is a tip location of a tavern area
    ///   - previousBossArea: True if the previous location is a tip location of a boss area
    func addPreviousLocation(_ location: Location, flipConnectionRight: Bool = false, flipConnectionLeft: Bool = false, previousTavernArea: Bool = false, previousBossArea: Bool = false) {
        guard !(self.previousLocations.map { $0.id }).contains(location.id) else {
            return
        }
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
        if previousBossArea {
            self.previousLocationIndicesFromPreviousBossArea.append(self.previousLocations.count-1)
        }
    }
    
    func coordinatesToHexagonIndex(_ coordinates: HexagonCoordinate) -> Int {
        return (
            Int((Double(coordinates.x)/2).rounded(.down))
            + coordinates.y*self.mapGridColumnsCount
            + self.areaPosition*self.COLUMNS_BETWEEN_AREA_TIPS/2
            + (2*self.mapGridColumnsCount*self.territoryPosition)*(self.ROWS_BETWEEN_AREAS + self.ROWS_IN_AREA)
            + Int((Double(territoryPosition)/Double(MapConfig.territoriesPerBoss)).rounded(.down))*self.ROWS_ADDED_BY_BOSS_AREA*self.mapGridColumnsCount*2
        )
    }
    
    func getLocationViewModel() -> LocationViewModel {
        return LocationViewModel(self.location)
    }
    
    func getPreviousLocationsLightweightViewModels() -> [LightweightLocationViewModel] {
        return self.previousLocations.map { LightweightLocationViewModel($0) }
    }
    
}
