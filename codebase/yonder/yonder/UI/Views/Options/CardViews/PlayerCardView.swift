//
//  PlayerCardView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct PlayerCardView: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    @State private var showingPlayerSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            YonderText(text: Term.player.capitalized, size: .cardTitle)
                .padding(.top)
                .padding(.leading)
                .padding(.trailing)
            
            PlayerCardRowView(
                value: "\(self.playerViewModel.armorPoints)",
                maxValue: "\(self.playerViewModel.maxArmorPoints)",
                image: YonderImages.shieldIcon)
            
            PlayerCardRowView(
                value: "\(self.playerViewModel.health)",
                maxValue: "\(self.playerViewModel.maxHealth)",
                image: YonderImages.healthIcon)
            
            PlayerCardRowView(
                value: "\(Term.currencySymbol)\(self.playerViewModel.gold)",
                image: YonderImages.goldIcon)
            
            Spacer()
        }
        .foregroundColor(.Yonder.textMaxContrast)
        .background(Color.Yonder.backgroundMaxDepth)
        .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
    }
}

struct PlayerCardRowView: View {
    var value: String
    var maxValue: String = ""
    var image: Image? = nil
    
    var body: some View {
        HStack {
            if let image = self.image {
                YonderIcon(image: image)
            }
            
            if self.maxValue.count > 0 {
                HStack(alignment: .lastTextBaseline) {
                    YonderText(text: self.value, size: .cardBody)
                    
                    Spacer()
                    
                    YonderText(text: "/\(self.maxValue)", size: .cardSubscript)
                }
            }
            else {
                YonderText(text: self.value, size: .cardBody)
            }
        }
        .padding(.leading)
        .padding(.trailing)
    }
}

struct PlayerCardView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerCardView(playerViewModel: PlayerViewModel(Player(maxHealth: 200, location: NoLocation())))
    }
}
