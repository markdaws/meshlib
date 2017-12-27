//
//  Cube.swift
//  meshlib
//
//  Created by md on 12/21/17.
//

import Foundation
import GLKit
import SceneKit

public final class GeometryFactory {
  public static func cube(material: SCNMaterial, width: Float, height: Float, length: Float) -> Geometry {
    let mesh = Mesh(vertices: [], normals: [], edges: [], nodes: [], faces: [])
    let geom = Geometry(mesh: mesh, isSharedMesh: false, geometry: nil)

    let hw: Float = width * 0.5
    let hh: Float = height * 0.5
    let hl: Float = length * 0.5

    /*
     +x points right
     +y points up
     +z points out the screen
     */
    let vertices = [
      GLKVector3Make(-hw, hh, hl),   // 0 - front
      GLKVector3Make(-hw, -hh, hl),  // 1 - front
      GLKVector3Make(hw, -hh, hl),   // 2 - front
      GLKVector3Make(hw, hh, hl),    // 3 - front
      GLKVector3Make(hw, hh, -hl),   // 4 - back
      GLKVector3Make(hw, -hh, -hl),  // 5 - back
      GLKVector3Make(-hw, -hh, -hl), // 6 - back
      GLKVector3Make(-hw, hh, -hl),  // 7 - back
      GLKVector3Make(-hw, hh, -hl),  // 8 - left
      GLKVector3Make(-hw, -hh, -hl), // 9 - left
      GLKVector3Make(-hw, -hh, hl),  // 10 - left
      GLKVector3Make(-hw, hh, hl),   // 11 - left
      GLKVector3Make(hw, hh, hl),    // 12 - right
      GLKVector3Make(hw, -hh, hl),   // 13 - right
      GLKVector3Make(hw, -hh, -hl),  // 14 - right
      GLKVector3Make(hw, hh, -hl),   // 15 - right
      GLKVector3Make(-hw, hh, -hl),  // 16 - top
      GLKVector3Make(-hw, hh, hl),   // 17 - top
      GLKVector3Make(hw, hh, hl),    // 18 - top
      GLKVector3Make(hw, hh, -hl),   // 19 - top
      GLKVector3Make(hw, -hh, -hl),  // 20 - bottom
      GLKVector3Make(hw, -hh, hl),   // 21 - bottom
      GLKVector3Make(-hw, -hh, hl),  // 22 - bottom
      GLKVector3Make(-hw, -hh, -hl), // 23 - bottom
    ]

    let normals = [
      GLKVector3Make(0, 0, 1),
      GLKVector3Make(0, 0, 1),
      GLKVector3Make(0, 0, 1),
      GLKVector3Make(0, 0, 1),
      GLKVector3Make(0, 0, -1),
      GLKVector3Make(0, 0, -1),
      GLKVector3Make(0, 0, -1),
      GLKVector3Make(0, 0, -1),
      GLKVector3Make(-1, 0, 0),
      GLKVector3Make(-1, 0, 0),
      GLKVector3Make(-1, 0, 0),
      GLKVector3Make(-1, 0, 0),
      GLKVector3Make(1, 0, 0),
      GLKVector3Make(1, 0, 0),
      GLKVector3Make(1, 0, 0),
      GLKVector3Make(1, 0, 0),
      GLKVector3Make(0, 1, 0),
      GLKVector3Make(0, 1, 0),
      GLKVector3Make(0, 1, 0),
      GLKVector3Make(0, 1, 0),
      GLKVector3Make(0, -1, 0),
      GLKVector3Make(0, -1, 0),
      GLKVector3Make(0, -1, 0),
      GLKVector3Make(0, -1, 0)
    ]

    let nodes = [
      Node(0, [0, 11, 17], mesh),  // 0 - top left front
      Node(1, [1, 10, 22], mesh),  // 1 - bottom left front
      Node(2, [2, 13, 21], mesh),  // 2 - bottom right front
      Node(3, [3, 12, 18], mesh),  // 3 - top right front
      Node(4, [4, 15, 19], mesh),  // 4 - top left back
      Node(5, [5, 14, 20], mesh),  // 5 - bottom left back
      Node(6, [6, 9, 23], mesh),   // 6 - bottom right back
      Node(7, [7, 8, 16], mesh),   // 7 - top right back
    ]

    let edges = [
      Edge(0, 1, mesh),  // 0:  front-left
      Edge(1, 2, mesh),  // 1:  front-bottom
      Edge(2, 3, mesh),  // 2:  front-right
      Edge(3, 0, mesh),  // 3:  front-top
      Edge(6, 7, mesh),  // 4:  back-left
      Edge(5, 6, mesh),  // 5:  back-bottom
      Edge(4, 5, mesh),  // 6:  back-right
      Edge(7, 4, mesh),  // 7:  back-top
      Edge(7, 0, mesh),  // 8:  left-top
      Edge(3, 4, mesh),  // 9:  right-top
      Edge(1, 6, mesh),  // 10: left-bottom
      Edge(2, 5, mesh)   // 11: right-bottom
    ]

    let front = Face(
      material: material,
      edges: [0, 1, 2, 3],
      nodes: [0, 1, 2, 3],
      triangles: [
        Triangle(0, 1, 2),
        Triangle(2, 3, 0)
      ],
      mesh: mesh
    )

    let back = Face(
      material: material,
      edges: [6, 5, 4, 7],
      nodes: [4, 5, 6, 7],
      triangles: [
        Triangle(4, 5, 6),
        Triangle(6, 7, 4)
      ],
      mesh: mesh
    )

    let top = Face(
      material: material,
      edges: [8, 3, 9, 7],
      nodes: [0, 3, 4, 7],
      triangles: [
        Triangle(16, 17, 18),
        Triangle(16, 18, 19)
      ],
      mesh: mesh
    )

    let bottom = Face(
      material: material,
      edges: [11, 5, 10, 1],
      nodes: [1, 2, 5, 6],
      triangles: [
        Triangle(23, 20, 21),
        Triangle(23, 21, 22)
      ],
      mesh: mesh
    )

    let left = Face(
      material: material,
      edges: [4, 10, 0, 8],
      nodes: [0, 1, 6, 7],
      triangles: [
        Triangle(8, 9, 11),
        Triangle(9, 10, 11)
      ],
      mesh: mesh
    )

    let right = Face(
      material: material,
      edges: [2, 11, 6, 9],
      nodes: [2, 3, 4, 5],
      triangles: [
        Triangle(12, 13, 14),
        Triangle(12, 14, 15)
      ],
      mesh: mesh
    )

    mesh.appendVertices(vertices)
    mesh.appendEdges(edges)
    mesh.appendNodes(nodes)
    mesh.appendNormals(normals)
    mesh.appendFaces(front, back, top, bottom, left, right)
    return geom

    /*
    if Cube.defaultGeometry == nil {
      Cube.defaultGeometry = Geometry.buildGeometry(device: nil, mesh: cube, overrideMaterial: nil)
    }
    
    // TODO: Why am I copying here, shouldn't do this?
    let geometry = Cube.defaultGeometry!.geometry //.copy() as! SCNGeometry
    cube.setGeometry(geometry, isGeometryShared: true, templateGeometry: geometry)
    cube.geometry!.materials = [material]
    cube.hitResultHelper = Cube.defaultGeometry!.hitResultHelper
    //cube.hitResultHelper =
    // TODO: Copy these across and also above...
    // materials
    // hitTestHelper
 */
  }

}
