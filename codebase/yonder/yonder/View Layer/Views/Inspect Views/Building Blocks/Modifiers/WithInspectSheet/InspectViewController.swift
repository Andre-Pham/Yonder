//
//  InspectViewController.swift
//  yonder
//
//  Created by Andre Pham on 24/3/2023.
//

import Foundation
import SwiftUI

/// Used to host the SwiftUI view that contains the inspect view. This way, this can be presented modally by another view controller.
/// For more information, refer to https://github.com/Andre-Pham/yonder/issues/2.
class InspectViewController<Content>: UIHostingController<Content> where Content: View {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
