//
//  MapGridView.swift
//  yonder
//
//  Created by Andre Pham on 2/1/2022.
//

import Foundation
import SwiftUI

struct MapGridView: View {
    @StateObject private var gridDimensions = GridDimensions()
    @StateObject private var mapViewModel = MapViewModel(GAME.map)
    @State private var locationConnections = [LocationConnection?]()
    
    var body: some View {
        let gridItems = Array(
            repeating: GridItem(.fixed(self.gridDimensions.hexagonWidth), spacing: self.gridDimensions.spacing),
            count: self.gridDimensions.columnsCount)
        
        ZStack {
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            ScrollView([.vertical, .horizontal]) {
                ZStack {
                    LazyVGrid(columns: gridItems, spacing: self.gridDimensions.spacing) {
                        ForEach(0..<self.gridDimensions.hexagonCount, id: \.self) { index in
                            ZStack {
                                if self.locationConnections.count > index, let locationConnection = self.locationConnections[index] {
                                    locationConnection.location.areaContent.image
                                        .resizable()
                                        .clipShape(Hexagon())
                                        .gridHexagonFrame(hexagonIndex: index)
                                        .reverseScroll()
                                }
                                
                                GridHexagonView(
                                    hexagonIndex: index,
                                    strokeStyle: .stroke,
                                    strokeColor: Color.Yonder.outlineMinContrast)
                                    
                                if self.locationConnections.count > index, let locationConnection = self.locationConnections[index] {
                                    GridConnectionsView(
                                        locationConnection: locationConnection,
                                        spacing: self.gridDimensions.spacing,
                                        horizontalOffset: self.gridDimensions.getHorizontalOffset(hexagonIndex: index))
                                }
                            }
                        }
                    }
                    
                    LazyVGrid(columns: gridItems, spacing: self.gridDimensions.spacing) {
                        ForEach(0..<self.gridDimensions.hexagonCount, id: \.self) { index in
                            ZStack {
                                if self.locationConnections.count > index {
                                    GridHexagonView(
                                        hexagonIndex: index,
                                        scale: 0.65,
                                        strokeStyle: .strokeBorder,
                                        fill: true)
                                        .opacity(self.locationConnections[index] == nil ? 0 : 1)
                                    
                                    if let locationConnection = self.locationConnections[index] {
                                        GridHexagonView(
                                            hexagonIndex: index,
                                            strokeStyle: .stroke)
                                        
                                        self.getCorrespondingIcon(locationType: locationConnection.location.type)
                                            .offset(x: self.gridDimensions.getHorizontalOffset(hexagonIndex: index))
                                            .reverseScroll()
                                    }
                                }
                            }
                        }
                    }
                }
                .frame(width: (self.gridDimensions.hexagonWidth + self.gridDimensions.spacing)*CGFloat(self.gridDimensions.columnsCount) + self.gridDimensions.spacing*6)
            }
            .padding(1) // Stops jittering
            .reverseScroll()
        }
        .environmentObject(self.gridDimensions)
        .onAppear {
            self.locationConnections = LocationConnectionGenerator(
                map: GAME.map,
                hexagonCount: self.gridDimensions.hexagonCount,
                columnsCount: self.gridDimensions.columnsCount)
                .getAllLocationConnections()
        }
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

