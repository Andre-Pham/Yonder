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
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                Spacer()
                
                YonderText(text: "Yonder", size: .title1)
                
                VStack(spacing: 30) {
                    Button {
                        // Game is already newly created every time app starts up
                        self.showingMenu.toggle()
                    } label: {
                        YonderRectButtonLabel(text: "New Game")
                    }
                    
                    Button {
                        // Find the game saved and resume it
                        self.showingMenu.toggle()
                    } label: {
                        YonderRectButtonLabel(text: "Resume Game")
                    }
                }
                .padding(40)
                
                Spacer()
                Spacer()
            }
            .foregroundColor(.Yonder.textMaxContrast)
        }
    }
    
}
