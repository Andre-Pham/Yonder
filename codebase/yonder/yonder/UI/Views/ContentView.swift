//
//  ContentView.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingMenu = true
    
    var body: some View {
        if self.showingMenu {
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
        else {
            GameView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
