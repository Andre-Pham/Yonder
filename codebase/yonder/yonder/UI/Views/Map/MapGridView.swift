//
//  MapGridView.swift
//  yonder
//
//  Created by Andre Pham on 2/1/2022.
//

import Foundation
import SwiftUI

struct MapGridView: View {
    @EnvironmentObject private var travelStateManager: TravelStateManager
    @StateObject private var gridDimensions = GridDimensions()
    @ObservedObject var scaleStateManager: ScaleStateManager
    @StateObject private var playerViewModel = PlayerViewModel(GAME.player)
    @StateObject private var playerLocationViewModel = PlayerLocationViewModel(player: GAME.player)
    @State private var locationConnections = [LocationConnection?]()
    @StateObject var locationViewModels: ObservableArray<LocationViewModel> = ObservableArray(array: [LocationViewModel]()).observeChildrenChanges()
    
    @State private var animationSyncID = UUID()
    
    var body: some View {
        let gridItems = Array(
            repeating: GridItem(.fixed(self.gridDimensions.hexagonWidth), spacing: self.gridDimensions.spacing),
            count: self.gridDimensions.columnsCount)
        
        ScrollView([.vertical, .horizontal], showsIndicators: false) {
            ZStack {
                MapGridLayer(gridItems: gridItems) { index in
                    // Area image
                    if let locationViewModel = self.getLocationViewModel(at: index) {
                        locationViewModel.image
                            .resizable()
                            .clipShape(Hexagon())
                            .gridHexagonFrame(hexagonIndex: index)
                            .opacity(locationViewModel.hasBeenVisited || self.travelStateManager.travellingActive && self.fadeIsActive(on: locationViewModel) ? 1 : YonderCoreGraphics.unvisitedLocationImageOpacity)
                            .repeatFadingAnimation(bounds: (YonderCoreGraphics.unvisitedLocationImageOpacity, 1), active: self.travelStateManager.travellingActive && self.fadeIsActive(on: locationViewModel))
                            .id(self.animationSyncID)
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
                
                MapGridLayer(gridItems: gridItems) { index in
                    if let locationViewModel = self.getLocationViewModel(at: index) {
                        if !locationViewModel.hasBeenVisited || locationViewModel.hasBeenVisited && self.fadeIsActive(on: locationViewModel) {
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
                
                MapGridLayer(gridItems: gridItems) { index in
                    if self.locationHasBeenVisited(at: index) && !self.fadeIsActive(at: index) {
                        // Location outer border (not dimmed)
                        GridHexagonView(
                            hexagonIndex: index,
                            strokeStyle: .stroke)
                    }
                    else if let locationViewModel = self.getLocationViewModel(at: index), self.fadeIsActive(on: locationViewModel) && self.travelStateManager.travellingActive {
                        GridHexagonView(
                            hexagonIndex: index,
                            strokeStyle: .stroke,
                            strokeColor: Color.Yonder.border)
                            .repeatFadingAnimation()
                            .id(self.animationSyncID)
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
                            playerLocationViewModel: self.playerLocationViewModel,
                            locationViewModel: self.locationViewModels[index])
                            .id(self.animationSyncID)
                    }
                }
                
                MapGridLayer(gridItems: gridItems) { index in
                    if let locationViewModel = self.getLocationViewModel(at: index) {
                        // Location hexagon inner border and fill
                        GridHexagonView(
                            hexagonIndex: index,
                            scale: 0.65,
                            strokeStyle: .strokeBorder,
                            strokeColor: locationViewModel.hasBeenVisited && !self.fadeIsActive(on: locationViewModel) ? Color.Yonder.border : ColorManipulation.adjustBrightness(of: Color.Yonder.border, amount: YonderCoreGraphics.unvisitedLocationBrightness),
                            fill: true)
                            .onTapGesture {
                                if self.travelStateManager.travellingActive && locationViewModel.canBeTravelledTo(from: self.playerLocationViewModel.locationViewModel) {
                                    self.playerViewModel.travel(to: locationViewModel)
                                    
                                    // Set all synced animations a new ID to reset their animation cycles
                                    self.animationSyncID = UUID()
                                    
                                    self.travelStateManager.setTravellingActive(to: false)
                                }
                            }
                        
                        // Location hexagon inner border fade animation
                        if self.fadeIsActive(on: locationViewModel) && self.travelStateManager.travellingActive {
                            GridHexagonView(
                                hexagonIndex: index,
                                scale: 0.65,
                                strokeStyle: .strokeBorder,
                                strokeColor: Color.Yonder.border)
                                .repeatFadingAnimation()
                                .id(self.animationSyncID)
                        }
                        
                        // Location icon
                        LocationIconView(locationType: locationViewModel.type)
                            .offset(x: self.gridDimensions.getHorizontalOffset(hexagonIndex: index))
                            .opacity((locationViewModel.hasBeenVisited || self.travelStateManager.travellingActive && self.fadeIsActive(on: locationViewModel)) ? 1 : YonderCoreGraphics.unvisitedLocationImageOpacity)
                            .repeatFadingAnimation(bounds: (YonderCoreGraphics.unvisitedLocationImageOpacity, 1), active: self.travelStateManager.travellingActive && self.fadeIsActive(on: locationViewModel))
                            .id(self.animationSyncID)
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
            .padding(.vertical, 75)
            .padding(.leading, 50)
            .padding(.trailing, 50 - (self.gridDimensions.distanceBetweenColumnCentres)) // Accont for removed last column
            .background(
                GeometryReader { geo in
                    Color.clear.onAppear { self.scaleStateManager.setScrollViewSize(to: geo.size) }
                }
            )
            .frame(
                width: self.scaleStateManager.scrollViewSizeScaledWidth,
                height: self.scaleStateManager.scrollViewSizeScaledHeight)
            .scaleEffect(self.scaleStateManager.scale)
        }
        .padding(0.001) // Stops jittering
        .reverseScroll()
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
    
    func fadeIsActive(at index: Int) -> Bool {
        if let locationViewModel = self.getLocationViewModel(at: index) {
            return self.fadeIsActive(on: locationViewModel)
        }
        return false
    }
}

