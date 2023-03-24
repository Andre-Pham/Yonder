//
//  OverlayView.swift
//  yonder
//
//  Created by Andre Pham on 20/3/2023.
//

import Foundation
import UIKit
import SwiftUI

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

class OverlayViewController: UIViewController {
    // This class has been intentionally left blank
    // Its only job is to present a UIHostingController using a modal presentation style
    // Custom attributes can also be inserted, such as a view background color, etc.
}
