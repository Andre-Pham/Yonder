//
//  ContentView.swift
//  Animation
//
//  Created by Andre Pham on 8/6/2023.
//

import SwiftUI

struct ContentView: View {
//    let imageManager = ImageManager(imageName: "IMG-E0001")
    @StateObject private var manager = AnimationManager(id: "E0001", initialSequence: .idle)!
    @StateObject private var queue = AnimationQueue(id: "E0001", defaultAnimation: .idle)!
    
    var body: some View {
        VStack(spacing: 0) {
//            self.imageManager.croppedImage
//                .resizable()
//                .interpolation(.none)
//                .frame(width: 5000, height: 5000)
            
            self.queue.frame
                .resizable()
                .interpolation(.none)
                .frame(width: 300, height: 300)
            
            Group {
                Button("Play") {
                    self.queue.play()
                }
                
                Button("Pause") {
                    self.queue.pause()
                }
                
                Button("End") {
                    self.queue.stop()
                }
                
                Button("Restart") {
                    self.queue.restart()
                }
                
                Button("Idle") {
                    self.queue.addToQueue(sequence: .idle)
                }
                
                Button("Breathing") {
                    self.queue.addToQueue(sequence: .breathing)
                }
                
                Button("Attack") {
                    self.queue.addToQueue(sequence: .attack)
                }
                
                Button("Die") {
                    self.queue.clearQueue()
                    self.queue.addToQueue(sequence: .death)
                    self.queue.endQueue()
                }
            }
            
            Button("Speed 1x") {
                self.queue.setPlaybackSpeed(to: 1.0)
            }
            
            Button("Speed 0.5x") {
                self.queue.setPlaybackSpeed(to: 0.5)
            }
            
//            self.imageManager.croppedImage2
//                .resizable()
//                .interpolation(.none)
//                .frame(width: 1000, height: 1000)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
