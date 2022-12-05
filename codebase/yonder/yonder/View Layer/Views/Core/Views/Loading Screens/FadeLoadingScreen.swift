//
//  FadeLoadingScreen.swift
//  yonder
//
//  Created by Andre Pham on 5/12/2022.
//

import SwiftUI

struct FadeLoadingScreen: View {
    var body: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            YonderText(text: Strings("loading").local, size: .title1)
                .repeatFadingAnimation(duration: 0.5)
        }
    }
}

struct FadeLoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        FadeLoadingScreen()
    }
}
