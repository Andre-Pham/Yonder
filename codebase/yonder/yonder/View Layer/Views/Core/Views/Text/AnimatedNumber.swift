//
//  AnimatedNumber.swift
//  yonder
//
//  Created by Andre Pham on 18/4/2022.
//

// Source: https://github.com/jeffgrann/AnimatedNumber
import Foundation
import SwiftUI

struct AnimatedNumber: View {
    @State private var destinationValue: Double
    private let maxDuration: Double
    private let formatter: Formatter
    @State private var originalValue: Double
    @State private var percentage: Double = 0.0
    @Binding private var value: Double
    
    init(_ value: Binding<Double>, maxDuration: Double = 0.7, formatter: Formatter = NumberFormatter()) {
        self._value = value
        self._originalValue = .init(initialValue: value.wrappedValue)
        self._destinationValue = .init(initialValue: value.wrappedValue)
        self.maxDuration = maxDuration
        self.formatter = formatter
    }
    
    var body: some View {
        EmptyView()
            .modifier(
                AnimatedNumberModifier(
                    value: $value,
                    originalValue: $originalValue,
                    destinationValue: $destinationValue,
                    maxDuration: maxDuration,
                    percentage: $percentage,
                    formatter: formatter
                )
            )
    }
}

struct AnimatedNumberModifier: AnimatableModifier {
    private var animationPercentage: Double
    @Binding private var destinationValue: Double
    private let formatter: Formatter
    @Binding private var originalValue: Double
    @Binding private var percentage: Double
    private var maxDuration: Double
    private var duration: Double {
        let difference = abs(originalValue - value)
        if difference <= 1 {
            return 0
        } else if difference <= 3 {
            return 0.4
        } else if difference <= 6 {
            return 0.6
        }
        return self.maxDuration
    }
    @Binding private var value: Double
    
    init(value: Binding<Double>, originalValue: Binding<Double>, destinationValue: Binding<Double>, maxDuration: Double, percentage: Binding<Double>, formatter: Formatter) {
        self._value = value
        self._originalValue = originalValue
        self._destinationValue = destinationValue
        self.maxDuration = maxDuration
        self._percentage = percentage
        self.animationPercentage = percentage.wrappedValue
        self.formatter = formatter
    }
    
    var animatableData: Double {
        get { animationPercentage }
        set { animationPercentage = newValue }
    }
    
    private var animatedValue: Double {
        originalValue + ((destinationValue - originalValue) * animationPercentage)
    }
    
    func body(content: Content) -> some View {
        if animationPercentage == 1 {
            DispatchQueue.main.async {
                percentage = 0
                originalValue = value
                destinationValue = value
            }
        }
        
        return
            Text(displayValue)
            .onChange(of: value) { _ in
                if isAnimating {
                    // Restart the animation from the current value to the destination value.
                    withAnimation(.linear(duration: 0)) {
                        percentage = 0
                    }
                    
                    DispatchQueue.main.async {
                        originalValue = animatedValue
                        destinationValue = value

                        withAnimation(.linear(duration: duration)) {
                            percentage = 1
                        }
                    }
                } else {
                    destinationValue = value
                    
                    withAnimation(.linear(duration: duration)) {
                        percentage = 1
                    }
                }
            }
    }
    
    private var displayValue: String {
        formatter.string(for: animatedValue as NSNumber)!
    }
    
    private var isAnimating: Bool {
        percentage != 0
    }
}
