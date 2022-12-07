//
//  TimedEventViewModel.swift
//  yonder
//
//  Created by Andre Pham on 7/7/2022.
//

import Foundation
import Combine

class TimedEventViewModel: ObservableObject {
    
    private(set) var timedEvent: TimedEvent
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var timeRemaining: Int
    public let initialTimeRemaining: Int
    public let name: String
    public let effectsDescription: String?
    public let id: UUID
    
    init(_ timedEvent: TimedEvent) {
        self.timedEvent = timedEvent
        
        self.timeRemaining = timedEvent.timer.timeLeft
        self.initialTimeRemaining = timedEvent.timer.initialTime
        self.name = timedEvent.name
        self.effectsDescription = timedEvent.getEffectsDescription()
        self.id = timedEvent.id
        
        self.timedEvent.timer.$timeLeft.sink(receiveValue: { newValue in
            self.timeRemaining = newValue
        }).store(in: &self.subscriptions)
    }
    
    func getIndicativeValue(actorViewModel: ActorViewModel) -> Int? {
        return self.timedEvent.getIndicativeValue(target: actorViewModel.actor)
    }
    
}
