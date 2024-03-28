//
//  SerializationTypes.swift
//  yonder
//
//  Created by Andre Pham on 28/3/2024.
//

import Foundation
import SwiftSerialization

/// These types were originally in-built. They were moved to my serialization package.
/// Rather than go to every file and import SwiftSerialization, it's easier and more maintainable to define the types here.
/// If I ever wish to change the type or type name, I could just adjust the aliases here, assuming their internal implementation remains backwards compatible.

typealias Storable = SwiftSerialization.Storable

typealias DataObject = SwiftSerialization.DataObject
