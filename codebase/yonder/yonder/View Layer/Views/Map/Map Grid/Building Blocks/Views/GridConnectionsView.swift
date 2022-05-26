//
//  GridConnectionsView.swift
//  yonder
//
//  Created by Andre Pham on 16/1/2022.
//

import SwiftUI

struct GridConnectionsView: View {
    @EnvironmentObject private var travelStateManager: TravelStateManager
    @EnvironmentObject private var gridDimensions: GridDimensions
    let hexagonIndex: Int
    let locationConnection: LocationConnection
    @ObservedObject var playerLocationViewModel: PlayerLocationViewModel
    @ObservedObject var locationViewModel: LocationViewModel
    
    var body: some View {
        let previousViewModels = self.locationConnection.getPreviousLocationsLightweightViewModels()
        let previousIDs = previousViewModels.map { $0.id }
        let previousIsBridges = previousViewModels.map { $0.isBridge }
        let previousCoordinates = self.locationConnection.previousLocationsHexagonCoordinates
        
        ForEach(0..<previousCoordinates.count, id: \.self) { index in
            let id = previousIDs[index]
            let isBridge = previousIsBridges[index]
            let coords = previousCoordinates[index]
            let values = self.getCoordinatesDifference(from: self.locationConnection.locationHexagonCoordinate, to: coords)
            
            GridConnectionView(down: values.1,
                               downAcross: values.0,
                               spacing: self.gridDimensions.spacing,
                               horizontalOffset: self.gridDimensions.getHorizontalOffset(hexagonIndex: self.hexagonIndex),
                               color: self.getConnectionColor(from: id),
                               style: self.getGridConnectionStyle(to: coords, isBridge: isBridge))
            
            if self.travelStateManager.travellingActive && self.fadeIsActive(on: id) {
                GridConnectionView(down: values.1,
                                   downAcross: values.0,
                                   spacing: self.gridDimensions.spacing,
                                   horizontalOffset: self.gridDimensions.getHorizontalOffset(hexagonIndex: self.hexagonIndex),
                                   color: YonderColors.border,
                                   style: self.getGridConnectionStyle(to: coords, isBridge: isBridge))
                    .repeatFadingAnimation()
            }
        }
    }
    
    func getCoordinatesDifference(from coordinates: HexagonCoordinate, to otherCoordinates: HexagonCoordinate) -> (Int, Int) {
        return (otherCoordinates.x - coordinates.x, abs(otherCoordinates.y - coordinates.y))
    }
    
    func getGridConnectionStyle(to coords: HexagonCoordinate, isBridge: Bool) -> GridConnectionStyle {
        if isBridge {
            if self.locationConnection.locationHexagonCoordinate.y > coords.y {
                return .acrossDown
            }
        }
        return .downAcross
    }
    
    func getConnectionColor(from id: UUID) -> Color {
        if self.locationViewModel.locationIDsArrivedFrom.contains(id) && !self.fadeIsActive(on: id) {
            return YonderColors.border
        }
        return YonderColors.border.adjustedBrightness(by: YonderCoreGraphics.unvisitedLocationBrightness)
    }
    
    func fadeIsActive(on id: UUID) -> Bool {
        if locationConnection.locationID == self.playerLocationViewModel.id {
            for nextID in self.playerLocationViewModel.locationViewModel.nextLocationIDs {
                if nextID == id {
                    return true
                }
            }
        }
        return id == self.playerLocationViewModel.id
    }
}
