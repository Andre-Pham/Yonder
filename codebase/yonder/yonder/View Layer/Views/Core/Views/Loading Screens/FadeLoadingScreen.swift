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
            
            FadeLoadingText(text: Strings("persistence.loading").local, size: .title1)
        }
    }
}

struct FadeLoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        FadeLoadingScreen()
    }
}
