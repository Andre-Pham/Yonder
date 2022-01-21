//
//  TabBarIconView.swift
//  yonder
//
//  Created by Andre Pham on 21/1/2022.
//

import Foundation
import SwiftUI

struct TabBarIconView: View {
    @ObservedObject var viewRounter: ViewRouter
    let correspondingPage: Page
    
    let icon: YonderIcon
    let text: String
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                self.icon
                    .padding(.top, 30)
                    .grayscale(self.viewRounter.currentPage == self.correspondingPage ? 0 : 1)
                
                YonderText(text: self.text, size: .tabBar)
                
                Spacer()
            }
            .onTapGesture {
                self.viewRounter.currentPage = self.correspondingPage
            }
            
            Spacer()
        }
    }
    
}
