//
//  MeshTests.swift
//  meshlib
//
//  Created by md on 12/24/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

import XCTest
import GLKit
@testable import MeshLib

class MeshTests: XCTestCase {
  func testInit() {
    let m = Mesh(vertices: [], normals: [], edges: [], nodes: [], faces: [])
    XCTAssertTrue(m.isDirty(), "isDirty should be true to new meshes")
  }

  func testMarkClean() {
    let m = Mesh(vertices: [], normals: [], edges: [], nodes: [], faces: [])
    m.markClean()
    XCTAssertFalse(m.isDirty())
  }

  func testTranslateRelative() {
    let m = Mesh(
      vertices: [
        GLKVector3Make(1,2,3),
        GLKVector3Make(4,5,6)
      ], 
      normals: [],
      edges: [],
      nodes: [],
      faces: []
    )

    m.appendNodes([Node(1, [0], m), Node(2, [0, 1], m)])

    m.markClean()
    m.beginRelativeTransform()
    m.translateRelative(delta: GLKVector3Make(0,0,0), nodes: [0])
    XCTAssertTrue(m.isDirty(), "should be dirty after translateRelative")

    // vertice should have changed
    m.endRelativeTransform()

  }

}

