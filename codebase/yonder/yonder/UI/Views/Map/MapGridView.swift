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
    @StateObject private var playerViewModel = PlayerViewModel(GAME.player)
    @StateObject private var playerLocationViewModel = PlayerLocationViewModel(player: GAME.player)
    @State private var locationConnections = [LocationConnection?]()
    @StateObject var locationViewModels: ObservableArray<LocationViewModel> = ObservableArray(array: [LocationViewModel]()).observeChildrenChanges()
    
    let scales: [CGFloat] = [0.2, 0.35, 0.7, 1.0, 1.6]
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
            MapHeaderView(scaleIndex: self.$scaleIndex, scales: self.scales)
            
            ScrollView([.vertical, .horizontal], showsIndicators: false) {
                ZStack {
                    LazyVGrid(columns: gridItems, spacing: self.gridDimensions.spacing) {
                        ForEach(0..<self.gridDimensions.hexagonCount, id: \.self) { index in
                            ZStack {
                                // Area image
                                if let locationViewModel = self.getLocationViewModel(at: index) {
                                    locationViewModel.image
                                        .resizable()
                                        .clipShape(Hexagon())
                                        .gridHexagonFrame(hexagonIndex: index)
                                        .opacity(locationViewModel.hasBeenVisited || self.fadeIsActive(on: locationViewModel) ? 1 : YonderCoreGraphics.unvisitedLocationImageOpacity)
                                        .repeatFadingAnimation(bounds: (YonderCoreGraphics.unvisitedLocationImageOpacity, 1), active: self.fadeIsActive(on: locationViewModel))
                                        .reverseScroll()
                                }
                                
                                if (index+1)%12 == 0 {
                                    // Skip the last column
                                    // Required for the grid
                                    GridSpacerView()
                                }
                                else {
                                    // Hexagon grid background
                                    GridHexagonView(
                                        hexagonIndex: index,
                                        strokeStyle: .stroke,
                                        strokeColor: Color.Yonder.outlineMinContrast)
                                }
                            }
                        }
                    }
                    
                    LazyVGrid(columns: gridItems, spacing: self.gridDimensions.spacing) {
                        ForEach(0..<self.gridDimensions.hexagonCount, id: \.self) { index in
                            ZStack {
                                if let locationViewModel = self.getLocationViewModel(at: index) {
                                    if !locationViewModel.hasBeenVisited {
                                        // Location outer border (dimmed)
                                        GridHexagonView(
                                            hexagonIndex: index,
                                            strokeStyle: .stroke,
                                            strokeColor: ColorManipulation.adjustBrightness(of: Color.Yonder.border, amount: YonderCoreGraphics.unvisitedLocationBrightness))
                                    }
                                }
                                else {
                                    // Required for the grid
                                    GridSpacerView()
                                }
                            }
                        }
                    }
                    
                    LazyVGrid(columns: gridItems, spacing: self.gridDimensions.spacing) {
                        ForEach(0..<self.gridDimensions.hexagonCount, id: \.self) { index in
                            ZStack {
                                if self.locationHasBeenVisited(at: index) {
                                    // Location outer border (not dimmed)
                                    GridHexagonView(
                                        hexagonIndex: index,
                                        strokeStyle: .stroke)
                                }
                                else if let locationViewModel = self.getLocationViewModel(at: index), self.fadeIsActive(on: locationViewModel) {
                                    GridHexagonView(
                                        hexagonIndex: index,
                                        strokeStyle: .stroke,
                                        strokeColor: Color.Yonder.border)
                                        .repeatFadingAnimation()
                                }
                                else {
                                    // Required for the grid
                                    GridSpacerView()
                                }
                                
                                if let locationConnection = self.getLocationConnection(at: index) {
                                    // Grid connections (lines that connect hexagons)
                                    GridConnectionsView(
                                        hexagonIndex: index,
                                        locationConnection: locationConnection,
                                        playerLocationID: self.playerLocationViewModel.id,
                                        locationIDArrivedFrom: self.locationViewModels[index].locationIDArrivedFrom)
                                }
                            }
                        }
                    }
                    
                    LazyVGrid(columns: gridItems, spacing: self.gridDimensions.spacing) {
                        ForEach(0..<self.gridDimensions.hexagonCount, id: \.self) { index in
                            ZStack {
                                if let locationViewModel = self.getLocationViewModel(at: index) {
                                    // Location hexagon inner border and fill
                                    GridHexagonView(
                                        hexagonIndex: index,
                                        scale: 0.65,
                                        strokeStyle: .strokeBorder,
                                        strokeColor: locationViewModel.hasBeenVisited ? Color.Yonder.border : ColorManipulation.adjustBrightness(of: Color.Yonder.border, amount: YonderCoreGraphics.unvisitedLocationBrightness),
                                        fill: true)
                                        .onTapGesture {
                                            if locationViewModel.canBeTravelledTo(from: self.playerLocationViewModel.locationViewModel) {
                                                self.playerViewModel.travel(to: locationViewModel)
                                            }
                                        }
                                    
                                    // Location hexagon inner border fade animation
                                    if self.fadeIsActive(on: locationViewModel) {
                                        GridHexagonView(
                                            hexagonIndex: index,
                                            scale: 0.65,
                                            strokeStyle: .strokeBorder,
                                            strokeColor: Color.Yonder.border)
                                            .repeatFadingAnimation()
                                    }
                                    
                                    // Location icon
                                    GridHexagonIconView(locationType: locationViewModel.type)
                                        .offset(x: self.gridDimensions.getHorizontalOffset(hexagonIndex: index))
                                        .opacity(locationViewModel.hasBeenVisited || self.fadeIsActive(on: locationViewModel) ? 1 : YonderCoreGraphics.unvisitedLocationImageOpacity)
                                        .repeatFadingAnimation(bounds: (YonderCoreGraphics.unvisitedLocationImageOpacity, 1), active: self.fadeIsActive(on: locationViewModel))
                                        .reverseScroll()
                                    
                                    // Triangle indicator
                                    if locationViewModel.id == self.playerLocationViewModel.id {
                                        Triangle()
                                            .strokeBorder(Color.Yonder.border, lineWidth: YonderCoreGraphics.mapGridLineWidth)
                                            .background(Triangle().foregroundColor(.red))
                                            .frame(width: 30)
                                            .offset(x: self.gridDimensions.getHorizontalOffset(hexagonIndex: index),
                                                    y: -abs(self.gridDimensions.getHorizontalOffset(hexagonIndex: index))*0.4)
                                            .reverseScroll()
                                            .repeatFadingAnimation()
                                    }
                                }
                                else {
                                    // Required for the grid
                                    GridSpacerView()
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 75)
                .padding(.leading, 50)
                .padding(.trailing, 50 - (self.gridDimensions.distanceBetweenColumnCentres)) // Accont for removed last column
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
                    self.locationViewModels.append(LocationViewModel(NoLocation()))
                }
                else {
                    self.locationViewModels.append(locationConnection!.getLocationViewModel())
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
    
    func getLocationViewModel(at index: Int) -> LocationViewModel? {
        if self.locationConnectionExists(at: index) {
            return self.locationViewModels[index]
        }
        return nil
    }
    
    func locationConnectionExists(at index: Int) -> Bool {
        return self.getLocationConnection(at: index) != nil
    }
    
    func locationHasBeenVisited(at index: Int) -> Bool {
        if let locationViewModel = self.getLocationViewModel(at: index) {
            return locationViewModel.hasBeenVisited
        }
        return false
    }
    
    func fadeIsActive(on locationViewModel: LocationViewModel) -> Bool {
        return locationViewModel.canBeTravelledTo(from: self.playerLocationViewModel.locationViewModel)
    }
}

