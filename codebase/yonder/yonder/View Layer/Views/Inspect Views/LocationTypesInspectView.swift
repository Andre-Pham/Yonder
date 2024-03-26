//
//  LocationTypesInspectView.swift
//  yonder
//
//  Created by Andre Pham on 26/3/2024.
//

import SwiftUI

struct LocationTypesInspectView: View {
    let locationTypes: [LocationType] = [
        .hostile,
        .challengeHostile,
        .boss,
        .shop,
        .friendly,
        .enhancer,
        .restorer,
        .bridge
    ]
    
    var body: some View {
        InspectBody {
            YonderText(text: "Location Types", size: .inspectSheetTitle)
            
            InspectSectionSpacingView()
            
            ForEach(self.locationTypes, id: \.self) { locationType in
                VStack(alignment: .leading) {
                    HStack {
                        YonderIcon(image: locationType.image, sideLength: .inspectSheet)
                        
                        YonderText(text: locationType.name, size: .inspectSheetBody)
                            
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(YonderBorder4Presets.outlineColor)
                    
                    YonderText(text: locationType.summary, size: .cardSubscript)
                }
                .padding(.bottom, 6)
            }
        }
    }
}

#Preview {
    PreviewContentView {
        LocationTypesInspectView()
    }
}
