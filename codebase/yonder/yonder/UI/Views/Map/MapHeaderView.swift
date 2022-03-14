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
            YonderSquareButton(text: "-") {
                self.scaleStateManager.adjustScaleIndex(by: -1)
            }
            .disabled(self.scaleStateManager.scaleIsMin)
            .opacity(self.scaleStateManager.scaleIsMin ? YonderCoreGraphics.disabledButtonOpacity : 1)
            
            YonderSquareButton(text: "+") {
                self.scaleStateManager.adjustScaleIndex(by: 1)
            }
            .disabled(self.scaleStateManager.scaleIsMax)
            .opacity(self.scaleStateManager.scaleIsMax ? YonderCoreGraphics.disabledButtonOpacity : 1)
            
            YonderWideButton(text: self.travelStateManager.travellingActive ? "Done" : Term.travel.capitalized) {
                self.travelStateManager.toggleTravellingActiveState()
            }
            .disabled(!self.travelStateManager.travellingAllowed)
            .opacity(self.travelStateManager.travellingAllowed ? 1 : YonderCoreGraphics.disabledButtonOpacity)
            
            YonderSquareButton(text: "i") {
                // Will expand with matchGeometryEffect to show legend
            }
        }
        .padding(.bottom, YonderCoreGraphics.padding)
        .padding(.horizontal, YonderCoreGraphics.padding)
    }
}
