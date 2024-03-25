//
//  DotsLoadingScreen.swift
//  yonder
//
//  Created by Andre Pham on 5/12/2022.
//

import SwiftUI

struct DotsLoadingScreen: View {
    var body: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            DotsLoadingText(
                text: Strings("persistence.loading").local,
                size: .title2
            )
        }
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        DotsLoadingScreen()
    }
}
