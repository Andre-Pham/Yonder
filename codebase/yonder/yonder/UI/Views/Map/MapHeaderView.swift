//
//  MapHeaderView.swift
//  yonder
//
//  Created by Andre Pham on 26/1/2022.
//

import SwiftUI

struct MapHeaderView: View {
    @ObservedObject var scaleStateManager: ScaleStateManager
    
    var body: some View {
        HStack(spacing: YonderCoreGraphics.padding) {
            Button {
                self.scaleStateManager.adjustScaleIndex(by: -1)
            } label: {
                YonderSquareButtonLabel(text: "-")
            }
            .disabled(self.scaleStateManager.scaleIsMin)
            .opacity(self.scaleStateManager.scaleIsMin ? YonderCoreGraphics.disabledButtonOpacity : 1)
            
            Button {
                self.scaleStateManager.adjustScaleIndex(by: 1)
            } label: {
                YonderSquareButtonLabel(text: "+")
            }
            .disabled(self.scaleStateManager.scaleIsMax)
            .opacity(self.scaleStateManager.scaleIsMax ? YonderCoreGraphics.disabledButtonOpacity : 1)
            
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
