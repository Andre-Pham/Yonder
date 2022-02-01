//
//  MapHeaderView.swift
//  yonder
//
//  Created by Andre Pham on 26/1/2022.
//

import SwiftUI

struct MapHeaderView: View {
    @ObservedObject var scaleStateManager: ScaleStateManager
    @EnvironmentObject private var travelStateManager: TravelStateManager
    
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
            
            Button {
                self.travelStateManager.toggleTravellingActiveState()
            } label: {
                YonderWideButtonLabel(text: self.travelStateManager.travellingActive ? "Done" : "Travel")
            }
            .disabled(self.travelStateManager.toggleTravellingActiveStateDisabled())
            .opacity(self.travelStateManager.toggleTravellingActiveStateDisabled() ? YonderCoreGraphics.disabledButtonOpacity : 1)
            
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
