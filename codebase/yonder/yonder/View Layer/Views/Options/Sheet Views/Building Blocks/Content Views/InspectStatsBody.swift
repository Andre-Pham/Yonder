//
//  InspectStatsbody.swift
//  yonder
//
//  Created by Andre Pham on 2/4/2022.
//

import Foundation
import SwiftUI

struct InspectStatsBody<Content: View>: View {
    private let content: () -> Content
    
    init(@ViewBuilder builder: @escaping () -> Content) {
        self.content = builder
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            content()
        }
    }
}
