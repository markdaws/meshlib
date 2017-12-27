//
//  Primitive.swift
//  meshlib
//
//  Created by md on 12/24/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

import Foundation
import GLKit

public protocol Primitive {
  func centroid() -> GLKVector3
  func normal() -> GLKVector3
}
