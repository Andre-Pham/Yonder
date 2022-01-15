//
//  GridConnectionsView.swift
//  yonder
//
//  Created by Andre Pham on 16/1/2022.
//

import SwiftUI

struct GridConnectionsView: View {
    let locationConnection: LocationConnection
    let spacing: CGFloat
    let horizontalOffset: CGFloat
    
    var body: some View {
        ForEach(self.locationConnection.previousLocationsHexagonCoordinates) { coords in
            let values = self.getCoordinatesDifference(from: locationConnection.locationHexagonCoordinate, to: coords)
            
            GridConnectionView(down: values.1, downAcross: values.0, spacing: self.spacing, horizontalOffset: horizontalOffset)
        }
    }
    
    func getCoordinatesDifference(from coordinates: HexagonCoordinate, to otherCoordinates: HexagonCoordinate) -> (Int, Int) {
        return (otherCoordinates.x - coordinates.x, abs(otherCoordinates.y - coordinates.y))
    }
}
