//
//  TimedEvent.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

protocol TimedEvent {
    
    var timeRemaining: Int { get set }
    
    func decrementTimeRemaining()
    func triggerEvent()
    
}
