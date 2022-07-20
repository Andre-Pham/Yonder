//
//  BridgeInspectView.swift
//  yonder
//
//  Created by Andre Pham on 9/5/2022.
//

import SwiftUI

struct BridgeInspectView: View {
    @ObservedObject var location1ViewModel: LocationViewModel
    @ObservedObject var location2ViewModel: LocationViewModel
    
    var body: some View {
        InspectBody {
            YonderText(text: LocationType.bridge.description, size: .inspectSheetBody)
            
            InspectSectionSpacingView()
            
            InspectLocationView(locationViewModel: self.location1ViewModel)
            
            InspectSectionSpacingView()
            
            InspectLocationView(locationViewModel: self.location2ViewModel)
        }
    }
}

struct BridgeInspectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            BridgeInspectView(
                location1ViewModel: PreviewObjects.locationViewModel,
                location2ViewModel: PreviewObjects.alternateLocationViewModel)
        }
    }
}
