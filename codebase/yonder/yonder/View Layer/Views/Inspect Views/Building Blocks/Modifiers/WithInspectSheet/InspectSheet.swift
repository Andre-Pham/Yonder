//
//  InspectSheet.swift
//  yonder
//
//  Created by Andre Pham on 24/3/2023.
//

import Foundation
import SwiftUI

struct InspectSheet<Content: View>: View {
    @Environment(\.dismiss) var dismiss
    private let content: () -> Content
    @Binding var isPresented: Bool
    let pageGeometry: GeometryProxy
    
    init(isPresented: Binding<Bool>, pageGeometry: GeometryProxy, @ViewBuilder builder: @escaping () -> Content) {
        self._isPresented = isPresented
        self.pageGeometry = pageGeometry
        self.content = builder
    }
    
    var body: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                content()
                    .padding()
            }
            .frame(
                width: self.pageGeometry.size.width-YonderCoreGraphics.padding*4,
                height: self.pageGeometry.size.height
            )
            
            Rectangle()
                .stroke(YonderColors.border, lineWidth: YonderCoreGraphics.borderWidth)
                .frame(
                    width: self.pageGeometry.size.width-YonderCoreGraphics.padding*4,
                    height: self.pageGeometry.size.height
                )
        }
        .onChange(of: self.isPresented) { isPresented in
            if !isPresented {
                dismiss()
            }
        }
        .onTapGesture {
            dismiss()
        }
    }
}
