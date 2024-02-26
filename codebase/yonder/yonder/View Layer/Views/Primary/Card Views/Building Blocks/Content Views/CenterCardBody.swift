//
//  CenterCardBody.swift
//  yonder
//
//  Created by Andre Pham on 14/5/2022.
//

import Foundation
import SwiftUI

struct CenterCardBody<Content: View>: View {
    private let content: () -> Content
    
    /// - Parameters:
    ///   - builder: Code block to appear as content.
    init(@ViewBuilder builder: @escaping () -> Content) {
        self.content = builder
    }
    
    var body: some View {
        YonderBorder7 {
            VStack(alignment: .center, spacing: 3) {
                Spacer()
                
                content()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
    }
}
