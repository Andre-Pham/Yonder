//
//  CardBody.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import Foundation
import SwiftUI

struct CardBody<Content: View>: View {
    let name: String
    let resizeToFit: Bool
    private let content: () -> Content
    
    /// - Parameters:
    ///   - name: The text to appear at the top of the card to denote what the card is representing
    ///   - resizeToFit: Whether or not the expand to fill the available space below it (warning: if there isn't available space, spacing from the spacer still appears)
    ///   - builder: Code block to appear as content.
    init(name: String, resizeToFit: Bool = true, @ViewBuilder builder: @escaping () -> Content) {
        self.name = name
        self.resizeToFit = resizeToFit
        self.content = builder
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            YonderText(text: self.name, size: .cardTitle)
                .padding(.top)
            
            content()
            
            if self.resizeToFit {
                Spacer()
            }
        }
        .padding(.bottom)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)
        .padding(.trailing)
        .foregroundColor(.Yonder.textMaxContrast)
        .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
    }
}
