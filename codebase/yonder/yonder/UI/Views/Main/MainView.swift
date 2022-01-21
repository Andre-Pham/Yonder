//
//  MainView.swift
//  yonder
//
//  Created by Andre Pham on 21/1/2022.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewRouter = ViewRouter()
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.Yonder.backgroundMaxDepth
                    .ignoresSafeArea()
                
                TabBarView(viewRounter: self.viewRouter)
                
                VStack {
                    Color.Yonder.backgroundMaxDepth
                        .frame(
                            width: geo.size.width,
                            height: geo.safeAreaInsets.top,
                            alignment: .top)
                        .ignoresSafeArea()
                    
                    Spacer()
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
