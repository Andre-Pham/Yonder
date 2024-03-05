//
//  InspectTagView.swift
//  yonder
//
//  Created by Andre Pham on 5/3/2024.
//

import Foundation
import SwiftUI

struct InspectTagView: View {
    let tag: String
    
    var body: some View {
        HStack {
            YonderText(text: self.tag.uppercased(), size: .inspectSheetTag)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(YonderColors.tag)
        }
    }
}
