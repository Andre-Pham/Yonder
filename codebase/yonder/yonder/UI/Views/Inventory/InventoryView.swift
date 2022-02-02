//
//  InventoryView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct InventoryView: View {
    @StateObject private var playerViewModel = PlayerViewModel(GAME.player)
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(spacing: YonderCoreGraphics.padding) {
                    ForEach(playerViewModel.weaponViewModels, id: \.id) { weaponViewModel in
                        YonderRectButtonLabel(text: weaponViewModel.name)
                    }
                }
            }
        }
    }
}

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryView()
    }
}
