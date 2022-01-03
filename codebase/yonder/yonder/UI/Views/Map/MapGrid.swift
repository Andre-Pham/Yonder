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
    var locationsPointingTo: [[LocationAbstract]] {
        var result: [[LocationAbstract]] = Array(repeating: [], count: tempArea.locations.count)
        for location in tempArea.locations {
            for nextLocation in location.nextLocations {
                for (index, compareLocation) in tempArea.locations.enumerated() {
                    if nextLocation.id == compareLocation.id {
                        result[index].append(location)
                    }
                }
            }
        }
        return result
    }
    
    var body: some View {
        let gridItems = Array(repeating: GridItem(.fixed(hexagonWidth), spacing: spacing), count: columnsCount)
        
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
                        
                        // This is so damn inefficient
                        ForEach(0..<tempArea.locations.count) { locationIndex in
                            if coordinatesToHexagonIndex(tempArea.locations[locationIndex].hexagonCoordinate!, alignment: .left) == index {
                                Hexagon()
                                    .fill(.blue)
                                    .frame(width: hexagonFrameWidth/2, height: hexagonFrameHeight/4)
                                    .offset(x: isEvenRow(index) ? -(hexagonWidth/4 + spacing/4) : hexagonWidth/4 + spacing/4)
                                    .frame(width: hexagonWidth/2, height: hexagonFrameHeight*0.25/2)
                                    .reverseScroll()
                                
                                ForEach(0..<locationsPointingTo[locationIndex].count) { connectedLocationIndex in
                                    let values = getDownAndAcrossValues(from: tempArea.locations[locationIndex].hexagonCoordinate!, to: locationsPointingTo[locationIndex][connectedLocationIndex].hexagonCoordinate!)
                                    
                                    WowView(down: values.1, downAcross: values.0, spacing: spacing, offset: (hexagonWidth/4 + spacing/4)*(isEvenRow(index) ? -1 : 1))
                                }
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
    
    func isEvenRow(_ index: Int) -> Bool {
        return index/columnsCount % 2 == 0
    }
    
    enum LocationAlignment {
        case left
        case right
    }
    
    func coordinatesToHexagonIndex(_ coordinates: HexagonCoordinate, alignment: LocationAlignment) -> Int {
        return Int((Double(coordinates.x)/2).rounded(.down)) + coordinates.y*columnsCount
    }
    
    func getCoordinatesDifference(from coordinates: HexagonCoordinate, to otherCoordinates: HexagonCoordinate) -> HexagonCoordinate {
        return HexagonCoordinate(otherCoordinates.x - coordinates.x, otherCoordinates.y - coordinates.y)
    }
    
    func getDownAndAcrossValues(from coordinates: HexagonCoordinate, to otherCoordinates: HexagonCoordinate) -> (Int, Int) {
        let coordinatesDifference = getCoordinatesDifference(from: coordinates, to: otherCoordinates)
        return (coordinatesDifference.x, abs(coordinatesDifference.y))
    }
    
}

