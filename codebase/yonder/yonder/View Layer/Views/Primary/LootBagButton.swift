//
//  LootBagButton.swift
//  yonder
//
//  Created by Andre Pham on 17/7/2022.
//

import SwiftUI

struct LootBagButton: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var lootOptionsViewModel: LootOptionsViewModel
    @ObservedObject var lootBagViewModel: LootBagViewModel
    @State private var expanded = false
    
    var body: some View {
        YonderBorder4 {
            HStack {
                VStack(alignment: .leading) {
                    YonderText(text: self.lootBagViewModel.name, size: .buttonBody)
                        .padding(.bottom, YonderCoreGraphics.buttonTitleSpacing)

                    YonderText(text: self.lootBagViewModel.description, size: .buttonBodySubscript)
                }
                
                Spacer()
                
                Button {
                    self.lootOptionsViewModel.take(
                        self.lootBagViewModel,
                        playerViewModel: self.playerViewModel
                    )
                } label: {
                    YonderBorder5 {
                        YonderIcon(
                            image: YonderIcons.selectLootBagIcon,
                            sideLength: .large
                        )
                        .padding(10)
                    }
                }
            }
            .padding(YonderCoreGraphics.innerPadding)
            .frame(maxWidth: .infinity)
        }
    }
}

struct LootBagButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            LootBagButton(playerViewModel: PreviewObjects.playerViewModel, lootOptionsViewModel: PreviewObjects.lootOptionsViewModel, lootBagViewModel: PreviewObjects.lootBagViewModel)
        }
    }
}
