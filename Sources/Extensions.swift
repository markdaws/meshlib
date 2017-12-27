//
//  GLKVector3Extensions.swift
//  meshlib
//
//  Created by md on 12/22/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

import Foundation
import GLKit
import SceneKit

public extension Sequence where Iterator.Element == GLKVector3 {
  func toSCN() -> [SCNVector3] {
    return map { SCNVector3($0.x, $0.y, $0.z) }
  }
}

public extension SCNNode {
  // TODO: Clean material
  func removeFromParentNodeNoLeak() {
    // https://stackoverflow.com/questions/35687122/scenekit-too-much-memory-persisting
    // https://stackoverflow.com/questions/32295206/scene-kit-memory-management-using-swift/34325822#34325822
    //geometry?.materials = [nil]
    //geometry?.firstMaterial = nil
    geometry = nil
    removeFromParentNode()
  }
}

public extension SCNVector3 {
  func toGLK() -> GLKVector3 {
    return GLKVector3Make(x, y, z)
  }
}

public extension SCNQuaternion {
  func toGLK() -> GLKQuaternion {
    return GLKQuaternionMake(x, y, z, w)
  }
}

public extension GLKQuaternion {
  func toSCN() -> SCNQuaternion {
    return SCNQuaternion(x, y, z, w)
  }

  func toM() -> GLKMatrix4 {
    return GLKMatrix4MakeWithQuaternion(self)
  }
}

public extension GLKVector2 {
  func toCG() -> CGPoint {
    return CGPoint(x: CGFloat(x), y: CGFloat(y))
  }
}

public extension GLKVector3 {
  func toSCN() -> SCNVector3 {
    return SCNVector3(x, y, z)
  }

  func to4(w: Float) -> GLKVector4 {
    return GLKVector4MakeWithVector3(self, w)
  }

  func to2() -> GLKVector2 {
    return GLKVector2Make(x, y)
  }
}

/*
extension GLKVector3: CustomDebugStringConvertible {
  public var debugDescription: String {
    return "v3(x: \(x), y: \(y), z: \(z))"
  }
}
 */

public extension GLKVector4 {
  func to3() -> GLKVector3 {
    return GLKVector3Make(x, y, z)
  }
}

public extension GLKMatrix4 {
  func toQ() -> GLKQuaternion {
    return GLKQuaternionMakeWithMatrix4(self)
  }
}

public extension matrix_float4x4 {

  func position() -> GLKVector3 {
    let col = columns.3
    return GLKVector3Make(col.x, col.y, col.z)
  }

  func rotation() -> GLKMatrix4 {
    let transform = SCNMatrix4.init(self)
    return GLKMatrix4Make(
      transform.m11, transform.m12, transform.m13, transform.m14,
      transform.m21, transform.m22, transform.m23, transform.m24,
      transform.m31, transform.m32, transform.m33, transform.m34,
      transform.m41, transform.m42, transform.m43, transform.m44
    )
  }

}
