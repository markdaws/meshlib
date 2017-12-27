import XCTest
import GLKit
@testable import MeshLib

class NodeTests: XCTestCase {
  func testInit() {
    let m = Mesh(vertices: [], normals: [], edges: [], nodes: [], faces: [])
    let n = Node(10, [], m)
    XCTAssertEqual(n.index, 10, "index")
    XCTAssertTrue(n.mesh === m, "mesh")
  }

  func testClone() {
    let m = Mesh(vertices: [], normals: [], edges: [], nodes: [], faces: [])
    let m2 = Mesh(vertices: [], normals: [], edges: [], nodes: [], faces: [])
    let n = Node(10, [1, 2, 3], m)
    let c = n.clone(mesh: m2)
    XCTAssertEqual(c.index, 10, "index")
    XCTAssertTrue(c.mesh === m2, "mesh")
    XCTAssertTrue(c.vertices == [1,2,3], "vertices")
  }

  func testCentroid() {
    let v1 = GLKVector3Make(1,4,7)
    let m = Mesh(vertices: [
      v1,
      GLKVector3Make(2,5,8),
      GLKVector3Make(3,6,9),
      ], normals: [], edges: [], nodes: [], faces: [])
    let n = Node(10, [0,1,2], m)
    let c = n.centroid()
    XCTAssertTrue(GLKVector3AllEqualToVector3(v1, c), "centroid")
  }

}
