//
//  BorderSlice.swift
//  yonder
//
//  Created by Andre Pham on 18/1/2024.
//

import SwiftUI

struct BorderSlice: View {
    let source: YonderImage
    let scale: Double
    var widthOverride: CGFloat? = nil
    var heightOverride: CGFloat? = nil
    
    var body: some View {
        self.source.image
            .resizable()
            .interpolation(.none)
            .frame(
                // Sometimes a negative value is passed in
                // The content size is (0, 0) before the view is rendered, and if there's corner insets, this becomes negative until the view is rendered
                // If a negative width/height is passed in, just render a length of 0
                width: max(self.widthOverride ?? self.source.width*self.scale, 0.0),
                height: max(self.heightOverride ?? self.source.height*self.scale, 0.0)
            )
    }
}

#Preview {
    PreviewContentView {
        BorderSlice(source: YonderImages.bruteIcon, scale: 1.0)
    }
}
