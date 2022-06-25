//
//  TabBarIconView.swift
//  yonder
//
//  Created by Andre Pham on 21/1/2022.
//

import Foundation
import SwiftUI

struct TabBarIconView: View {
    @ObservedObject var viewRouter: ViewRouter
    let correspondingPage: ViewRouter.Page
    
    let icon: YonderIcon
    let text: String
    
    var body: some View {
        HStack {
            Spacer()
            
            ZStack {
                VStack {
                    self.icon
                        .padding(.top, 24)
                    
                    YonderText(text: self.text, size: .tabBar)
                    
                    Spacer()
                }
                .onTapGesture {
                    self.viewRouter.switchPage(to: self.correspondingPage)
                }
                
                if self.viewRouter.currentPage == self.correspondingPage {
                    VStack {
                        HStack(spacing: 32) {
                            YonderText(text: "]", size: .tabBarIconCapsule)
                                // "]" and "[" have different padding
                                .scaleEffect(CGSize(width: -1, height: 1))
                            
                            YonderText(text: "]", size: .tabBarIconCapsule)
                        }
                        .padding(.top, 21)
                        
                        Spacer()
                    }
                }
            }
            
            Spacer()
        }
    }
    
}

struct TabBarIconView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            
            TabBarIconView(viewRouter: ViewRouter(), correspondingPage: .options, icon: YonderIcon(image: YonderImages.settingsIcon), text: "Settings")
        }
    }
}
