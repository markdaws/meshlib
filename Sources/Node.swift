//
//  Node.swift
//  meshlib
//
//  Created by md on 12/20/17.
//

import Foundation
import GLKit

public final class Node {
  public let index: Int
  let vertices: [Int]
  unowned let mesh: Mesh

  public init(_ index: Int, _ vertices: [Int], _ mesh: Mesh) {
    self.index = index
    self.vertices = vertices
    self.mesh = mesh
  }

  public func clone(mesh: Mesh) -> Node {
    return Node(index, vertices, mesh)
  }

}

extension Node: Primitive {

  public func centroid() -> GLKVector3 {
    return mesh.vertices[vertices[0]]
  }

  public func normal() -> GLKVector3 {
    var normal = GLKVector3Make(0, 0, 0)
    for index in vertices {
      normal = GLKVector3Add(normal, mesh.normals[index])
    }
    return GLKVector3Normalize(GLKVector3MultiplyScalar(normal, Float(1.0 / Double(vertices.count))))
  }
}
