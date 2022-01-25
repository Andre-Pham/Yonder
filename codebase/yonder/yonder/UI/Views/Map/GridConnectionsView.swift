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
    let locationArrivedFrom: LocationAbstract?
    
    var body: some View {
        let previousCoordinates = self.locationConnection.previousLocationsHexagonCoordinates
        ForEach(Array(zip(previousCoordinates.indices, previousCoordinates)), id: \.0) { index, coords in
            let values = self.getCoordinatesDifference(from: self.locationConnection.locationHexagonCoordinate, to: coords)
            
            GridConnectionView(down: values.1,
                               downAcross: values.0,
                               spacing: self.gridDimensions.spacing,
                               horizontalOffset: self.gridDimensions.getHorizontalOffset(hexagonIndex: self.hexagonIndex),
                               color: self.getConnectionColor(from: self.locationConnection.previousLocations[index]))
        }
    }
    
    func getCoordinatesDifference(from coordinates: HexagonCoordinate, to otherCoordinates: HexagonCoordinate) -> (Int, Int) {
        return (otherCoordinates.x - coordinates.x, abs(otherCoordinates.y - coordinates.y))
    }
    
    func getConnectionColor(from location: LocationAbstract) -> Color {
        if let locationArrivedFrom = self.locationArrivedFrom {
            if locationArrivedFrom.id == location.id {
                return Color.Yonder.border
            }
        }
        return .red
    }
}
