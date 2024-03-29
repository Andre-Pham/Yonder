//
//  MainView.swift
//  yonder
//
//  Created by Andre Pham on 21/1/2022.
//

import SwiftUI

struct MainView: View {
    // Any object shared between tab views should be defined here
    @StateObject private var viewRouter = ViewRouter()
    @StateObject private var travelStateManager = TravelStateManager()
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                YonderColors.backgroundMaxDepth
                    .ignoresSafeArea()
                
                TabBarView()
                    .environmentObject(self.viewRouter)
                    .environmentObject(self.travelStateManager)
                
                // Top black bar so content isn't shown around the notch
                VStack {
                    YonderColors.backgroundMaxDepth
                        .frame(
                            width: geo.size.width,
                            height: geo.safeAreaInsets.top,
                            alignment: .top
                        )
                        .ignoresSafeArea()
                    
                    Spacer()
                }
                
                GameOverView()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
