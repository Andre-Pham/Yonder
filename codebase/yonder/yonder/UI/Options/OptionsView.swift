//
//  OptionsView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct OptionsView: View {
    let optionColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                
                HStack(spacing: UIConstants.CELL_PADDING) {
                    PlayerView()
                    EnemyView()
                }
                .padding(UIConstants.CELL_PADDING)
                .frame(width: .infinity, height: geo.size.width/2 - UIConstants.CELL_PADDING*1.5)
                
                ScrollView {
                    LazyVGrid(columns: optionColumns) {
                        ForEach(0..<100) { _ in
                            EngageOptionView()
                        }
                    }
                }
                .padding(.top, 0)
                
            }
        }
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView()
    }
}
