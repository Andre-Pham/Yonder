//
//  MapGrid.swift
//  yonder
//
//  Created by Andre Pham on 2/1/2022.
//

import Foundation
import SwiftUI

// There is a lot of questionable maths in this... but it works, so just treat it like a blackbox with columns, spacing and height as parameters
struct MapGrid: View {
    // Parameters
    let columnsCount: Int = 6
    let spacing: CGFloat = 10.0
    let hexagonFrameHeight: CGFloat = 150
    
    var maxLocationHeight: Int = 22 // TEMP
    var hexagonFrameWidth: CGFloat {
        // I don't remember how I got this so just accept it's magic
        return (hexagonFrameHeight + 2*spacing/tan((120.0 - 90.0)*MathConstants.degreesToRadians))*MathConstants.hexagonWidthToHeight
    }
    var hexagonWidth: CGFloat {
        return hexagonFrameWidth/2 * cos(.pi/6) * 2
    }
    var hexagonCount: Int {
        return maxLocationHeight*columnsCount
    }
    
    let tempArea = GAME.map.territoriesInOrder.first!.segment.leftArea
    
    var body: some View {
        let gridItems = Array(repeating: GridItem(.fixed(hexagonWidth), spacing: spacing), count: columnsCount)
        var locationConnections: [LocationConnection] = getLocationConnections()
        
        ScrollView([.vertical, .horizontal]) {
            LazyVGrid(columns: gridItems, spacing: spacing) {
                ForEach(0..<hexagonCount, id: \.self) { index in
                    ZStack {
                        Hexagon()
                            .fill(.black)
                            .onTapGesture {
                                print(index)
                            }
                            .overlay(Text("\(index)").foregroundColor(.white))
                            .frame(width: hexagonFrameWidth, height: hexagonFrameHeight/2)
                            .offset(x: isEvenRow(index) ? -(hexagonWidth/4 + spacing/4) : hexagonWidth/4 + spacing/4)
                            .frame(width: (hexagonFrameHeight*MathConstants.hexagonWidthToHeight)/2 + spacing, height: hexagonFrameHeight*0.216) // 0.216 was found from trial and error so don't think too hard about it
                            .reverseScroll()
                        
                        if locationConnections.last!.locationHexagonIndex == index {
                            Hexagon()
                                .fill(.blue)
                                .frame(width: hexagonFrameWidth/2, height: hexagonFrameHeight/4)
                                .offset(x: isEvenRow(index) ? -(hexagonWidth/4 + spacing/4) : hexagonWidth/4 + spacing/4)
                                .frame(width: hexagonWidth/2, height: hexagonFrameHeight*0.25/2)
                                .reverseScroll()
                            
                            let locationConnection: LocationConnection = locationConnections.popLast()!
                            
                            ForEach(locationConnection.previousLocationsHexagonCoordinates) { coords in
                                let values = getCoordinatesDifference(from: locationConnection.locationHexagonCoordinate, to: coords)
                                
                                GridConnection(down: values.1, downAcross: values.0, spacing: spacing, horizontalOffset: (hexagonWidth/4 + spacing/4)*(isEvenRow(index) ? -1 : 1))
                            }
                        }
                    }
                }
            }
            .frame(width: (hexagonWidth + spacing)*CGFloat(columnsCount) + spacing*6)
        }
        .padding(1) // Stops jittering
        .reverseScroll()
    }
    
    // TODO: - Integrate LocationConnection and getLocationConnections in the Area class when I'm more confident in this approach
    
    struct LocationConnection {
        
        private let mapGridColumnsCount: Int
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
        
        init(location: LocationAbstract, mapGridColumnsCount: Int) {
            self.location = location
            self.mapGridColumnsCount = mapGridColumnsCount
        }
        
        mutating func addPreviousLocation(_ location: LocationAbstract) {
            self.previousLocations.append(location)
        }
        
        func coordinatesToHexagonIndex(_ coordinates: HexagonCoordinate) -> Int {
            return Int((Double(coordinates.x)/2).rounded(.down)) + coordinates.y*mapGridColumnsCount
        }
        
    }
    
    func getLocationConnections() -> [LocationConnection] {
        var result: [LocationConnection] = tempArea.locations.map { LocationConnection(location: $0, mapGridColumnsCount: columnsCount) }
        for location in tempArea.locations {
            for nextLocation in location.nextLocations {
                for (index, compareLocation) in tempArea.locations.enumerated() {
                    if nextLocation.id == compareLocation.id {
                        result[index].addPreviousLocation(location)
                    }
                }
            }
        }
        return result.sorted(by: { $0.locationHexagonIndex > $1.locationHexagonIndex })
    }
    
    func isEvenRow(_ index: Int) -> Bool {
        return index/columnsCount % 2 == 0
    }
    
    func getCoordinatesDifference(from coordinates: HexagonCoordinate, to otherCoordinates: HexagonCoordinate) -> (Int, Int) {
        return (otherCoordinates.x - coordinates.x, abs(otherCoordinates.y - coordinates.y))
    }
    
}

