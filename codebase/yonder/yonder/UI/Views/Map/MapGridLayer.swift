//
//  MapGridLayer.swift
//  yonder
//
//  Created by Andre Pham on 7/2/2022.
//

import Foundation
import SwiftUI

struct MapGridLayer<Content: View>: View {
    @EnvironmentObject private var gridDimensions: GridDimensions
    let gridItems: [GridItem]
    
    @ViewBuilder let content: (Int) -> Content
    
    var body: some View {
        LazyVGrid(columns: self.gridItems, spacing: self.gridDimensions.spacing) {
            ForEach(0..<self.gridDimensions.hexagonCount, id: \.self) { index in
                ZStack {
                    content(index)
                }
            }
        }
    }
}
