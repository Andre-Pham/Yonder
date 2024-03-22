//
//  PreviewLandmark.swift
//  yonder
//
//  Created by Andre Pham on 22/3/2024.
//

import Foundation
import SwiftUI

/// This file is not part of the game.
/// It's purely to preview different landmark assets.
/// Want to preview the landmark with the content ID L0001? Easy.
/// Just set the fileID and defaultAnimation below.

fileprivate struct PreviewLandmark: View {
    @StateObject var animation = AnimationQueue<LandmarkSequenceCode>(
        fileID: "L0001",
        defaultAnimation: .idle
    )
    
    var body: some View {
        self.animation.frame
            .resizable()
            .interpolation(.none)
            .scaledToFit()
            .frame(
                width: 3.0*self.animation.frameSize.width,
                height: 3.0*self.animation.frameSize.height
            )
    }
}

#Preview {
    PreviewContentView {
        PreviewLandmark()
    }
}
