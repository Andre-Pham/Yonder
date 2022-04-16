//
//  YonderExpandableWideButtonBody.swift
//  yonder
//
//  Created by Andre Pham on 11/4/2022.
//

import SwiftUI

struct YonderExpandableWideButtonBody<Content: View, ExpandedContent: View>: View {
    private let content: () -> Content
    private let expandedContent: () -> ExpandedContent
    
    // Binding also allows animations to be enabled/disabled accordingly
    @Binding var isExpanded: Bool
    
    init(isExpanded: Binding<Bool>, @ViewBuilder label: @escaping () -> Content, @ViewBuilder expandedContent: @escaping () -> ExpandedContent) {
        self._isExpanded = isExpanded
        self.content = label
        self.expandedContent = expandedContent
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            YonderWideButtonBody {
                self.isExpanded.toggle()
            } label: {
                VStack {
                    content()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, YonderCoreGraphics.padding)
                    
                    if self.isExpanded {
                        // Expand button frame
                        expandedContent()
                            .hidden()
                    }
                }
            }
            
            if self.isExpanded {
                expandedContent()
                    .padding(.horizontal, YonderCoreGraphics.padding)
                    .padding(.bottom, YonderCoreGraphics.padding)
            }
        }
    }
}
