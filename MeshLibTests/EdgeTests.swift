import XCTest
@testable import MeshLib

class EdgeTests: XCTestCase {
  func testInit() {
    let m = Mesh(vertices: [], normals: [], edges: [], nodes: [], faces: [])
    let e = Edge(10, 20, m)
    XCTAssertEqual(e.n1Index, 10, "n1Index")
    XCTAssertEqual(e.n2Index, 20, "n2Index")
    XCTAssertTrue(e.mesh === m, "mesh")
  }

  func testClone() {
    let m = Mesh(vertices: [], normals: [], edges: [], nodes: [], faces: [])
    let m2 = Mesh(vertices: [], normals: [], edges: [], nodes: [], faces: [])
    let e = Edge(10, 20, m)
    let c = e.clone(mesh: m2)
    XCTAssertEqual(c.n1Index, 10, "n1Index")
    XCTAssertEqual(c.n2Index, 20, "n2Index")
    XCTAssertTrue(c.mesh === m2, "mesh")
  }
}
