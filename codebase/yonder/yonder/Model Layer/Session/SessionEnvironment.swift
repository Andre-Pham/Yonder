//
//  SessionEnvironment.swift
//  yonder
//
//  Created by Andre Pham on 7/12/2022.
//

import Foundation
import UIKit

class SessionEnvironment {
    
    static var executingSwiftUIPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
    static var applicationState: UIApplication.State {
        UIApplication.shared.applicationState
    }
    
}
