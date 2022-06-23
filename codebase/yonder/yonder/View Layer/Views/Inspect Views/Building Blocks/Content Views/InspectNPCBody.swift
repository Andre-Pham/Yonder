//
//  InspectNPCBody.swift
//  yonder
//
//  Created by Andre Pham on 13/5/2022.
//

import SwiftUI

struct InspectNPCBody<Content: View>: View {
    let name: String
    let description: String
    let locationType: LocationType
    
    private let content: () -> Content
    init(name: String, description: String, locationType: LocationType, @ViewBuilder builder: @escaping () -> Content) {
        self.name = name
        self.description = description
        self.locationType = locationType
        self.content = builder
    }
    
    var body: some View {
        InspectBody {
            YonderText(text: self.name, size: .inspectSheetTitle)
            
            InspectNPCTypeView()
            
            YonderText(text: self.description, size: .inspectSheetBody)
            
            InspectSectionSpacingView()
            
            content()
            
            InspectSectionSpacingView()
            
            YonderText(text: Strings.Inspect.Title.Info.local, size: .inspectSheetTitle)
            
            YonderText(text: self.locationType.description, size: .inspectSheetBody)
        }
    }
}

struct InspectNPCBody_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            InspectNPCBody(
                name: "placeholderName",
                description: "placeholderDescription",
                locationType: .hostile
            ) {
                YonderText(text: "Content", size: .inspectSheetBody)
            }
        }
    }
}
