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
    @StateObject private var playerViewModel = GameManager.instance.playerVM
    @StateObject private var playerLocationViewModel = GameManager.instance.playerLocationVM
    @State private var locationConnections = [LocationConnection?]()
    @StateObject var locationViewModels: ObservableArray<LocationViewModel> = ObservableArray(array: [LocationViewModel]()).observeChildrenChanges()
    @State private var animationSyncID = UUID()
    private static let PLAYER_LOCATION_TARGET_ID = UUID()
    
    var body: some View {
        let gridItems = Array(
            repeating: GridItem(.fixed(self.gridDimensions.hexagonWidth), spacing: self.gridDimensions.spacing),
            count: self.gridDimensions.columnsCount)
        ScrollViewReader { proxy in
            ScrollView([.vertical, .horizontal], showsIndicators: false) {
                ZStack {
                    MapGridLayerWithIndexIDs(gridItems: gridItems) { index in
                        // Area image
                        if let locationViewModel = self.getLocationViewModel(at: index) {
                            locationViewModel.tileBackgroundImage.image
                                .resizable()
                                .clipShape(Hexagon())
                                .gridHexagonFrame(hexagonIndex: index)
                                .opacity(locationViewModel.hasBeenVisited || self.travelStateManager.travellingActive && self.fadeIsActive(on: locationViewModel) ? 1 : YonderCoreGraphics.unvisitedLocationImageOpacity)
                                .repeatFadingAnimation(bounds: (YonderCoreGraphics.unvisitedLocationImageOpacity, 1), active: self.travelStateManager.travellingActive && self.fadeIsActive(on: locationViewModel))
                                .id(self.animationSyncID)
                                .reverseScroll()
                        }
                        
                        if (index+1)%(self.gridDimensions.columnsCount*2) == 0 {
                            // Skip the last column
                            // Required for the grid
                            GridSpacerView()
                        } else {
                            // Hexagon grid background
                            GridHexagonView(
                                hexagonIndex: index,
                                strokeStyle: .stroke,
                                strokeColor: YonderColors.outlineMinContrast
                            )
                        }
                    }
                    
                    MapGridLayer(gridItems: gridItems) { index in
                        if let locationViewModel = self.getLocationViewModel(at: index) {
                            if !locationViewModel.hasBeenVisited || locationViewModel.hasBeenVisited && self.fadeIsActive(on: locationViewModel) {
                                // Location outer border (dimmed)
                                GridHexagonView(
                                    hexagonIndex: index,
                                    strokeStyle: .stroke,
                                    strokeColor: YonderColors.border.adjustedBrightness(by: YonderCoreGraphics.unvisitedLocationBrightness)
                                )
                            }
                        } else {
                            // Required for the grid
                            GridSpacerView()
                        }
                    }
                    
                    MapGridLayer(gridItems: gridItems) { index in
                        if self.locationHasBeenVisited(at: index) && !self.fadeIsActive(at: index) {
                            // Location outer border (not dimmed)
                            GridHexagonView(
                                hexagonIndex: index,
                                strokeStyle: .stroke
                            )
                        }
                        else if let locationViewModel = self.getLocationViewModel(at: index), self.fadeIsActive(on: locationViewModel) && self.travelStateManager.travellingActive {
                            GridHexagonView(
                                hexagonIndex: index,
                                strokeStyle: .stroke,
                                strokeColor: YonderColors.border
                            )
                            .repeatFadingAnimation()
                            .id(self.animationSyncID)
                        } else {
                            // Required for the grid
                            GridSpacerView()
                        }
                        
                        if let locationConnection = self.getLocationConnection(at: index) {
                            // Grid connections (lines that connect hexagons)
                            GridConnectionsView(
                                hexagonIndex: index,
                                locationConnection: locationConnection,
                                playerLocationViewModel: self.playerLocationViewModel,
                                locationViewModel: self.locationViewModels[index]
                            )
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
                                strokeColor: locationViewModel.hasBeenVisited && !self.fadeIsActive(on: locationViewModel) ? YonderColors.border : YonderColors.border.adjustedBrightness(by: YonderCoreGraphics.unvisitedLocationBrightness),
                                fill: true
                            )
                            .onTapGesture {
                                self.playerViewModel.travel(to: locationViewModel) // Cheats
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
                                    strokeColor: YonderColors.border
                                )
                                .repeatFadingAnimation()
                                .id(self.animationSyncID)
                            }
                            
                            // Location icon
                            YonderIcon(image: locationViewModel.getTypeImage())
                                .offset(x: self.gridDimensions.getHorizontalOffset(hexagonIndex: index))
                                .opacity((locationViewModel.hasBeenVisited || self.travelStateManager.travellingActive && self.fadeIsActive(on: locationViewModel)) ? 1 : YonderCoreGraphics.unvisitedLocationImageOpacity)
                                .repeatFadingAnimation(bounds: (YonderCoreGraphics.unvisitedLocationImageOpacity, 1), active: self.travelStateManager.travellingActive && self.fadeIsActive(on: locationViewModel))
                                .id(self.animationSyncID)
                                .reverseScroll()
                            
                            // Triangle indicator
                            if locationViewModel.id == self.playerLocationViewModel.id {
                                Triangle()
                                    .strokeBorder(YonderColors.border, lineWidth: YonderCoreGraphics.mapGridLineWidth)
                                    .background(Triangle().foregroundColor(.red))
                                    .frame(width: 30)
                                    .offset(
                                        x: self.gridDimensions.getHorizontalOffset(hexagonIndex: index),
                                        y: -abs(self.gridDimensions.getHorizontalOffset(hexagonIndex: index))*0.4
                                    )
                                    .reverseScroll()
                            }
                            
                            // Clear view used to scroll to upon map loading
                            if locationViewModel.id == self.playerLocationViewModel.id {
                                let offsetFromCenter = self.gridDimensions.getHorizontalOffset(hexagonIndex: index)*2
                                let targetSideLength = 10.0
                                Color.clear
                                    .frame(width: abs(offsetFromCenter) + targetSideLength, height: targetSideLength)
                                    .reverseScroll()
                                    .overlay {
                                        HStack(spacing: 0) {
                                            if offsetFromCenter > 0 {
                                                Spacer()
                                            }
                                            
                                            Color.clear
                                                .frame(width: targetSideLength, height: targetSideLength)
                                                .id(Self.PLAYER_LOCATION_TARGET_ID)
                                            
                                            if offsetFromCenter < 0 {
                                                Spacer()
                                            }
                                        }
                                    }
                            }
                        } else {
                            // Required for the grid
                            GridSpacerView()
                        }
                    }
                }
                .padding(.vertical, 150)
                .padding(.leading, 50)
                .padding(.trailing, 50 - (self.gridDimensions.distanceBetweenColumnCentres)) // Account for removed last column
                .background(
                    GeometryReader { geo in
                        Color.clear.onAppear { self.scaleStateManager.setScrollViewSize(to: geo.size) }
                    }
                )
                .frame(
                    width: self.scaleStateManager.scrollViewSizeScaledWidth,
                    height: self.scaleStateManager.scrollViewSizeScaledHeight
                )
                .scaleEffect(self.scaleStateManager.scale)
            }
            .padding(0.001) // Stops jittering
            .reverseScroll()
            .environmentObject(self.gridDimensions)
            .padding(.top, -300.0*self.scaleStateManager.scale) // SEE: https://github.com/Andre-Pham/Yonder/issues/3
            .padding(.bottom, -100.0*self.scaleStateManager.scale) // SEE: https://github.com/Andre-Pham/Yonder/issues/3
            .onAppear {
                self.locationConnections = GameManager.instance.getMapLocationConnections(gridDimensions: self.gridDimensions)
                
                for locationConnection in self.locationConnections {
                    if locationConnection == nil {
                        self.locationViewModels.append(LocationViewModel(NoLocation()))
                    } else {
                        self.locationViewModels.append(locationConnection!.getLocationViewModel())
                    }
                }
                
                // On load, position the scroll onto where the player is
                self.scrollToCurrentLocation(using: proxy)
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
    
    func scrollToCurrentLocation(using proxy: ScrollViewProxy) {
        let playerLocation = self.playerLocationViewModel.locationViewModel
        if let index = self.locationConnections.firstIndex(where: { $0?.locationID == playerLocation.id }) {
            // Scrolling is a 2 step process
            // 1. Scroll to the index of the hexagon (works even when it's not being rendered, but not accurate in position)
            // 2. Scroll to the position of the hexagon (only works if it's being rendered on screen, but accurate in position)
            
            // Refer to MapGridLayerWithIndexIDs on ID definition
            proxy.scrollTo(index, anchor: .center)
            proxy.scrollTo(Self.PLAYER_LOCATION_TARGET_ID, anchor: .center) // Attempt even if it may not be loaded
            // Add a delay - scroll view lags when scrolling very far, so wait 1.5s for the current location to be lazily loaded in, THEN focus in on it
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                proxy.scrollTo(Self.PLAYER_LOCATION_TARGET_ID, anchor: .center)
            }
        }
    }
    
}

