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
    let locationIDArrivedFrom: UUID
    
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
        }
    }
    
    func getCoordinatesDifference(from coordinates: HexagonCoordinate, to otherCoordinates: HexagonCoordinate) -> (Int, Int) {
        return (otherCoordinates.x - coordinates.x, abs(otherCoordinates.y - coordinates.y))
    }
    
    func getConnectionColor(from locationID: UUID) -> Color {
        if self.locationIDArrivedFrom == locationID {
            return Color.Yonder.border
        }
        return Color(UIColor(Color.Yonder.border).adjust(by: YonderCoreGraphics.visitedLocationBrightness) ?? .red)
    }
}
