//
//  OverlayView.swift
//  yonder
//
//  Created by Andre Pham on 20/3/2023.
//

import Foundation
import UIKit
import SwiftUI

/// Wraps an OverlayViewController, which is used to modally present a UIHostingController which wraps a SwiftUI view.
/// For more information, refer to https://github.com/Andre-Pham/yonder/issues/2.
struct OverlayView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = OverlayViewController
    private let viewController: OverlayViewController
    
    init(_ viewController: OverlayViewController) {
        self.viewController = viewController
    }
    
    func makeUIViewController(context: Context) -> OverlayViewController {
        return self.viewController
    }
    
    func updateUIViewController(_ uiViewController: OverlayViewController, context: Context) {
        // Do nothing
    }
    
}
