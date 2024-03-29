//
//  BuffEffectsDescription.swift
//  yonder
//
//  Created by Andre Pham on 18/6/2022.
//

import Foundation

enum BuffEffectsDescription {
    
    static func buildPercentageEffectsDescription(
        direction: Buff.BuffDirection,
        fraction: Double,
        outgoingIncrease: Strings,
        outgoingDecrease: Strings,
        incomingIncrease: Strings,
        incomingDecrease: Strings,
        bidirectionalIncrease: Strings,
        bidirectionalDecrease: Strings
    ) -> String? {
        var effectsDescription: String? = nil
        let percentage = fraction.toRelativePercentage()
        switch direction {
        case .outgoing:
            if fraction.multiplyingIncreases() {
                effectsDescription = outgoingIncrease.localWithArgs(percentage)
            } else if fraction.multiplyingDecreases() {
                effectsDescription = outgoingDecrease.localWithArgs(percentage)
            }
        case .incoming:
            if fraction.multiplyingIncreases() {
                effectsDescription = incomingIncrease.localWithArgs(percentage)
            } else if fraction.multiplyingDecreases() {
                effectsDescription = incomingDecrease.localWithArgs(percentage)
            }
        case .bidirectional:
            if fraction.multiplyingIncreases() {
                effectsDescription = bidirectionalIncrease.localWithArgs(percentage)
            } else if fraction.multiplyingDecreases() {
                effectsDescription = bidirectionalDecrease.localWithArgs(percentage)
            }
        }
        return effectsDescription
    }
    
    static func buildMagnitudeEffectsDescription(
        direction: Buff.BuffDirection,
        difference: Int,
        outgoingIncrease: Strings,
        outgoingDecrease: Strings,
        incomingIncrease: Strings,
        incomingDecrease: Strings,
        bidirectionalIncrease: Strings,
        bidirectionalDecrease: Strings
    ) -> String? {
        var effectsDescription: String? = nil
        let effectsMagnitude = abs(difference)
        switch direction {
        case .outgoing:
            if difference > 0 {
                effectsDescription = outgoingIncrease.localWithArgs(effectsMagnitude)
            } else if difference < 0 {
                effectsDescription = outgoingDecrease.localWithArgs(effectsMagnitude)
            }
        case .incoming:
            if difference > 0 {
                effectsDescription = incomingIncrease.localWithArgs(effectsMagnitude)
            } else if difference < 0 {
                effectsDescription = incomingDecrease.localWithArgs(effectsMagnitude)
            }
        case .bidirectional:
            if difference > 0 {
                effectsDescription = bidirectionalIncrease.localWithArgs(effectsMagnitude)
            } else if difference < 0 {
                effectsDescription = bidirectionalDecrease.localWithArgs(effectsMagnitude)
            }
        }
        return effectsDescription
    }
    
}
