//
//  GridSpacerView.swift
//  yonder
//
//  Created by Andre Pham on 27/1/2022.
//

import SwiftUI

struct GridSpacerView: View {
    @EnvironmentObject private var gridDimensions: GridDimensions
    
    var body: some View {
        Spacer()
            .frame(width: self.gridDimensions.getGridHexagonFrameWidth(),
                   height: self.gridDimensions.getGridHexagonFrameHeight())
    }
}
