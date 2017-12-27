//
//  Edge.swift
//  meshlib
//
//  Created by md on 12/20/17.
//

import Foundation
import GLKit

public final class Edge {
  public let n1Index: Int
  public let n2Index: Int
  unowned let mesh: Mesh

  public init(_ n1Index: Int, _ n2Index: Int, _ mesh: Mesh) {
    self.n1Index = n1Index
    self.n2Index = n2Index
    self.mesh = mesh
  }

  public func clone(mesh: Mesh) -> Edge {
    return Edge(n1Index, n2Index, mesh)
  }

}

extension Edge: Primitive {
  public func centroid() -> GLKVector3 {
    let centroid = GLKVector3Add(mesh.nodes[n1Index].centroid(), mesh.nodes[n2Index].centroid())
    return GLKVector3MultiplyScalar(centroid, 0.5)
  }

  public func normal() -> GLKVector3 {
    let normal = GLKVector3Add(mesh.nodes[n1Index].normal(), mesh.nodes[n2Index].normal())
    return GLKVector3Normalize(GLKVector3MultiplyScalar(normal, 0.5))
  }
}
