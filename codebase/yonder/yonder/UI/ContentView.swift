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
        if showingMenu {
            ZStack {
                Color.Yonder.backgroundMaxDepth
                    .ignoresSafeArea()
                VStack(spacing: 12) {
                    Spacer()
                    
                    Text("Yonder")
                        .font(YonderFonts.main(size: 70))
                    
                    VStack(spacing: 30) {
                        Button {
                            // Game is already newly created every time app starts up
                            showingMenu.toggle()
                        } label: {
                            Text("New Game")
                                .frame(width: 200, height: 50)
                                .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
                                .font(YonderFonts.main(size: 24))
                        }
                        
                        Button {
                            // Find the game saved and resume it
                            showingMenu.toggle()
                        } label: {
                            Text("Resume Game")
                                .frame(width: 200, height: 50)
                                .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
                                .font(YonderFonts.main(size: 24))
                        }
                    }
                    .padding(40)
                    
                    Spacer()
                    Spacer()
                }
                .foregroundColor(.white)
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
