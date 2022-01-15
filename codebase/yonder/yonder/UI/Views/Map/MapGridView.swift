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
    let spacing: CGFloat = 0
    let hexagonFrameHeight: CGFloat = 240
    
    let maxLocationHeight: Int = 100 // TEMP
    let hexagonCount: Int
    let hexagonFrameWidth: CGFloat
    let hexagonWidth: CGFloat
    let distanceBetweenColumnCentres: CGFloat
    
    @ObservedObject private var mapViewModel: MapViewModel
    let locationConnections: [LocationConnection?]
    
    init(map: Map = GAME.map) {
        self.hexagonCount = self.maxLocationHeight*self.columnsCount
        self.hexagonFrameWidth = MathConstants.hexagonWidthToHeight*(self.hexagonFrameHeight + 2*self.spacing/tan((120.0 - 90.0)*MathConstants.degreesToRadians)) // I don't remember how I got this so just accept it's magic
        self.hexagonWidth = self.hexagonFrameWidth/2 * cos(.pi/6) * 2
        self.distanceBetweenColumnCentres = self.hexagonWidth/2 + self.spacing/2
        
        self.mapViewModel = MapViewModel(map)
        self.locationConnections = LocationConnectionGenerator(map: map, hexagonCount: self.hexagonCount, columnsCount: self.columnsCount).getAllLocationConnections()
    }
    
    var body: some View {
        let gridItems = Array(repeating: GridItem(.fixed(self.hexagonWidth), spacing: self.spacing), count: self.columnsCount)
        
        ZStack {
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            ScrollView([.vertical, .horizontal]) {
                ZStack {
                    LazyVGrid(columns: gridItems, spacing: spacing) {
                        ForEach(0..<hexagonCount, id: \.self) { index in
                            ZStack {
                                let horizontalOffset = self.distanceBetweenColumnCentres/2 * (self.isEvenRow(index) ? -1 : 1)
                                
                                if let locationConnection = locationConnections[index] {
                                    locationConnection.location.areaContent.image
                                        .resizable()
                                        .frame(width: self.hexagonFrameWidth, height: self.hexagonFrameHeight/2)
                                        .clipShape(Hexagon())
                                        .offset(x: horizontalOffset)
                                        .frame(width: (self.hexagonFrameHeight*MathConstants.hexagonWidthToHeight)/2 + self.spacing, height: self.hexagonFrameHeight*0.216) // 0.216 was found from trial and error so don't think too hard about it
                                        .reverseScroll()
                                }
                                    
                                Hexagon()
                                    .stroke(Color.Yonder.outlineMinContrast, lineWidth: YonderCoreGraphics.borderWidth)
                                    .frame(width: self.hexagonFrameWidth, height: self.hexagonFrameHeight/2)
                                    .offset(x: horizontalOffset)
                                    .frame(width: (self.hexagonFrameHeight*MathConstants.hexagonWidthToHeight)/2 + self.spacing, height: self.hexagonFrameHeight*0.216) // 0.216 was found from trial and error so don't think too hard about it
                                    .reverseScroll()
                                    
                                if let locationConnection = locationConnections[index] {
                                    ForEach(locationConnection.previousLocationsHexagonCoordinates) { coords in
                                        let values = self.getCoordinatesDifference(from: locationConnection.locationHexagonCoordinate, to: coords)
                                        
                                        GridConnectionView(down: values.1, downAcross: values.0, spacing: self.spacing, horizontalOffset: horizontalOffset)
                                    }
                                }
                            }
                        }
                    }
                    
                    LazyVGrid(columns: gridItems, spacing: spacing) {
                        ForEach(0..<hexagonCount, id: \.self) { index in
                            ZStack {
                                let horizontalOffset = self.distanceBetweenColumnCentres/2 * (self.isEvenRow(index) ? -1 : 1)
                                
                                Hexagon()
                                    .strokeBorder(Color.Yonder.border, lineWidth: YonderCoreGraphics.borderWidth)
                                    .background(Hexagon().foregroundColor(Color.Yonder.backgroundMaxDepth))
                                    .frame(width: self.hexagonFrameWidth * 0.65, height: self.hexagonFrameHeight/2 * 0.65)
                                    .offset(x: horizontalOffset)
                                    .frame(width: (self.hexagonFrameHeight*MathConstants.hexagonWidthToHeight)/2 + self.spacing, height: self.hexagonFrameHeight*0.216)
                                    .reverseScroll()
                                    .opacity(locationConnections[index] == nil ? 0 : 1)
                                
                                if let locationConnection = locationConnections[index] {
                                    Hexagon()
                                        //.strokeBorder(Color.Yonder.border, lineWidth: YonderCoreGraphics.borderWidth/2)
                                        .stroke(Color.Yonder.border, lineWidth: YonderCoreGraphics.borderWidth)
                                        .frame(width: self.hexagonFrameWidth, height: self.hexagonFrameHeight/2)
                                        .offset(x: horizontalOffset)
                                        .frame(width: (self.hexagonFrameHeight*MathConstants.hexagonWidthToHeight)/2 + self.spacing, height: self.hexagonFrameHeight*0.216) // 0.216 was found from trial and error so don't think too hard about it
                                        .reverseScroll()
                                    
                                    self.getCorrespondingIcon(locationType: locationConnection.location.type)
                                        .offset(x: horizontalOffset)
                                        .reverseScroll()
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
    }
    
    func isEvenRow(_ index: Int) -> Bool {
        return index/columnsCount % 2 == 0
    }
    
    func getCoordinatesDifference(from coordinates: HexagonCoordinate, to otherCoordinates: HexagonCoordinate) -> (Int, Int) {
        return (otherCoordinates.x - coordinates.x, abs(otherCoordinates.y - coordinates.y))
    }
    
    func getCorrespondingIcon(locationType: LocationType) -> YonderIcon {
        switch locationType {
        case .none: return YonderIcon(image: YonderImages.missingIcon)
        case .hostile: return YonderIcon(image: YonderImages.hostileIcon)
        case .challengeHostile: return YonderIcon(image: YonderImages.challengeHostileIcon)
        case .shop: return YonderIcon(image: YonderImages.shopIcon)
        case .enhancer: return YonderIcon(image: YonderImages.enhancerIcon)
        case .restorer: return YonderIcon(image: YonderImages.restorerIcon)
        case .quest: return YonderIcon(image: YonderImages.missingIcon)
        case .friendly: return YonderIcon(image: YonderImages.friendlyIcon)
        case .boss: return YonderIcon(image: YonderImages.missingIcon)
        }
    }
}

