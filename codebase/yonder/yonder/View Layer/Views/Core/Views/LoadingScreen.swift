//
//  LoadingScreen.swift
//  yonder
//
//  Created by Andre Pham on 5/12/2022.
//

import SwiftUI

struct LoadingScreen: View {
    @State private var dotCount: Int = 0
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
                }
            }
        }
        .onAppear {
            self.transition()
        }
    }
    
    func transition() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.incrementDotCount()
            self.transition()
        }
    }
    
    func incrementDotCount() {
        self.dotCount = (self.dotCount + 1)%4
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}
