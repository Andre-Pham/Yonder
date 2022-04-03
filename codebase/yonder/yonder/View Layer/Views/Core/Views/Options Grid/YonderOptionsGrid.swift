//
//  YonderOptionsGrid.swift
//  yonder
//
//  Created by Andre Pham on 3/4/2022.
//

import SwiftUI

struct YonderOptionsGrid<Content: View>: View {
    private let content: () -> Content
    
    init(@ViewBuilder builder: @escaping () -> Content) {
        self.content = builder
    }
    
    var optionColumns: [GridItem] {
        Array(repeating: .init(.flexible()), count: LayoutConstants.optionsGridColumnCount)
    }
    
    var body: some View {
        LazyVGrid(columns: self.optionColumns, spacing: YonderCoreGraphics.padding) {
            content()
        }
    }
}
