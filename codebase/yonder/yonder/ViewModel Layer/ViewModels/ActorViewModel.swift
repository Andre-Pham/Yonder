//
//  ActorViewModel.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import Foundation
import Combine

class ActorViewModel: ObservableObject {
    
    // actor can be used within the ViewModel layer, but Views should only interact with ViewModels (not the Model layer)
    private(set) var actor: ActorAbstract
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var buffViewModels: [BuffViewModel] {
        didSet {
            // Changes to any BuffViewModel will be published to the UI
            for buff in self.buffViewModels {
                buff.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() }).store(in: &self.subscriptions)
            }
        }
    }
    @Published private(set) var statusEffectViewModels: [StatusEffectViewModel] {
        didSet {
            // Changes to any StatusEffectViewModel will be published to the UI
            for statusEffect in self.statusEffectViewModels {
                statusEffect.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() }).store(in: &self.subscriptions)
            }
        }
    }
    @Published private(set) var timedEventsViewModels: [TimedEventViewModel] {
        didSet {
            // Changes to any TimedEventViewModel will be published to the UI
            for timedEvent in self.timedEventsViewModels {
                timedEvent.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() }).store(in: &self.subscriptions)
            }
        }
    }
    // Should override in subclasses that introduce new buff sources
    var allBuffs: [BuffViewModel] {
        return Array(self.buffViewModels)
    }
    
    init(_ actor: ActorAbstract) {
        self.actor = actor
        
        // Set other view models
        
        self.buffViewModels = self.actor.buffs.map { BuffViewModel($0) }
        self.statusEffectViewModels = self.actor.statusEffects.map { StatusEffectViewModel($0) }
        self.timedEventsViewModels = self.actor.timedEvents.map { TimedEventViewModel($0) }
        
        // Add Subscribers
        
        self.actor.$buffs.sink(receiveValue: { newValue in
            self.buffViewModels = newValue.map { BuffViewModel($0) }
        }).store(in: &self.subscriptions)
        
        self.actor.$statusEffects.sink(receiveValue: { newValue in
            self.statusEffectViewModels = newValue.map { StatusEffectViewModel($0) }
        }).store(in: &self.subscriptions)
        
        self.actor.$timedEvents.sink(receiveValue: { newValue in
            self.timedEventsViewModels = newValue.map { TimedEventViewModel($0) }
        }).store(in: &self.subscriptions)
    }
    
}
