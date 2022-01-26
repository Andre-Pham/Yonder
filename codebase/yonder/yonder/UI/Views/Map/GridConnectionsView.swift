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
    let playerLocationID: UUID
    let locationIDArrivedFrom: UUID
    @State private var color: Color = Color.Yonder.border
    
    var body: some View {
        let previousCoordinates = self.locationConnection.previousLocationsHexagonCoordinates
        let previousIDs = self.locationConnection.previousLocationsIDs
        
        ForEach(Array(zip(previousIDs, previousCoordinates)), id: \.0) { id, coords in
            let values = self.getCoordinatesDifference(from: self.locationConnection.locationHexagonCoordinate, to: coords)
            
            if self.fadeIsActive() {
                GridConnectionView(down: values.1,
                                   downAcross: values.0,
                                   spacing: self.gridDimensions.spacing,
                                   horizontalOffset: self.gridDimensions.getHorizontalOffset(hexagonIndex: self.hexagonIndex),
                                   color: self.color)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: self.color)
                    .onAppear {
                        self.color = self.getConnectionColor(from: id)
                    }
            }
            else {
                GridConnectionView(down: values.1,
                                   downAcross: values.0,
                                   spacing: self.gridDimensions.spacing,
                                   horizontalOffset: self.gridDimensions.getHorizontalOffset(hexagonIndex: self.hexagonIndex),
                                   color: self.getConnectionColor(from: id))
            }
        }
    }
    
    func getCoordinatesDifference(from coordinates: HexagonCoordinate, to otherCoordinates: HexagonCoordinate) -> (Int, Int) {
        return (otherCoordinates.x - coordinates.x, abs(otherCoordinates.y - coordinates.y))
    }
    
    func getConnectionColor(from locationID: UUID) -> Color {
        if self.locationIDArrivedFrom == locationID {
            return Color.Yonder.border
        }
        return ColorManipulation.adjustBrightness(of: Color.Yonder.border, amount: YonderCoreGraphics.unvisitedLocationBrightness)
    }
    
    func fadeIsActive() -> Bool {
        for id in self.locationConnection.previousLocationsIDs {
            if id == self.playerLocationID {
                return true
            }
        }
        return false
    }
}
