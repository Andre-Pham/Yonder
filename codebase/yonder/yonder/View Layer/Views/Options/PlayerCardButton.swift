//
//  PlayerCardButton.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import SwiftUI

struct PlayerCardButton: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var optionsSheetsStateManager: OptionsSheetsStateManager
    let pageGeometry: GeometryProxy
    
    var body: some View {
        Button {
            self.optionsSheetsStateManager.playerSheetBinding = true
        } label: {
            PlayerCardView(playerViewModel: self.playerViewModel)
        }
        .withInspectSheet(isPresented: self.$optionsSheetsStateManager.playerSheetBinding, pageGeometry: self.pageGeometry, content: AnyView(
            PlayerInspectView(playerViewModel: self.playerViewModel)
        ))
    }
}

struct PlayerCardButton_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            ZStack {
                YonderColors.backgroundMaxDepth
                    .ignoresSafeArea()
                
                PlayerCardButton(playerViewModel: PreviewObjects.playerViewModel(), optionsSheetsStateManager: OptionsSheetsStateManager(), pageGeometry: geo)
            }
        }
    }
}
