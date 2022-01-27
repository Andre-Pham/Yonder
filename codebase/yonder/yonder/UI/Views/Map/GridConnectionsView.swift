//
//  GridConnectionsView.swift
//  yonder
//
//  Created by Andre Pham on 16/1/2022.
//

import SwiftUI

struct GridConnectionsView: View {
    @EnvironmentObject var gridDimensions: GridDimensions
    let hexagonIndex: Int
    let locationConnection: LocationConnection
    @ObservedObject var playerLocationViewModel: PlayerLocationViewModel
    @ObservedObject var locationViewModel: LocationViewModel
    
    var body: some View {
        let previousCoordinates = self.locationConnection.previousLocationsHexagonCoordinates
        let previousIDs = self.locationConnection.previousLocationsIDs
        
        ForEach(Array(zip(previousIDs, previousCoordinates)), id: \.0) { id, coords in
            let values = self.getCoordinatesDifference(from: self.locationConnection.locationHexagonCoordinate, to: coords)
            
            GridConnectionView(down: values.1,
                               downAcross: values.0,
                               spacing: self.gridDimensions.spacing,
                               horizontalOffset: self.gridDimensions.getHorizontalOffset(hexagonIndex: self.hexagonIndex),
                               color: self.getConnectionColor(from: id))
            
            if self.fadeIsActive(on: id) {
                GridConnectionView(down: values.1,
                                   downAcross: values.0,
                                   spacing: self.gridDimensions.spacing,
                                   horizontalOffset: self.gridDimensions.getHorizontalOffset(hexagonIndex: self.hexagonIndex),
                                   color: Color.Yonder.border)
                    .repeatFadingAnimation()
            }
        }
    }
    
    func getCoordinatesDifference(from coordinates: HexagonCoordinate, to otherCoordinates: HexagonCoordinate) -> (Int, Int) {
        return (otherCoordinates.x - coordinates.x, abs(otherCoordinates.y - coordinates.y))
    }
    
    func getConnectionColor(from id: UUID) -> Color {
        if self.locationViewModel.locationIDsArrivedFrom.contains(id) && !self.fadeIsActive(on: id) {
            return Color.Yonder.border
        }
        return ColorManipulation.adjustBrightness(of: Color.Yonder.border, amount: YonderCoreGraphics.unvisitedLocationBrightness)
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
