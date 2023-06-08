//
//  ContentView.swift
//  Animation
//
//  Created by Andre Pham on 8/6/2023.
//

import SwiftUI

struct ContentView: View {
    let imageManager = ImageManager(imageName: "IMG-E0001")
    
    var body: some View {
        VStack(spacing: 0) {
            self.imageManager.croppedImage
                .resizable()
                .interpolation(.none)
                .frame(width: 5000, height: 5000)
            
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
