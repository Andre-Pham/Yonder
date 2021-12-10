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
                VStack(spacing: 0) {
                    LocationView(image: UIImages.majorInnImage)
                        .cornerRadius(UIConstants.CORNER_RADIUS)
                        .frame(width: .infinity, height: 180)
                        .padding(UIConstants.CELL_PADDING)
                        .padding(.top, -UIConstants.CELL_PADDING)
                    
                    HStack(spacing: UIConstants.CELL_PADDING) {
                        PlayerView()
                            .cornerRadius(UIConstants.CORNER_RADIUS)
                        EnemyView()
                            .cornerRadius(UIConstants.CORNER_RADIUS)
                    }
                    .padding(UIConstants.CELL_PADDING)
                    .padding(.top, -UIConstants.CELL_PADDING)
                    .frame(width: .infinity, height: geo.size.width/2 - UIConstants.CELL_PADDING*1.5)
                    
                    LazyVGrid(columns: optionColumns, spacing: UIConstants.CELL_PADDING) {
                        ForEach(0..<100) { _ in
                            EngageOptionView()
                                .frame(width: geo.size.width/3 - UIConstants.CELL_PADDING*4/3, height: geo.size.width/3 - UIConstants.CELL_PADDING*2)
                                .cornerRadius(UIConstants.CORNER_RADIUS)
                        }
                    }
                    .padding(UIConstants.CELL_PADDING)
                    .padding(.top, -UIConstants.CELL_PADDING)
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
