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
                        .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
                        .frame(width: .infinity, height: 180)
                        .padding(.leading, YonderCoreGraphics.padding)
                        .padding(.trailing, YonderCoreGraphics.padding)
                    
                    HStack(spacing: YonderCoreGraphics.padding) {
                        PlayerView()
                            .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
                        
                        EnemyView()
                            .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
                    }
                    .padding(.leading, YonderCoreGraphics.padding)
                    .padding(.trailing, YonderCoreGraphics.padding)
                    .frame(width: .infinity, height: geo.size.width/2 - YonderCoreGraphics.padding*1.5)
                    
                    Text("[Your Options]")
                        .foregroundColor(Color.Yonder.textMaxContrast)
                        .font(YonderFonts.main(size: 20))
                    
                    LazyVGrid(columns: optionColumns, spacing: YonderCoreGraphics.padding) {
                        ForEach(0..<100) { _ in
                            EngageOptionView()
                                .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
                                .frame(width: geo.size.width/3 - YonderCoreGraphics.padding*4/3, height: geo.size.width/3 - YonderCoreGraphics.padding*2)
                        }
                    }
                    .padding(.leading, YonderCoreGraphics.padding)
                    .padding(.trailing, YonderCoreGraphics.padding)
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
