//
//  YonderIcon.swift
//  yonder
//
//  Created by Andre Pham on 14/1/2022.
//

import Foundation
import SwiftUI

enum YonderIconSize: CGFloat {
    case large = 34
    case standard = 24
    case inspectSheet = 18
    case cardSubscript = 14
}

struct YonderIcon: View {
    let image: Image
    var sideLength: YonderIconSize = .standard
    
    var body: some View {
        self.image
            .resizable()
            .scaledToFill()
            .frame(width: self.sideLength.rawValue, height: self.sideLength.rawValue)
    }
}

struct YonderIcon_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContentView {
            HStack {
                YonderIcon(image: YonderIcons.hostileIcon, sideLength: .large)
                
                YonderIcon(image: YonderIcons.healthIcon, sideLength: .large)
            }
        }
    }
}
