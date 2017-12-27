//
//  Face.swift
//  meshlibTests
//
//  Created by md on 12/20/17.
//

import Foundation
import SceneKit

public final class Face {
  let edges: [Int]
  let material: SCNMaterial
  unowned let mesh: Mesh
  let nodes: [Int]
  let triangles: [Triangle]

  public init(material: SCNMaterial, edges: [Int], nodes: [Int], triangles: [Triangle], mesh: Mesh) {
    self.material = material
    self.edges = edges
    self.nodes = nodes
    self.triangles = triangles
    self.mesh = mesh
  }

  public func clone(mesh: Mesh) -> Face {
    let triangles = self.triangles.map { $0.clone() }
    return Face(material: material, edges: edges, nodes: nodes, triangles: triangles, mesh: mesh)
  }

  // TODO: Does this really need to be a CInt
  func trianglesToIndices(indices: inout[CInt]) -> Int {
    triangles.forEach({ t in
      indices.append(CInt(t.v1Index))
      indices.append(CInt(t.v2Index))
      indices.append(CInt(t.v3Index))
    })
    return triangles.count
  }
}

extension Face: Primitive {
  public func centroid() -> GLKVector3 {
    var centroid = GLKVector3Make(0, 0, 0)
    for index in nodes {
      centroid = GLKVector3Add(centroid, mesh.nodes[index].centroid())
    }
    return GLKVector3MultiplyScalar(centroid, Float(1.0 / Double(nodes.count)))
  }

  public func normal() -> GLKVector3 {
    var normal = GLKVector3Make(0, 0, 0)
    for index in nodes {
      normal = GLKVector3Add(normal, mesh.nodes[index].normal())
    }
    return GLKVector3Normalize(GLKVector3MultiplyScalar(normal, Float(1.0 / Double(nodes.count))))
  }
}
