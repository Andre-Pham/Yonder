//
//  Preview.swift
//  yonder
//
//  Created by Andre Pham on 7/3/2024.
//

import Foundation
import SwiftUI

/// This file is not part of the game.
/// It's purely to preview different NPC assets.
/// Want to preview the npc with the content ID E0006 while attacking? Easy.
/// Just set the fileID and defaultAnimation below.

fileprivate struct PreviewNPC: View {
    @StateObject var animation = AnimationQueue(
        fileID: "E0006",
        defaultAnimation: .breathing
    )
    
    var body: some View {
        self.animation.frame
            .resizable()
            .interpolation(.none)
            .scaledToFit()
            .frame(height: 4.0*self.animation.frameSize.height)
            .border(.gray)
    }
}

#Preview {
    PreviewContentView {
        PreviewNPC()
    }
}
