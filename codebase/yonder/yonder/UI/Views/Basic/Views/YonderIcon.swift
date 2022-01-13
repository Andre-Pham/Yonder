//
//  YonderIcon.swift
//  yonder
//
//  Created by Andre Pham on 14/1/2022.
//

import Foundation
import SwiftUI

struct YonderIcon: View {
    let image: Image
    let sideLength: CGFloat = 24
    
    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: self.sideLength, height: self.sideLength)
    }
}
