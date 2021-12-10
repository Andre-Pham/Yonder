//
//  OptionsView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct OptionsView: View {
    let optionColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        GeometryReader { geo in
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: YonderCoreGraphics.padding) {
                    LocationView(image: YonderImages.majorInnImage)
                        .cornerRadius(YonderCoreGraphics.cornerRadius)
                        .frame(width: .infinity, height: 180)
                        .padding(YonderCoreGraphics.padding)
                        .background(Color.Yonder.backgroundMidDepth)
                    
                    HStack(spacing: YonderCoreGraphics.padding) {
                        PlayerView()
                            .cornerRadius(YonderCoreGraphics.cornerRadius)
                        EnemyView()
                            .cornerRadius(YonderCoreGraphics.cornerRadius)
                    }
                    .padding(YonderCoreGraphics.padding)
                    .frame(width: .infinity, height: geo.size.width/2 - YonderCoreGraphics.padding*1.5)
                    .background(Color.Yonder.backgroundMidDepth)
                    
                    LazyVGrid(columns: optionColumns, spacing: YonderCoreGraphics.padding) {
                        ForEach(0..<100) { _ in
                            EngageOptionView()
                                .frame(width: geo.size.width/3 - YonderCoreGraphics.padding*4/3, height: geo.size.width/3 - YonderCoreGraphics.padding*2)
                                .cornerRadius(YonderCoreGraphics.cornerRadius)
                        }
                    }
                    .padding(YonderCoreGraphics.padding)
                    .background(Color.Yonder.backgroundMidDepth)
                }
            }
            Color.Yonder.backgroundMaxDepth
                .frame(
                    width: geo.size.width,
                    height: geo.safeAreaInsets.top,
                    alignment: .top)
                .ignoresSafeArea()
        }
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView()
    }
}
