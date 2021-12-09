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
            Button("Start Game") {
                showingMenu.toggle()
            }
            .buttonStyle(.borderedProminent)
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
