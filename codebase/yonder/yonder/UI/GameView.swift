//
//  GameView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct GameView: View {
    @State private var selection = 0
    
    init() {
        UITabBar.appearance().backgroundColor = .blue
        UITabBar.appearance().unselectedItemTintColor = .gray
    }
    
    var body: some View {
        TabView(selection: $selection) {
            OptionsView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
         
            InventoryView()
                .tabItem {
                    Image(systemName: "bookmark.circle.fill")
                    Text("Bookmark")
                }
                .tag(1)
         
            MapView()
                .tabItem {
                    Image(systemName: "video.circle.fill")
                        .foregroundColor(.red)
                        .background(.red)
                    Text("Video")
                }
                .tag(2)
         
            SettingsView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
                .tag(3)
        }
        .accentColor(.white)
        .tint(.red)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
