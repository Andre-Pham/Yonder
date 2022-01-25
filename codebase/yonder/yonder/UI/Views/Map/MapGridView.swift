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
    @StateObject private var playerLocationViewModel = PlayerLocationViewModel(player: GAME.player)
    @State private var locationConnections = [LocationConnection?]()
    @StateObject var locationViewModels: ObservableArray<LocationViewModel> = ObservableArray(array: [LocationViewModel]()).observeChildrenChanges()
    
    let scales = [0.2, 0.35, 0.7, 1.0, 1.6]
    @State private var scaleIndex: Int = 2
    private var scale: CGFloat {
        return self.scales[self.scaleIndex]
    }
    @State private var scrollViewSize = CGSize()
    
    var body: some View {
        let gridItems = Array(
            repeating: GridItem(.fixed(self.gridDimensions.hexagonWidth), spacing: self.gridDimensions.spacing),
            count: self.gridDimensions.columnsCount)
        
        VStack(spacing: 0) {
            HStack(spacing: YonderCoreGraphics.padding) {
                Button {
                    self.scaleIndex -= 1
                } label: {
                    YonderSquareButtonLabel(text: "-")
                }
                .disabled(self.scaleIndex == 0)
                .opacity(self.scaleIndex == 0 ? 0.2 : 1)
                
                Button {
                    self.scaleIndex += 1
                } label: {
                    YonderSquareButtonLabel(text: "+")
                }
                .disabled(self.scaleIndex == self.scales.count-1)
                .opacity(self.scaleIndex == self.scales.count-1 ? 0.2 : 1)
                
                Spacer()
                
                Button {
                    // Will expand with matchGeometryEffect to show legend
                } label: {
                    YonderSquareButtonLabel(text: "i")
                }
            }
            .padding(.bottom, YonderCoreGraphics.padding)
            .padding(.horizontal, YonderCoreGraphics.padding)
            
            ScrollView([.vertical, .horizontal], showsIndicators: false) {
                ZStack {
                    LazyVGrid(columns: gridItems, spacing: self.gridDimensions.spacing) {
                        ForEach(0..<self.gridDimensions.hexagonCount, id: \.self) { index in
                            ZStack {
                                if let locationConnection = self.getLocationConnection(at: index) {
                                    locationConnection.locationImage
                                        .resizable()
                                        .clipShape(Hexagon())
                                        .gridHexagonFrame(hexagonIndex: index)
                                        .reverseScroll()
                                }
                                
                                GridHexagonView(
                                    hexagonIndex: index,
                                    strokeStyle: .stroke,
                                    strokeColor: Color.Yonder.outlineMinContrast)
                                    
                                if let locationConnection = self.getLocationConnection(at: index) {
                                    GridConnectionsView(
                                        hexagonIndex: index,
                                        locationConnection: locationConnection,
                                        locationIDArrivedFrom: self.locationViewModels.array[index].locationIDArrivedFrom)
                                }
                            }
                        }
                    }
                    
                    LazyVGrid(columns: gridItems, spacing: self.gridDimensions.spacing) {
                        ForEach(0..<self.gridDimensions.hexagonCount, id: \.self) { index in
                            ZStack {
                                GridHexagonView(
                                    hexagonIndex: index,
                                    scale: 0.65,
                                    strokeStyle: .strokeBorder,
                                    fill: true)
                                    .opacity(self.locationConnections.count <= index || self.locationConnections[index] == nil ? 0 : 1)
                                
                                if let locationConnection = self.getLocationConnection(at: index) {
                                    GridHexagonView(
                                        hexagonIndex: index,
                                        strokeStyle: .stroke)
                                    
                                    GridHexagonIconView(locationType: locationConnection.locationType)
                                        .offset(x: self.gridDimensions.getHorizontalOffset(hexagonIndex: index))
                                        .reverseScroll()
                                    
                                    if locationConnection.locationID == self.playerLocationViewModel.id {
                                        YonderIcon(image: YonderImages.healthIcon)
                                            .offset(x: self.gridDimensions.getHorizontalOffset(hexagonIndex: index))
                                            .reverseScroll()
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 75)
                .padding(.horizontal, 50)
                .background(
                    GeometryReader { geo in
                        Color.clear.onAppear { self.scrollViewSize = geo.size }
                    }
                )
                .frame(width: self.scrollViewSize.width*self.scale, height: self.scrollViewSize.height*self.scale)
                .scaleEffect(self.scale)
            }
            .padding(0.001) // Stops jittering
            .reverseScroll()
        }
        .environmentObject(self.gridDimensions)
        .onAppear {
            self.locationConnections = LocationConnectionGenerator(
                map: GAME.map,
                hexagonCount: self.gridDimensions.hexagonCount,
                columnsCount: self.gridDimensions.columnsCount)
                .getAllLocationConnections()
            
            for locationConnection in self.locationConnections {
                if locationConnection == nil {
                    self.locationViewModels.appendToArray(LocationViewModel(NoLocation()))
                }
                else {
                    self.locationViewModels.appendToArray(locationConnection!.getLocationViewModel())
                }
            }
        }
    }
    
    func getLocationConnection(at index: Int) -> LocationConnection? {
        if self.locationConnections.count > index, let locationConnection = self.locationConnections[index] {
            return locationConnection
        }
        return nil
    }
}

