//
//  ClassSelectView.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import SwiftUI

struct ClassSelectView: View {
    @Binding var isShowing: Bool
    let onSelection: (_ selection: PlayerClassOption) -> Void
    let onCancel: () -> Void
    
    @State private var classIndex: Int?
    private var unwrappedClassIndex: Int {
        return self.classIndex ?? 0
    }
    private let availableClassOptions = PlayerClassOption.availableOptions
    private var classSelection: PlayerClassOption {
        return self.availableClassOptions[self.unwrappedClassIndex]
    }
    
    var body: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            VStack {
                YonderText(
                    text: Strings("classMenu.title").local,
                    size: .title2,
                    multilineTextAlignment: .center
                )
                .padding(.bottom, 40)
                
                ScrollViewReader { scrollProxy in
                    ScrollView(.horizontal) {
                        HStack(spacing: 0) {
                            ForEach(self.availableClassOptions.indices, id: \.self) { index in
                                let option = self.availableClassOptions[index]
                                VStack {
                                    YonderBorder12 {
                                        VStack(spacing: 0) {
                                            option.characterSprite.image
                                                .resizable()
                                                .interpolation(.none)
                                                .frame(width: 140, height: 140)
                                            
                                            YonderText(
                                                text: option.name,
                                                size: .buttonBodySubscript
                                            )
                                            .padding(.bottom, 12)
                                        }
                                        .padding(4)
                                    }
                                }
                                .containerRelativeFrame(.horizontal)
                                .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                    content
                                        .opacity(phase.isIdentity ? 1.0 : 0.9)
                                        .scaleEffect(phase.isIdentity ? 1.0 : 0.9)
                                }
                                // Note: view must not have an id modifier
                                // See: https://stackoverflow.com/a/77165176
                                // If we change this to use a LazyHStack, THEN implement an id modifier
                            }
                        }
                        // Required for .scrollPosition(:Int)
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.paging)
                    .scrollPosition(id: self.$classIndex)
                    .scrollIndicators(.never)
                    
                    YonderText(
                        text: "\((self.classIndex ?? 0) + 1)/\(self.availableClassOptions.count)",
                        size: .optionBody
                    )
                    .animation(.none, value: self.classIndex)
                    
                    HStack {
                        YonderSquareButton(text: Strings("leftArrow").local) {
                            if let index = self.classIndex {
                                withAnimation {
                                    self.classIndex = max(index - 1, 0)
                                }
                            }
                        }
                        .disabledWhen(self.unwrappedClassIndex == 0)
                        
                        YonderButton(text: Strings("button.start").local) {
                            self.onSelection(self.classSelection)
                        }
                        
                        YonderSquareButton(text: Strings("rightArrow").local) {
                            withAnimation {
                                self.classIndex = min(
                                    self.unwrappedClassIndex + 1,
                                    self.availableClassOptions.endIndex - 1
                                )
                            }
                        }
                        .disabledWhen(self.unwrappedClassIndex == self.availableClassOptions.endIndex - 1)
                    }
                }

                YonderButton(text: Strings("button.cancel").local) {
                    self.onCancel()
                }
            }
        }
    }
}

struct ClassSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ClassSelectView(isShowing: .constant(true)) { selection in
            // Use select class here
        } onCancel: {
            // Cancel code here
        }
    }
}
