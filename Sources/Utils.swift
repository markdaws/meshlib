//
//  Utils.swift
//  meshlib
//
//  Created by md on 12/24/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

import Foundation
import GLKit

public class Utils {
  public static let EPSILON:Float = 0.00001

  public static func equal(_ v1: GLKVector3, _ v2: GLKVector3) -> Bool {
    let dx = abs(v2.x - v1.x)
    let dy = abs(v2.y - v1.y)
    let dz = abs(v2.z - v1.z)
    return dx < EPSILON && dy < EPSILON && dz < EPSILON
  }
}
