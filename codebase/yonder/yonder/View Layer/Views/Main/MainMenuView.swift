//
//  MainMenuView.swift
//  yonder
//
//  Created by Andre Pham on 21/1/2022.
//

import Foundation
import SwiftUI

struct MainMenuView: View {
    @Binding var showingMenu: Bool
    
    var body: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                Spacer()
                
                YonderText(text: Strings("gameName").local, size: .title1)
                
                VStack(spacing: 30) {
                    YonderButton(text: Strings("mainMenu.newGame").local) {
                        Session.instance.startNewGame()
                        self.showingMenu.toggle()
                    }
                    
                    YonderButton(text: Strings("mainMenu.resumeGame").local) {
                        Session.instance.loadGame()
                        self.showingMenu.toggle()
                    }
                }
                .padding(40)
                
                Spacer()
                Spacer()
            }
            .foregroundColor(YonderColors.textMaxContrast)
        }
    }
    
}
