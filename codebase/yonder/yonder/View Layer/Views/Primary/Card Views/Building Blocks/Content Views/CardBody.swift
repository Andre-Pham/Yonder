//
//  CardBody.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import Foundation
import SwiftUI

struct CardBody<Content: View>: View {
    let name: String?
    let resizeToFit: Bool
    private let content: () -> Content
    private let spacing: CGFloat = 3
    private let topPadding: CGFloat = 16
    
    /// - Parameters:
    ///   - name: The text to appear at the top of the card to denote what the card is representing
    ///   - resizeToFit: Whether or not the expand to fill the available space below it (warning: if there isn't available space, spacing from the spacer still appears)
    ///   - builder: Code block to appear as content
    init(name: String? = nil, resizeToFit: Bool = true, @ViewBuilder builder: @escaping () -> Content) {
        self.name = name
        self.resizeToFit = resizeToFit
        self.content = builder
    }
    
    var body: some View {
        YonderBorder7 {
            VStack(alignment: .leading, spacing: self.spacing) {
                if let name {
                    YonderText(text: name, size: .cardTitle)
                        .padding(.top, self.topPadding)
                } else {
                    Rectangle()
                        .frame(height: .zero)
                        .padding(.top, self.topPadding - self.spacing)
                }
                
                content()
                
                if self.resizeToFit {
                    Spacer()
                }
            }
            .padding(.bottom)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
    }
}

#Preview {
    PreviewContentView {
        CardBody(name: "Name", resizeToFit: false) {
            YonderText(text: "Hello World", size: .cardBody)
        }
    }
}
