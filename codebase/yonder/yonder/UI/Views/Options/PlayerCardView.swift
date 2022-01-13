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
            YonderText(text: "You", size: .cardTitle)
                .padding(.top)
                .padding(.leading)
                .padding(.trailing)
            
            PlayerCardColumnView(
                value: "\(playerViewModel.armorPoints)",
                maxValue: "/\(playerViewModel.maxArmorPoints)",
                image: YonderImages.shieldIcon)
            
            PlayerCardColumnView(
                value: "\(playerViewModel.health)",
                maxValue: "/\(playerViewModel.maxHealth)",
                image: YonderImages.healthIcon)
            
            PlayerCardColumnView(
                value: "$\(playerViewModel.gold)",
                image: YonderImages.goldIcon)
            
            Spacer()
        }
        .foregroundColor(.Yonder.textMaxContrast)
        .background(Color.Yonder.backgroundMaxDepth)
    }
}

struct PlayerCardColumnView: View {
    var value: String
    var maxValue: String = ""
    var image: Image? = nil
    
    var body: some View {
        HStack {
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 26.4, height: 24)
            }
            
            if maxValue.count > 0 {
                HStack(alignment: .lastTextBaseline) {
                    YonderText(text: value, size: .cardBody)
                    
                    Spacer()
                    
                    YonderText(text: maxValue, size: .cardSubscript)
                }
            }
            else {
                YonderText(text: value, size: .cardBody)
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
