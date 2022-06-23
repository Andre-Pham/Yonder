//
//  InspectStatusView.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation
import SwiftUI

struct InspectStatusView: View {
    let title: String
    let status: String
    var image: Image? = nil
    
    var body: some View {
        HStack {
            if let image = self.image {
                YonderIcon(image: image, sideLength: .inspectSheet)
            }
            
            YonderText(text: "\(self.title): \(self.status)", size: .inspectSheetBody)
        }
    }
}
