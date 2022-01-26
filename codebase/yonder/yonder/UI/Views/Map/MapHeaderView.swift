//
//  MapHeaderView.swift
//  yonder
//
//  Created by Andre Pham on 26/1/2022.
//

import SwiftUI

struct MapHeaderView: View {
    @Binding var scaleIndex: Int
    let scales: [CGFloat]
    
    var body: some View {
        HStack(spacing: YonderCoreGraphics.padding) {
            Button {
                self.scaleIndex -= 1
            } label: {
                YonderSquareButtonLabel(text: "-")
            }
            .disabled(self.scaleIndex == 0)
            .opacity(self.scaleIndex == 0 ? 0.2 : 1)
            
            Button {
                self.scaleIndex += 1
            } label: {
                YonderSquareButtonLabel(text: "+")
            }
            .disabled(self.scaleIndex == self.scales.count-1)
            .opacity(self.scaleIndex == self.scales.count-1 ? 0.2 : 1)
            
            Spacer()
            
            Button {
                // Will expand with matchGeometryEffect to show legend
            } label: {
                YonderSquareButtonLabel(text: "i")
            }
        }
        .padding(.bottom, YonderCoreGraphics.padding)
        .padding(.horizontal, YonderCoreGraphics.padding)
    }
}
