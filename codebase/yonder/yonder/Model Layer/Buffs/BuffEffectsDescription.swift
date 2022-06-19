//
//  BuffEffectsDescription.swift
//  yonder
//
//  Created by Andre Pham on 18/6/2022.
//

import Foundation

extension BuffAbstract {
    
    static func buildPercentageEffectsDescription(
        direction: BuffDirection,
        fraction: Double,
        outgoingIncrease: Localizable,
        outgoingDecrease: Localizable,
        incomingIncrease: Localizable,
        incomingDecrease: Localizable,
        bidirectionalIncrease: Localizable,
        bidirectionalDecrease: Localizable
    ) -> String? {
        var effectsDescription: String? = nil
        let percentage = (100.0*abs(1.0 - fraction)).toString(decimalPlaces: 1)
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
        direction: BuffDirection,
        difference: Int,
        outgoingIncrease: Localizable,
        outgoingDecrease: Localizable,
        incomingIncrease: Localizable,
        incomingDecrease: Localizable,
        bidirectionalIncrease: Localizable,
        bidirectionalDecrease: Localizable
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
