//
//  View.swift
//  yonder
//
//  Created by Andre Pham on 22/9/2022.
//

import Foundation
import SwiftUI

extension View {
    
    func sync(_ published: Binding<Bool>, with state: Binding<Bool>) -> some View {
        return self
            .onChange(of: published.wrappedValue) { _, newValue in
                state.wrappedValue = newValue
            }
            .onChange(of: state.wrappedValue) { _, newValue in
                published.wrappedValue = newValue
            }
    }
    
}
