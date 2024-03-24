//
//  StartingCardView.swift
//  yonder
//
//  Created by Andre Pham on 24/3/2024.
//

import Foundation
import SwiftUI

struct StartingCardView: View {
    private let introText = Strings("card.starting.intro").local
    // Use "0" as a placeholder for the icon (used below)
    private let actionText = Strings("card.starting.callToAction1Param").localWithArgs(0)
    
    var body: some View {
        CardBody {
            YonderText(text: introText, size: .cardSubscript)
                .padding(.bottom, 6)
            
            WrappingHStack(verticalSpacing: 0) {
                ForEach(self.actionText.components(separatedBy: " "), id: \.self) { word in
                    if word == "0" {
                        YonderIcon(image: YonderIcons.mapIcon, sideLength: .inspectSheet)
                            .padding(.top, 2)
                    } else {
                        YonderText(text: word, size: .cardSubscript)
                    }
                }
            }
        }
    }
}

#Preview {
    PreviewContentView {
        StartingCardView()
    }
}
