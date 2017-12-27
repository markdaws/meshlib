//
//  GeometryTests.swift
//  meshlibTests
//
//  Created by md on 12/26/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

import XCTest
import GLKit
import SceneKit
@testable import MeshLib

class GeometryTests: XCTestCase {
  func testInit() {
    let m = Mesh(vertices: [], normals: [], edges: [], nodes: [], faces: [])
    let g = Geometry(mesh: m, isSharedMesh: true, geometry: nil)
    XCTAssertTrue(g.mesh === m, "mesh")
    XCTAssertTrue(g.isSharedMesh, "isSharedMesh")
    XCTAssertNil(g.geometry, "geometry")

    let geom = SCNGeometry()
    let g2 = Geometry(mesh: m, isSharedMesh: false, geometry: geom)
    XCTAssertTrue(g2.geometry === geom, "geometry from init")
    XCTAssertFalse(g2.isSharedMesh, "isSharedMesh should be false")
  }

  func testBuild() {
    let m = Mesh(vertices: [], normals: [], edges: [], nodes: [], faces: [])
    let g = Geometry(mesh: m, isSharedMesh: true, geometry: nil)
    g.build(force: false)
    var geom = g.geometry
    XCTAssertNotNil(geom, "geometry should not be nil after a build")

    g.build(force: false)
    XCTAssertTrue(geom === g.geometry, "non dirty mesh with no force should keep same geometry")

    g.build(force: true)
    XCTAssertFalse(geom === g.geometry, "force build should create new geometry")
    geom = g.geometry

    // Will force the mesh to be dirty
    m.appendNodes([Node(1, [], m)])
    g.build(force: false)
    XCTAssertFalse(geom === g.geometry, "dirty mesh should create new geometry")
  }

  func testClone() {
    let m = Mesh(vertices: [], normals: [], edges: [], nodes: [], faces: [])
    let geom = SCNGeometry()
    let g = Geometry(mesh: m, isSharedMesh: false, geometry: geom)
    let g2 = g.clone()

    // Since we clones g, it's mesh is now considered shared
    XCTAssertTrue(g.isSharedMesh)
    XCTAssertTrue(g2.isSharedMesh)
    XCTAssertTrue(g2.geometry === geom)
  }
}
