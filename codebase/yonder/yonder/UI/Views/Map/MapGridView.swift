//
//  MapGridView.swift
//  yonder
//
//  Created by Andre Pham on 2/1/2022.
//

import Foundation
import SwiftUI

// There is a lot of questionable maths in this... but it works, so just treat it like a blackbox with columns, spacing and height as parameters
struct MapGridView: View {
    
    let columnsCount: Int = 6
    let spacing: CGFloat = 10
    let hexagonFrameHeight: CGFloat = 150
    
    let maxLocationHeight: Int = 50 // TEMP
    let hexagonCount: Int
    let hexagonFrameWidth: CGFloat
    let hexagonWidth: CGFloat
    
    @ObservedObject private var mapViewModel: MapViewModel
    let locationConnections: [LocationConnection?]
    
    init(map: Map = GAME.map) {
        self.hexagonCount = self.maxLocationHeight*self.columnsCount
        self.hexagonFrameWidth = MathConstants.hexagonWidthToHeight*(self.hexagonFrameHeight + 2*self.spacing/tan((120.0 - 90.0)*MathConstants.degreesToRadians)) // I don't remember how I got this so just accept it's magic
        self.hexagonWidth = self.hexagonFrameWidth/2 * cos(.pi/6) * 2
        
        self.mapViewModel = MapViewModel(map)
        self.locationConnections = LocationConnectionGenerator(map: map, hexagonCount: self.hexagonCount, columnsCount: self.columnsCount).getAllLocationConnections()
    }
    
    var body: some View {
        let gridItems = Array(repeating: GridItem(.fixed(self.hexagonWidth), spacing: self.spacing), count: self.columnsCount)
        
        ScrollView([.vertical, .horizontal]) {
            LazyVGrid(columns: gridItems, spacing: spacing) {
                ForEach(0..<hexagonCount, id: \.self) { index in
                    ZStack {
                        Hexagon()
                            .fill(.gray)
                            .onTapGesture {
                                print(index)
                            }
                            //.overlay(Text("\(index), \(locationConnections.last?.locationHexagonIndex ?? 3333)").foregroundColor(.white))
                            .frame(width: self.hexagonFrameWidth, height: self.hexagonFrameHeight/2)
                            .offset(x: isEvenRow(index) ? -(self.hexagonWidth/4 + self.spacing/4) : self.hexagonWidth/4 + self.spacing/4)
                            .frame(width: (self.hexagonFrameHeight*MathConstants.hexagonWidthToHeight)/2 + self.spacing, height: self.hexagonFrameHeight*0.216) // 0.216 was found from trial and error so don't think too hard about it
                            .reverseScroll()
                        
                        if let locationConnection = locationConnections[index] {
                            Hexagon()
                                .fill(.blue)
                                .frame(width: self.hexagonFrameWidth/2, height: self.hexagonFrameHeight/4)
                                .offset(x: self.isEvenRow(index) ? -(self.hexagonWidth/4 + self.spacing/4) : self.hexagonWidth/4 + self.spacing/4)
                                .frame(width: self.hexagonWidth/2, height: self.hexagonFrameHeight*0.25/2)
                                .reverseScroll()
                            
                            ForEach(locationConnection.previousLocationsHexagonCoordinates) { coords in
                                let values = self.getCoordinatesDifference(from: locationConnection.locationHexagonCoordinate, to: coords)
                                
                                GridConnectionView(down: values.1, downAcross: values.0, spacing: spacing, horizontalOffset: (self.hexagonWidth/4 + self.spacing/4)*(self.isEvenRow(index) ? -1 : 1))
                            }
                        }
                    }
                }
            }
            .frame(width: (self.hexagonWidth + self.spacing)*CGFloat(self.columnsCount) + self.spacing*6)
        }
        .padding(1) // Stops jittering
        .reverseScroll()
    }
    
    func isEvenRow(_ index: Int) -> Bool {
        return index/columnsCount % 2 == 0
    }
    
    func getCoordinatesDifference(from coordinates: HexagonCoordinate, to otherCoordinates: HexagonCoordinate) -> (Int, Int) {
        return (otherCoordinates.x - coordinates.x, abs(otherCoordinates.y - coordinates.y))
    }
    
}

