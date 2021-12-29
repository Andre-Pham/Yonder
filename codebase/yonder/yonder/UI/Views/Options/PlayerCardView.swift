//
//  PlayerCardView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct PlayerCardView: View {
    @ObservedObject var player: PlayerPresenter
    @State private var showingPlayerSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            YonderText(text: "You", size: .cardTitle)
                .padding(.top)
                .padding(.leading)
                .padding(.trailing)
            
            PlayerCardColumnView(value: "\(player.armorPoints)", maxValue: "/\(player.maxArmorPoints)")
            
            PlayerCardColumnView(value: "\(player.health)", maxValue: "/\(player.maxHealth)")
            
            PlayerCardColumnView(value: "$\(player.gold)")
            
            Spacer()
        }
        .foregroundColor(.Yonder.textMaxContrast)
        .background(Color.Yonder.backgroundMaxDepth)
    }
}

struct PlayerCardColumnView: View {
    var value: String
    var maxValue: String = ""
    
    var body: some View {
        if maxValue.count > 0 {
            HStack {
                YonderText(text: value, size: .cardBody)
                
                Spacer()
                
                YonderText(text: maxValue, size: .cardSubscript)
            }
            .padding(.leading)
            .padding(.trailing)
        }
        else {
            YonderText(text: value, size: .cardBody)
                .padding(.leading)
        }
    }
}

struct PlayerComponent_Previews: PreviewProvider {
    static var previews: some View {
        PlayerCardView(player: PlayerPresenter(Player(maxHealth: 200, location: NoLocation())))
    }
}
