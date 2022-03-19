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
        Group {
            if self.showingMenu {
                MainMenuView(showingMenu: self.$showingMenu)
            }
            else {
                MainView()
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
