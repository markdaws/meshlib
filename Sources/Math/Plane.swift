//
//  Plane.swift
//  arkit-sculpt
//
//  Created by md on 8/7/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

import Foundation
import GLKit

public final class Plane {
  let p0: GLKVector3
  let p1: GLKVector3
  let p2: GLKVector3
  let normal: GLKVector3
  let d: Float

  public init(p0: GLKVector3, p1: GLKVector3, p2: GLKVector3) {
    self.p0 = p0
    self.p1 = p1
    self.p2 = p2
    
    let v1 = GLKVector3Subtract(p1, p0)
    let v2 = GLKVector3Subtract(p2, p0)
    normal = GLKVector3Normalize(GLKVector3CrossProduct(v1, v2))
    d = -1 * (normal.x * p0.x + normal.y * p0.y + normal.z * p0.z)
  }

  public func intersection(ray: Ray) -> (point: GLKVector3, dist: Float)? {
    let dp = GLKVector3DotProduct(normal, ray.direction)
    if abs(1.0 - dp) < 0.00001 {
      return nil
    }
    
    // P = P0 + tV
    // P . N + d = 0
    //
    // (P0 + tV) . N + d = 0
    // P0 . N + tV . N + d = 0
    // t = -(P0 . N + d) / V . N
    
    let t = -(GLKVector3DotProduct(ray.origin, normal) + d) / dp;
    if (t < 0)
    {
      return nil
    }
    return (GLKVector3Add(ray.origin, GLKVector3MultiplyScalar(ray.direction, t)), t)
  }
}
