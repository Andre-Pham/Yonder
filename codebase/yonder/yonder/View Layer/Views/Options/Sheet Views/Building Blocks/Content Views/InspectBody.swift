//
//  InspectBody.swift
//  yonder
//
//  Created by Andre Pham on 25/3/2022.
//

import Foundation
import SwiftUI

struct InspectBody<Content: View>: View {
    private let content: () -> Content
    
    init(@ViewBuilder builder: @escaping () -> Content) {
        self.content = builder
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: YonderCoreGraphics.paragraphSpacing) {
            content()
        }
    }
}
