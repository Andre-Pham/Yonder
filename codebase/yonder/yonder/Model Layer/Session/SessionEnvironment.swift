//
//  SessionEnvironment.swift
//  yonder
//
//  Created by Andre Pham on 7/12/2022.
//

import Foundation

class SessionEnvironment {
    
    static var executingSwiftUIPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
}
