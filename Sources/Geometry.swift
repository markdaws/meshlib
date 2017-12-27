//
//  SKGeometry.swift
//  meshlib
//
//  Created by md on 12/24/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

import Foundation
import GLKit
import SceneKit

fileprivate final class ElementInfo {
  let material: SCNMaterial
  let index: Int
  var indices: [CInt]

  init(material: SCNMaterial, index: Int, indices: [CInt]) {
    self.material = material
    self.index = index
    self.indices = indices
  }
}

public final class Geometry {
  static let up = GLKVector3Make(0, 1, 0)
  static let right = GLKVector3Make(1, 0, 0)
  static let front = GLKVector3Make(0, 0, 1)

  var mesh: Mesh
  var geometry: SCNGeometry?
  var isSharedMesh: Bool
  var root = SCNNode()
  var scaleNode = SCNNode()
  var rotateNode = SCNNode()
  var translateNode = SCNNode()
  var geometryNode = SCNNode()
  static var nextId: Int = 0
  public let id = getNextId()

  static func getNextId() -> String {
    nextId += 1
    return "Geometry-\(nextId)"
  }

  public init(mesh: Mesh, isSharedMesh: Bool, geometry: SCNGeometry?) {
    self.mesh = mesh
    self.isSharedMesh = isSharedMesh

    root.addChildNode(geometryNode)
    geometryNode.addChildNode(translateNode)
    translateNode.addChildNode(rotateNode)
    rotateNode.addChildNode(scaleNode)

    setGeometry(geometry: geometry)
  }

  public func clone() -> Geometry {
    // Since we are re-using the mesh from this geometry, it is now
    // considered shared
    isSharedMesh = true
    let g = Geometry(mesh: mesh, isSharedMesh: isSharedMesh, geometry: geometry)
    return g
  }

  public func build(force: Bool) {
    if (!force && !mesh.isDirty()) {
      return
    }

    var elementByMaterial = [SCNMaterial: ElementInfo]()
    var faceIndex = 0
    var geometryIndex = 0

    // We want to group all triangles in the scene by material for rendering
    mesh.faces.forEach { face in
      let faceMaterial = face.material

      var elementInfo: ElementInfo!
      if let info = elementByMaterial[faceMaterial] {
        elementInfo = info
      } else {
        elementInfo = ElementInfo(
          material: faceMaterial,
          index: geometryIndex,
          indices: []
        )
        elementByMaterial[faceMaterial] = elementInfo
        geometryIndex += 1
      }

      let _ = face.trianglesToIndices(indices: &(elementInfo.indices))
      faceIndex+=1
    }

    var elements = [SCNGeometryElement]()
    var materials = [SCNMaterial]()

    // TODO: Sort needed anymore after refactor?
    for (_, v) in (Array(elementByMaterial).sorted {$0.value.index < $1.value.index }) {
      elements.append(SCNGeometryElement(indices: v.indices, primitiveType: .triangles))
      materials.append(v.material)
    }

    let positionSource = SCNGeometrySource(vertices: mesh.vertices.toSCN())
    let normalSource = SCNGeometrySource(normals: mesh.normals.toSCN())
    let geometry = SCNGeometry(sources: [positionSource, normalSource], elements: elements)
    geometry.materials = materials
    setGeometry(geometry: geometry)

    mesh.markClean()
  }

  public var opacity: Float = 1.0 {
    didSet {
      root.opacity = CGFloat(opacity)
    }
  }

  public func removeFromScene() {
    root.removeFromParentNodeNoLeak()
  }

  public func node() -> SCNNode {
    return root
  }

  public var worldUp: GLKVector3 {
    get {
      // TODO: Cache
      return GLKQuaternionRotateVector3(scaleNode.worldOrientation.toGLK(), Geometry.up)
    }
  }

  public var worldRight: GLKVector3 {
    get {
      // TODO: Cache
      return GLKQuaternionRotateVector3(scaleNode.worldOrientation.toGLK(), Geometry.right)
    }
  }

  public var worldFront: GLKVector3 {
    get {
      // TODO: Cache
      return GLKQuaternionRotateVector3(scaleNode.worldOrientation.toGLK(), Geometry.front)
    }
  }

  public var worldTransform: GLKMatrix4 {
    get {
      return SCNMatrix4ToGLKMatrix4(scaleNode.worldTransform)
    }
  }

  public var scale = GLKVector3Make(1, 1, 1) {
    didSet {
      updateTransform()
    }
  }

  public var position = GLKVector3Make(0, 0, 0) {
    didSet {
      updateTransform()
    }
  }

  public var rotation = GLKQuaternionIdentity {
    didSet {
      updateTransform()
    }
  }

  private func updateTransform() {
    translateNode.position = position.toSCN()
    scaleNode.scale = scale.toSCN()
    rotateNode.orientation = rotation.toSCN()
  }

  private func setGeometry(geometry: SCNGeometry?) {
    self.geometry = geometry
    scaleNode.geometry = geometry
  }
}
