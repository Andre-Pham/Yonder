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
            .disabledWhen(self.scaleStateManager.scaleIsMin)
            
            YonderSquareButton(text: "+") {
                self.scaleStateManager.adjustScaleIndex(by: 1)
            }
            .disabledWhen(self.scaleStateManager.scaleIsMax)
            
            YonderWideButton(text: self.travelStateManager.travellingActive ? Strings("map.header.done").local : Strings("map.header.travel").local) {
                self.travelStateManager.toggleTravellingActiveState()
            }
            .disabledWhen(!self.travelStateManager.travellingAllowed)
            
            YonderSquareButton(text: Strings("map.header.informationShorthand").local) {
                // Will expand with matchGeometryEffect to show legend
            }
        }
        .padding(.bottom, YonderCoreGraphics.padding)
        .padding(.horizontal, YonderCoreGraphics.padding)
        .background(YonderColors.backgroundMaxDepth)
    }
}
