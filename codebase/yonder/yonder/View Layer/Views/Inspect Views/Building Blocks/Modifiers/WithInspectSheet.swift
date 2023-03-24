//
//  WithInspectSheet.swift
//  yonder
//
//  Created by Andre Pham on 13/2/2022.
//

import Foundation
import SwiftUI
import UIKit

struct WithInspectSheet: ViewModifier {
    /// Published variables must not be bound to view updates, hence seperate internal state is managed along with the binding
    /// For more information, see https://github.com/Andre-Pham/yonder/issues/5
    @State private var isPresentedState = false
    @Binding var isPresented: Bool
    let pageGeometry: GeometryProxy
    var viewContent: AnyView
    @State private var overlayViewController = OverlayViewController()
    
    func body(content: Content) -> some View {
        content
            .overlay {
                // The purpose of this view is purely to wrap a view controller which modally presents a UIHostingController
                // The UIHostingController wraps the inspect sheet view
                // This is a work around for the following issue: https://github.com/Andre-Pham/yonder/issues/2
                OverlayView(self.overlayViewController)
                    .opacity(0.0)
            }
            .onChange(of: self.isPresented) { isPresented in
                if isPresented {
                    let viewController = UIHostingController(
                        rootView: InspectSheet(pageGeometry: self.pageGeometry) {
                            self.viewContent
                        }
                        .onDisappear {
                            self.isPresentedState = false
                        }
                    )
                    viewController.modalPresentationStyle = .formSheet
                    self.overlayViewController.present(viewController, animated: true)
                }
            }
            .sync(self.$isPresented, with: self.$isPresentedState)
    }
}
extension View {
    func withInspectSheet(isPresented: Binding<Bool>, pageGeometry: GeometryProxy, content: AnyView) -> some View {
        modifier(WithInspectSheet(isPresented: isPresented, pageGeometry: pageGeometry, viewContent: content))
    }
}

struct InspectSheet<Content: View>: View {
    @Environment(\.dismiss) var dismiss
    private let content: () -> Content
    
    let pageGeometry: GeometryProxy
    
    init(pageGeometry: GeometryProxy, @ViewBuilder builder: @escaping () -> Content) {
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
                height: self.pageGeometry.size.height)
            
            Rectangle()
                .stroke(YonderColors.border, lineWidth: YonderCoreGraphics.borderWidth)
                .frame(
                    width: self.pageGeometry.size.width-YonderCoreGraphics.padding*4,
                    height: self.pageGeometry.size.height)
        }
        .onTapGesture {
            dismiss()
        }
    }
}
