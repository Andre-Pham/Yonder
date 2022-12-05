//
//  DotsLoadingScreen.swift
//  yonder
//
//  Created by Andre Pham on 5/12/2022.
//

import SwiftUI

struct DotsLoadingScreen: View {
    @State private var dotCount: Int = 0
    // Other timer implementations repeat forever even after view destruction
    let timer = SwiftUI.Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    var dots: String {
        String(repeating: ".", count: self.dotCount)
    }
    
    var body: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    YonderText(text: Strings("loading").local, size: .title2)
                    
                    YonderText(text: self.dots, size: .title2)
                        .onReceive(self.timer) { _ in
                            self.incrementDotCount()
                        }
                }
            }
        }
    }
    
    func incrementDotCount() {
        self.dotCount = (self.dotCount + 1)%4
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        DotsLoadingScreen()
    }
}
