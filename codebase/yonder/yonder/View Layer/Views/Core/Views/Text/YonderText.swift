//
//  YonderText.swift
//  yonder
//
//  Created by Andre Pham on 16/4/2022.
//

import SwiftUI

struct YonderText: View {
    let text: String
    let size: YonderTextSize
    var color: Color = Color.Yonder.textMaxContrast
    var multilineTextAlignment: TextAlignment = .leading
    
    var body: some View {
        Text(self.text)
            .font(YonderFonts.main(size: self.size.value))
            .foregroundColor(self.color)
            .multilineTextAlignment(self.multilineTextAlignment)
            .fixedSize(horizontal: false, vertical: true) // Text wraps instead of being cut off
    }
}

struct YonderText_Previews: PreviewProvider {
    static var previews: some View {
        YonderText(text: "Hello World", size: .buttonBody, color: .black)
    }
}
