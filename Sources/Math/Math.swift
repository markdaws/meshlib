//
//  Math.swift
//  arkit-sculpt
//
//  Created by md on 7/24/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

import Foundation
import GLKit

public final class Math {

  public class func skewLinesShortestDistancePoints(ray0: Ray, ray1: Ray) ->
    (ray0Point: GLKVector3, ray0Distance: Float, ray1Point: GLKVector3, ray1Distance: Float)? {
      let u = GLKVector3Subtract(ray0.origin, ray1.origin)
      let a = GLKVector3DotProduct(ray0.direction, ray0.direction)
      let b = GLKVector3DotProduct(ray0.direction, ray1.direction)
      let c = GLKVector3DotProduct(ray1.direction, ray1.direction)
      let d = GLKVector3DotProduct(ray0.direction, u)
      let e = GLKVector3DotProduct(ray1.direction, u)
      let det = a * c - b * b

      if det < 0.000001 {
        return nil
      }

      let sc = (b*e - c*d) / (a*c - b*b)
      let tc = (a*e - b*d) / (a*c - b*b)
      return (
        GLKVector3Add(ray0.origin, GLKVector3MultiplyScalar(ray0.direction, sc)),
        sc,
        GLKVector3Add(ray1.origin, GLKVector3MultiplyScalar(ray1.direction, tc)),
        tc
      )
  }

  public class func makeQuaternion(from: GLKVector3, to: GLKVector3) -> GLKQuaternion {
    var rotAngle = acos(GLKVector3DotProduct(from, to))
    if rotAngle < 0.001 {
      return GLKQuaternionIdentity
    }
    var rotAxis = GLKVector3CrossProduct(from, to)
    if GLKVector3Length(rotAxis) < 0.001 {
      rotAxis = GLKVector3Make(0,1,0)
      rotAngle = Float.pi
    } else {
      rotAxis = GLKVector3Normalize(rotAxis)
    }

    return GLKQuaternionMakeWithAngleAndAxis(rotAngle, rotAxis.x, rotAxis.y, rotAxis.z)
  }

  public class func convertBasis(from: Basis, to: Basis) -> GLKMatrix4 {
    let t = GLKMatrix4MakeTranslation(to.origin.x, to.origin.y, to.origin.z)
    let r = GLKMatrix4MakeWithColumns(
      GLKVector4MakeWithVector3(to.side, 0),
      GLKVector4MakeWithVector3(to.up, 0),
      GLKVector4MakeWithVector3(to.look, 0),
      GLKVector4Make(0,0,0,1)
    )
    return GLKMatrix4Multiply(r, t)
  }
}
