//
//  StartingInspectView.swift
//  yonder
//
//  Created by Andre Pham on 24/3/2024.
//

import Foundation
import SwiftUI

struct StartingInspectView: View {
    private let intro = Strings("inspect.starting.intro").local
    private let tip = Strings("inspect.starting.tip").local
    
    var body: some View {
        InspectBody {
            YonderText(text: self.intro, size: .inspectSheetBody)
            
            YonderText(text: self.tip, size: .inspectSheetBody)
        }
    }
}

#Preview {
    PreviewContentView {
        StartingInspectView()
    }
}
