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
        Array(repeating: .init(.flexible()), count: YonderGridConstants.optionsGridColumnCount)
    }
    
    var body: some View {
        LazyVGrid(columns: self.optionColumns, spacing: YonderCoreGraphics.padding) {
            content()
        }
    }
}

struct YonderOptionsGrid_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContentView {
            GeometryReader { geo in
                YonderOptionsGrid {
                    YonderGridOption(title: "Title1", geometry: geo, image: YonderIcons.missingIcon) { }
                    
                    YonderGridOption(title: "Title2", geometry: geo, image: YonderIcons.missingIcon) { }
                    
                    YonderGridOption(title: "Title3", geometry: geo, image: YonderIcons.missingIcon) { }
                    
                    YonderGridOption(title: "Title4", geometry: geo, image: YonderIcons.missingIcon) { }
                    
                    YonderGridOption(title: "Title5", geometry: geo, image: YonderIcons.missingIcon) { }
                }
                .padding(.horizontal)
            }
        }
    }
}
