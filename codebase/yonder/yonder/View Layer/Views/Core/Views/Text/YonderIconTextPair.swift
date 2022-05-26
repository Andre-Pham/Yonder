//
//  YonderIconTextPair.swift
//  yonder
//
//  Created by Andre Pham on 18/4/2022.
//

import SwiftUI

struct YonderIconTextPair: View {
    let image: Image
    let text: String
    let size: YonderTextSize
    var color: Color = YonderColors.textMaxContrast
    var iconSize: YonderIconSize? = nil
    
    var body: some View {
        HStack {
            if let iconSize = self.iconSize {
                YonderIcon(image: self.image, sideLength: iconSize)
            } else {
                YonderIcon(image: self.image)
            }
            
            YonderText(text: self.text, size: self.size, color: self.color)
        }
    }
}

struct YonderIconTextPair_Previews: PreviewProvider {
    static var previews: some View {
        YonderIconTextPair(image: YonderImages.friendlyIcon, text: "Yonder", size: .buttonBody, color: .black)
    }
}
