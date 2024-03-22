//
//  LocationConnectionGenerator.swift
//  yonder
//
//  Created by Andre Pham on 17/1/2023.
//

import Foundation

/// Used to generate an array of `LocationConnection` where each index corresponds to a hexagon index in the map grid. Hexagons in the map grid that don't contain a location are `nil` in the array.
class LocationConnectionGenerator {
    
    private let map: Map
    /// The total number of hexagons in the entire grid
    private let hexagonCount: Int
    /// The number of hexagon columns in the grid where the base hexagon's bottom edge overlaps with the grid's bottom edge
    private let columnsCount: Int
    
    init(map: Map, hexagonCount: Int, columnsCount: Int) {
        self.map = map
        self.hexagonCount = hexagonCount
        self.columnsCount = columnsCount
    }
    
    func getAllLocationConnections() -> [LocationConnection?] {
        var allLocationConnections = [LocationConnection]()
        
        allLocationConnections.append(
            LocationConnection(location: self.map.startingLocation, mapGridColumnsCount: self.columnsCount, areaPosition: 0, territoryPosition: 0)
        )
        
        for (territoryIndex, territory) in self.map.territoriesInOrder.enumerated() {
            var segmentConnections = [LocationConnection]()
            for (areaIndex, area) in territory.segment.allAreas.enumerated() {
                let previousTipLocations: [Location]
                if territoryIndex == 0 {
                    previousTipLocations = [self.map.startingLocation]
                } else if territoryIndex%MapConfig.territoriesPerBoss == 0 {
                    previousTipLocations = self.map.getPreviousBossAreaToTerritory(at: territoryIndex)!.tipLocations
                } else {
                    previousTipLocations = self.map.getPreviousTavernAreaToTerritory(at: territoryIndex)!.tipLocations
                }
                segmentConnections.append(contentsOf: self.getAreaLocationConnections(
                    area: area,
                    attachingTipLocations: previousTipLocations,
                    areaPosition: areaIndex,
                    correspondingTerritoryPosition: territoryIndex
                ))
            }
            allLocationConnections.append(contentsOf: segmentConnections)
            
            allLocationConnections.append(self.getBridgeLocationConnection(
                segment: territory.segment,
                correspondingTerritoryPosition: territoryIndex
            ))
            
            allLocationConnections.append(contentsOf: self.getTavernAreaLocationConnections(
                territory: territory,
                correspondingTerritoryPosition: territoryIndex
            ))
            
            if territoryIndex%MapConfig.territoriesPerBoss == MapConfig.territoriesPerBoss - 1 {
                allLocationConnections.append(contentsOf: self.getBossAreaLocationConnections(
                    bossArea: self.map.bossAreasInOrder[Int((Double(territoryIndex)/Double(MapConfig.territoriesPerBoss)).rounded(.down))],
                    attachingTipLocations: territory.tipLocations,
                    priorTerritoryPosition: territoryIndex
                ))
            }
        }
        
        // LocationConnections corresponding to each hexagon index - hexagon indices with no location are nil
        var result: [LocationConnection?] = Array(repeating: nil, count: self.hexagonCount)
        for locationConnection in allLocationConnections {
            result[locationConnection.locationHexagonIndex] = locationConnection
        }
        return result
    }
    
    /// Generates location connections for an area.
    /// - Parameters:
    ///   - area: The area to have its locations converted into location connections
    ///   - previousTavernArea: The previous tavern area, if applicable (first area has no previous tavern area)
    ///   - areaPosition: 0 means left, 1 means right
    ///   - correspondingTerritoryPosition: The position of the territory the area belongs to (starting at 0)
    /// - Returns: Location connections of all the locations within the area
    private func getAreaLocationConnections(area: Area, attachingTipLocations: [Location], areaPosition: Int, correspondingTerritoryPosition: Int) -> [LocationConnection] {
        let result: [LocationConnection] = area.locations.map {
            LocationConnection(
                location: $0,
                mapGridColumnsCount: self.columnsCount,
                areaPosition: areaPosition,
                territoryPosition: correspondingTerritoryPosition
            )
        }
        for location in attachingTipLocations {
            for nextLocation in location.nextLocations {
                if nextLocation.id == area.rootLocation.id {
                    let previousAreaIsTavern = correspondingTerritoryPosition != 0 && correspondingTerritoryPosition%MapConfig.territoriesPerBoss != 0
                    let previousAreaIsBoss = correspondingTerritoryPosition != 0 && correspondingTerritoryPosition%MapConfig.territoriesPerBoss == 0
                    result[0].addPreviousLocation(location, flipConnectionLeft: areaPosition == 1, previousTavernArea: previousAreaIsTavern, previousBossArea: previousAreaIsBoss)
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
            territoryPosition: correspondingTerritoryPosition
        )
        
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
                territoryPosition: correspondingTerritoryPosition
            )
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
    
    private func getBossAreaLocationConnections(bossArea: BossArea, attachingTipLocations: [Location], priorTerritoryPosition: Int) -> [LocationConnection] {
        let result: [LocationConnection] = bossArea.locations.map {
            LocationConnection(
                location: $0,
                mapGridColumnsCount: self.columnsCount,
                areaPosition: 0, // Coordinates are defined already horizontally aligned
                territoryPosition: priorTerritoryPosition
            )
        }
        // Boss location
        for tipLocation in attachingTipLocations {
            result[0].addPreviousLocation(tipLocation)
        }
        // Restorer location
        result[1].addPreviousLocation(bossArea.bossLocation)
        
        return result
    }
    
}
