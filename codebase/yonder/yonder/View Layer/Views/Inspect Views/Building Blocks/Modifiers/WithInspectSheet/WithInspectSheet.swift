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
            .onChange(of: self.isPresented) { _, isPresented in
                if isPresented {
                    let viewController = InspectViewController(
                        rootView: InspectSheet(isPresented: self.$isPresentedState, pageGeometry: self.pageGeometry) {
                            self.viewContent
                        }
                        .onDisappear {
                            self.isPresentedState = false
                        }
                    )
                    viewController.modalPresentationStyle = .formSheet
                    viewController.modalPresentationCapturesStatusBarAppearance = true
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

