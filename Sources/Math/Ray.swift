//
//  Ray.swift
//  arkit-sculpt
//
//  Created by md on 8/7/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

import Foundation
import GLKit

public final class Ray {
  let origin: GLKVector3
  let direction: GLKVector3

  public init(origin: GLKVector3, direction: GLKVector3) {
    self.origin = origin
    self.direction = direction
  }

}
