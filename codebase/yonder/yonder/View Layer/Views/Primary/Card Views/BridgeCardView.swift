//
//  BridgeCardView.swift
//  yonder
//
//  Created by Andre Pham on 14/5/2022.
//

import SwiftUI

struct BridgeCardView: View {
    let area1ViewModel: AreaViewModel
    let area2ViewModel: AreaViewModel
    
    var body: some View {
        CenterCardBody {
            YonderText(text: self.area1ViewModel.name, size: .cardSubscript, multilineTextAlignment: .center)
            
            HStack(alignment: .center) {
                YonderText(text: "↑", size: .title3)
                    .padding(.top, 4)
                
                YonderIcon(image: YonderIcons.warpIcon)
                    .padding(.vertical, YonderCoreGraphics.padding)
                
                YonderText(text: "↑", size: .title3)
                    .padding(.top, 4)
                    .scaleEffect(CGSize(width: -1, height: -1))
            }
                
            YonderText(text: self.area2ViewModel.name, size: .cardSubscript, multilineTextAlignment: .center)
        }
    }
}

struct BridgeCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            BridgeCardView(
                area1ViewModel: AreaViewModel(locationContext: getContext1()),
                area2ViewModel: AreaViewModel(locationContext: getContext2()))
        }
    }
    
    static func getContext1() -> LocationContext {
        let content = LocationContext()
        content.setContext(key: "", name: "Australia", description: "Hot.", imageResource: YonderImages.placeholderImage)
        return content
    }
    
    static func getContext2() -> LocationContext {
        let content = LocationContext()
        content.setContext(key: "", name: "Canada", description: "Cold.", imageResource: YonderImages.placeholderImage)
        return content
    }
}
