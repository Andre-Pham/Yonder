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
                
                YonderText(text: "Yonder", size: .title1)
                
                VStack(spacing: 30) {
                    YonderButton(text: "New Game") {
                        // Game is already newly created every time app starts up
                        self.showingMenu.toggle()
                    }
                    
                    YonderButton(text: "Resume Game") {
                        // Find the game saved and resume it
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
