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
    let columnsCount: Int// = 6
    let spacing: CGFloat// = 10.0
    let hexagonFrameHeight: CGFloat// = 150
    
    // TODO: - Take out locationConnections and put it in MapPresenter, and let it manage the contents, not the swuiftUI view
    // The swiftUI view sometimes mixes up values in the array... MapPresenter won't do this and should fix it
    let map: MapPresenter //= MapPresenter(GAME.map, columnsCount: columnsCount)
    //var locationConnections// = map.getAllLocationConnections()
    
    init(columnsCount: Int = 6, spacing: CGFloat = 10, hexagonFrameHeight: CGFloat = 150) {
        self.columnsCount = columnsCount
        self.spacing = spacing
        self.hexagonFrameHeight = hexagonFrameHeight
        let mapPresenter = MapPresenter(GAME.map, columnsCount: columnsCount)
        self.map = mapPresenter
        self.locationConnections = mapPresenter.getAllLocationConnections(hexagonCount: maxLocationHeight*columnsCount)
    }
    
    var maxLocationHeight: Int = 50 // TEMP
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
    
    let locationConnections: [LocationConnection?]
    
    //let tempArea = GAME.map.territoriesInOrder.first!.segment.leftArea
    
    var body: some View {
        let gridItems = Array(repeating: GridItem(.fixed(hexagonWidth), spacing: spacing), count: columnsCount)
        //let map = MapPresenter(GAME.map, columnsCount: columnsCount)
        //var locationConnections: [LocationConnection] = getLocationConnections()
        //var locationConnections = map.getAllLocationConnections()
        
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
                            .frame(width: hexagonFrameWidth, height: hexagonFrameHeight/2)
                            .offset(x: isEvenRow(index) ? -(hexagonWidth/4 + spacing/4) : hexagonWidth/4 + spacing/4)
                            .frame(width: (hexagonFrameHeight*MathConstants.hexagonWidthToHeight)/2 + spacing, height: hexagonFrameHeight*0.216) // 0.216 was found from trial and error so don't think too hard about it
                            .reverseScroll()
                        
                        if let locationConnection = locationConnections[index] {
                            Hexagon()
                                .fill(.blue)
                                .frame(width: hexagonFrameWidth/2, height: hexagonFrameHeight/4)
                                .offset(x: isEvenRow(index) ? -(hexagonWidth/4 + spacing/4) : hexagonWidth/4 + spacing/4)
                                .frame(width: hexagonWidth/2, height: hexagonFrameHeight*0.25/2)
                                .reverseScroll()
                            
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
    
    func isEvenRow(_ index: Int) -> Bool {
        return index/columnsCount % 2 == 0
    }
    
    func getCoordinatesDifference(from coordinates: HexagonCoordinate, to otherCoordinates: HexagonCoordinate) -> (Int, Int) {
        return (otherCoordinates.x - coordinates.x, abs(otherCoordinates.y - coordinates.y))
    }
    
}

