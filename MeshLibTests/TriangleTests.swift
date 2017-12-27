//
//  TriangleTests.swift
//  meshlibTests
//
//  Created by md on 12/27/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

import XCTest
import GLKit
@testable import MeshLib

class TriangleTests: XCTestCase {
  func testInit() {
    let t = Triangle(5, 10, 15)
    XCTAssertEqual(t.v1Index, 5, "v1Index")
    XCTAssertEqual(t.v2Index, 10, "v2Index")
    XCTAssertEqual(t.v3Index, 15, "v3Index")
  }

  func testClone() {
    let t = Triangle(5, 10, 15)
    let c = t.clone()
    XCTAssertEqual(c.v1Index, 5, "v1Index")
    XCTAssertEqual(c.v2Index, 10, "v2Index")
    XCTAssertEqual(c.v3Index, 15, "v3Index")
  }
}
