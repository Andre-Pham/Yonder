//
//  BuffViewModel.swift
//  yonder
//
//  Created by Andre Pham on 24/6/2022.
//

import Foundation
import Combine

class BuffViewModel: ObservableObject {
    
    private(set) var buff: Buff
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var timeRemaining: Int?
    private(set) var initialTimeRemaining: Int?
    private(set) var sourceName: String
    private(set) var effectsDescription: String?
    private(set) var id: UUID
    
    init(_ buff: Buff) {
        self.buff = buff
        
        if buff.isInfinite {
            self.timeRemaining = nil
        } else {
            self.timeRemaining = buff.timeRemaining
        }
        self.initialTimeRemaining = buff.initialTimeRemaining
        self.sourceName = buff.sourceName
        self.effectsDescription = buff.getEffectsDescription()
        self.id = buff.id
        
        self.buff.$timeRemaining.sink(receiveValue: { newValue in
            self.timeRemaining = newValue
        }).store(in: &self.subscriptions)
    }
    
}
