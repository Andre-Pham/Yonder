//
//  StatsStack.swift
//  yonder
//
//  Created by Andre Pham on 18/3/2024.
//

import Foundation
import SwiftUI

struct StatsStack<Content: View>: View {
    private let content: () -> Content
    
    init(@ViewBuilder builder: @escaping () -> Content) {
        self.content = builder
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            content()
        }
    }
}

