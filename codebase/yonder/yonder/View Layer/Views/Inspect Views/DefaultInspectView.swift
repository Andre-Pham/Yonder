//
//  DefaultInspectView.swift
//  yonder
//
//  Created by Andre Pham on 2/4/2022.
//

import SwiftUI

struct DefaultInspectView: View {
    let name: String
    let description: String
    
    var body: some View {
        InspectBody {
            YonderText(text: self.name, size: .inspectSheetTitle)
            
            YonderText(text: self.description, size: .inspectSheetBody)
        }
    }
}

struct DefaultInspectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            DefaultInspectView(name: "name", description: "description")
        }
    }
}
