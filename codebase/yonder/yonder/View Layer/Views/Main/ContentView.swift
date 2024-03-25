//
//  ContentView.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appState = AppStateManager()
    
    var body: some View {
        Group {
            if self.appState.menuShowing {
                MainMenuView()
                    .environmentObject(self.appState)
            } else {
                MainView()
                    .environmentObject(self.appState)
            }
        }
        .statusBar(hidden: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
