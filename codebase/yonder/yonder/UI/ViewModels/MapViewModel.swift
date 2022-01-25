//
//  MapPresenter.swift
//  yonder
//
//  Created by Andre Pham on 6/1/2022.
//

import Foundation

class MapViewModel: ObservableObject {
    
    private(set) var map: Map
    
    init(_ map: Map) {
        self.map = map
    }
    
}
