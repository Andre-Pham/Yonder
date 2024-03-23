//
//  yonderApp.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import SwiftUI

@main
struct yonderApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onChange(of: self.scenePhase) { _, newState in
                    Session.instance.onAppStateChange(to: newState)
                }
        }
    }
}
