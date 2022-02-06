//
//  MapGridLayer.swift
//  yonder
//
//  Created by Andre Pham on 7/2/2022.
//

import Foundation
import SwiftUI

struct MapGridLayer<Content: View>: View {
    @EnvironmentObject var gridDimensions: GridDimensions
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

// Keeping this later for reference
/*struct YonderButton<Content: View>: View {
    private let content: () -> Content
    
    init(@ViewBuilder builder: @escaping () -> Content) {
        self.content = builder
    }
    
    var body: some View {
        VStack {
            content()
        }
    }
}*/
