//
//  File.swift
//  arkit-sculpt
//
//  Created by md on 8/12/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

import Foundation
import GLKit

public struct Basis {

  public let origin: GLKVector3
  public let up: GLKVector3
  public let side: GLKVector3
  public let look: GLKVector3

  public init(origin: GLKVector3, up: GLKVector3, side: GLKVector3, look: GLKVector3) {
    self.origin = origin
    self.up = up
    self.side = side
    self.look = look
  }

}
