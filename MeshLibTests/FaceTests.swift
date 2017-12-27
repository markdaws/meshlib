import XCTest
@testable import MeshLib
import SceneKit

class FaceTests: XCTestCase {
  func testInit() {
    let m = Mesh(vertices: [], normals: [], edges: [], nodes: [], faces: [])
    let f = Face(material: SCNMaterial(), edges: [], nodes: [], triangles: [], mesh: m)
    XCTAssertTrue(f.mesh === m, "mesh")
  }

  func testClone() {
    let m = Mesh(vertices: [], normals: [], edges: [], nodes: [], faces: [])
    let m2 = Mesh(vertices: [], normals: [], edges: [], nodes: [], faces: [])
    let f = Face(material: SCNMaterial(), edges: [1,2,3], nodes: [4,5,6], triangles: [Triangle(1,2,3), Triangle(4,5,6)], mesh: m)
    let c = f.clone(mesh: m2)
    XCTAssertTrue(c.material === f.material, "material")
    XCTAssertEqual(f.edges, c.edges, "edges")
    XCTAssertEqual(f.nodes, c.nodes, "nodes")
    for i in 0..<f.triangles.count {
      XCTAssertFalse(f.triangles[i] === c.triangles[i])
      XCTAssertEqual(f.triangles[i].v1Index, c.triangles[i].v1Index)
      XCTAssertEqual(f.triangles[i].v2Index, c.triangles[i].v2Index)
      XCTAssertEqual(f.triangles[i].v3Index, c.triangles[i].v3Index)
    }
    XCTAssertTrue(c.mesh === m2, "mesh")
  }
}

