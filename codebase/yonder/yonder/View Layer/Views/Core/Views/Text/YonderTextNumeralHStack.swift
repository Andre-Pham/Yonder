//
//  YonderTextNumeralHStack.swift
//  yonder
//
//  Created by Andre Pham on 18/4/2022.
//

import Foundation
import SwiftUI

struct YonderTextNumeralHStack<Content: View>: View {
    private let content: () -> Content
    
    init(@ViewBuilder builder: @escaping () -> Content) {
        self.content = builder
    }
    
    var body: some View {
        HStack(spacing: 0) {
            content()
        }
    }
}
