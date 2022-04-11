//
//  YonderExpandableWideButtonBody.swift
//  yonder
//
//  Created by Andre Pham on 11/4/2022.
//

import SwiftUI

struct YonderExpandableWideButtonBody<Content: View>: View {
    private let content: () -> Content
    let action: () -> Void
    
    // Binding so that animations can enable/disable themselves accordingly
    @Binding var isExpanded: Bool
    @State var isDisabled: Bool
    private let expandedButtonText: String
    
    init(isExpanded: Binding<Bool>, isDisabled: Bool = false, expandedButtonText: String, action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Content) {
        self._isExpanded = isExpanded
        self.isDisabled = isDisabled
        self.expandedButtonText = expandedButtonText
        self.action = action
        self.content = label
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            YonderWideButtonBody {
                self.isExpanded.toggle()
            } label: {
                VStack {
                    HStack {
                        content()
                        
                        Spacer()
                    }
                    .padding(.horizontal, YonderCoreGraphics.padding)
                    
                    if self.isExpanded {
                        // Expand button frame
                        YonderWideButton(text: "") {}
                        .padding(.top, YonderCoreGraphics.padding)
                        .hidden()
                    }
                }
            }
            
            if self.isExpanded {
                YonderWideButton(text: self.expandedButtonText) {
                    action()
                }
                .disabled(self.isDisabled)
                .opacity(self.isDisabled ? YonderCoreGraphics.disabledButtonOpacity : 1)
                .padding(.horizontal, YonderCoreGraphics.padding)
                .padding(.bottom, YonderCoreGraphics.padding)
            }
        }
    }
}
