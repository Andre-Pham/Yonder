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
                YonderText(text: "↑", size: .title2)
                    .padding(.top, 4)
                
                YonderIcon(image: YonderIcons.warpIcon)
                    .padding(.vertical, YonderCoreGraphics.padding)
                
                YonderText(text: "↑", size: .title2)
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
                area1ViewModel: AreaViewModel(areaContent: getAreaContent1()),
                area2ViewModel: AreaViewModel(areaContent: getAreaContent2()))
        }
    }
    
    static func getAreaContent1() -> LocationContext {
        let content = LocationContext()
        content.setContext(name: "Australia", description: "Hot.", imageName: YonderIcons.placeholderImage.name)
        return content
    }
    
    static func getAreaContent2() -> LocationContext {
        let content = LocationContext()
        content.setContext(name: "Canada", description: "Cold.", imageName: YonderIcons.placeholderImage.name)
        return content
    }
}
