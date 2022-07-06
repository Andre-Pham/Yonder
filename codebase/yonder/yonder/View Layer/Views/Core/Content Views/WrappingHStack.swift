//
//  WrappingHStack.swift
//  yonder
//
//  Created by Andre Pham on 6/7/2022.
//

import SwiftUI

/// A wrapping HStack; a HStack, except when its content is wider than the available space, it wraps its content to a new row so it all fits.
/// NOTE: Different frame sizes work fine, but if text is being inserted with other views that differ greatly in height from the text, the text will appear wrong. To resolve this, add a `.frame(height: #)` modifier to the text to match the other views.
/// Inspired by: https://stackoverflow.com/a/62103264
struct WrappingHStack<Content: View>: View {
    private let content: () -> Content
    private let horizontalSpacing: CGFloat
    private let verticalSpacing: CGFloat
    @State private var totalHeight = CGFloat.zero
    
    init(horizontalSpacing: CGFloat = 8, verticalSpacing: CGFloat = 8, @ViewBuilder content: @escaping () -> Content) {
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.content = content
    }
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                self.generateContent(geometry: geo)
            }
            .frame(height: self.totalHeight)
        }
    }
    
    private func generateContent(geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            content()
                .padding(.horizontal, self.horizontalSpacing)
                .padding(.vertical, self.verticalSpacing)
                .alignmentGuide(.leading, computeValue: { dimension in
                    if (abs(width - dimension.width) > geometry.size.width) {
                        width = 0
                        height -= dimension.height
                    }
                    let result = width
                    width -= dimension.width
                    return result
                })
                .alignmentGuide(.top, computeValue: { _ in
                    return height
                })
            
            // The last element needs some special alignment guides
            // Because we can't detect the last element in the content parameter, we add a dummy last element
            // It has 0 opacity so it isn't drawn, and 0 frame height so it doesn't create a new line (it doesn't wrap)
            // It is still required because it provides the final alignment guides, despite not being drawn
            Text("")
                .padding(.horizontal, self.horizontalSpacing)
                .padding(.vertical, self.verticalSpacing)
                .alignmentGuide(.leading, computeValue: { dimension in
                    if (abs(width - dimension.width) > geometry.size.width) {
                        width = 0
                        height -= dimension.height
                    }
                    let result = width
                    width = 0
                    return result
                })
                .alignmentGuide(.top, computeValue: { _ in
                    let result = height
                    height = 0
                    return result
                })
                .opacity(0.0)
                .frame(height: 0)
        }
        .background(self.viewHeightReader(self.$totalHeight))
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

struct WrappingHStack_Previews: PreviewProvider {
    static var previews: some View {
        WrappingHStack() {
            Rectangle()
                .fill()
                .frame(width: 120, height: 100)
            
            Rectangle()
                .fill()
                .frame(width: 70, height: 100)
            
            Rectangle()
                .fill()
                .frame(width: 120, height: 100)
            
            Rectangle()
                .fill()
                .frame(width: 40, height: 100)
            
            Text("Any view can go here!")
                .frame(height: 100)
            
            Image(systemName: "square.and.pencil")
            
            Rectangle()
                .fill()
                .frame(width: 20, height: 100)
        }
    }
}
