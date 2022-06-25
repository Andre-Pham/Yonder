//
//  IndicativeNumeralView.swift
//  yonder
//
//  Created by Andre Pham on 25/6/2022.
//

import SwiftUI

struct IndicativeNumeralView: View {
    let original: Int
    let indicative: Int
    let size: YonderTextSize
    let padding: CGFloat
    @State var showing: Bool
    private let color: Color = YonderColors.highlight
    
    init(original: Int, indicative: Int, size: YonderTextSize, leftPadding: CGFloat? = nil) {
        self.original = original
        self.indicative = indicative
        self.size = size
        if let leftPadding = leftPadding {
            self.padding = leftPadding
        } else {
            self.padding = size.width/5
        }
        self.showing = original != indicative
    }
    
    var body: some View {
        if self.showing {
            SurroundingBrackets(bracket: "(", size: self.size, color: self.color) {
                YonderNumeral(number: self.indicative, size: self.size, color: self.color)
                    .onChange(of: self.indicative) { newValue in
                        withAnimation {
                            self.showing = self.original != newValue
                        }
                    }
                    .onChange(of: self.original) { newValue in
                        withAnimation {
                            self.showing = newValue != self.indicative
                        }
                    }
            }
            .padding(.leading, self.padding)
        } else {
            // This is here for a reason. Don't delete!
            // TLDR: If you completely remove this view, it can't bring itself back.
            // When IndicativeNumeralView is not showing (self.showing),
            // the entire view stops being rendered.
            // This means that its state (original and indicative) stop
            // being observed by the onChange modifiers.
            // This means that the only way for this view to re-appear
            // is for its entire parent view to be redrawn.
            // By keeping an EmptyView, the view is still saved in
            // memory, but is treated like it doesn't exist. By adding
            // onChange modifiers to the empty view, this view's state
            // (original and indicative) keep being observed for changes,
            // hence the view will re-animate itself back onto the screen
            // if the showing conditions are ever met.
            EmptyView()
                .onChange(of: self.indicative) { newValue in
                    withAnimation {
                        self.showing = self.original != newValue
                    }
                }
                .onChange(of: self.original) { newValue in
                    withAnimation {
                        self.showing = newValue != self.indicative
                    }
                }
        }
    }
}

struct IndicativeNumeralView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            YonderTextNumeralHStack  {
                YonderNumeral(number: 15, size: .buttonBody)
                
                IndicativeNumeralView(original: 5, indicative: 20, size: .buttonBody)
            }
        }
    }
}
