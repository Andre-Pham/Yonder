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
                width: self.widthOverride ?? self.source.width*self.scale,
                height: self.heightOverride ?? self.source.height*self.scale
            )
    }
}

#Preview {
    PreviewContentView {
        BorderSlice(source: YonderImages.bruteIcon, scale: 1.0)
    }
}
