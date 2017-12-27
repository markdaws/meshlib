//
//  Mesh.swift
//  meshlibPackageDescription
//
//  Created by md on 12/20/17.
//

import Foundation
import GLKit

public final class Mesh {
  var vertices: [GLKVector3]
  var normals: [GLKVector3]
  var edges: [Edge]
  var nodes: [Node]
  var faces: [Face]
  var originalVertices: [GLKVector3]
  fileprivate var editingVertices = false
  fileprivate var dirty = true

  public init(vertices: [GLKVector3], normals: [GLKVector3], edges: [Edge], nodes: [Node], faces: [Face]) {
    self.vertices = vertices
    self.normals = normals
    self.edges = edges
    self.nodes = nodes
    self.faces = faces
    originalVertices = []
  }

  public func appendVertices(_ vertices: [GLKVector3]) {
    self.vertices.append(contentsOf: vertices)
    markDirty()
  }

  public func appendEdges(_ edges: [Edge]) {
    self.edges.append(contentsOf: edges)
    markDirty()
  }

  public func appendNodes(_ nodes: [Node]) {
    self.nodes.append(contentsOf: nodes)
    markDirty()
  }

  public func appendNormals(_ normals: [GLKVector3]) {
    self.normals.append(contentsOf: normals)
    markDirty()
  }

  public func appendFaces(_ faces: Face...) {
    self.faces.append(contentsOf: faces)
    markDirty()
  }

  public func beginRelativeTransform() {
    originalVertices = vertices
    editingVertices = true
  }

  public func endRelativeTransform() {
    originalVertices = []
    editingVertices = false
  }

  func markClean() {
    dirty = false
  }

  fileprivate func markDirty() {
    dirty = true
  }

  func isDirty() -> Bool {
    return dirty
  }

  public func translateRelative(delta: GLKVector3, nodes: [Int]) {
    assert(editingVertices, "translateRelative called without calling beginRelativeTransform")
    let m = GLKMatrix4MakeTranslation(delta.x, delta.y, delta.z)
    applyTransformRelative(nodes, m)
  }

  fileprivate func applyTransformRelative(_ nodes: [Int], _ m: GLKMatrix4) {
    for nodeIndex in nodes {
      let node = self.nodes[nodeIndex]
      if node.vertices.count == 0 {
        continue
      }

      let v = GLKVector4MakeWithVector3(originalVertices[node.vertices[0]], 1)
      let vPrime = GLKMatrix4MultiplyVector4(m, v)

      for vertexIndex in node.vertices {
        vertices[vertexIndex] = GLKVector3Make(vPrime.x, vPrime.y, vPrime.z)
      }
    }

    markDirty()
  }

}
