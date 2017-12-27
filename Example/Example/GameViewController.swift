//
//  GameViewController.swift
//  Example
//
//  Created by md on 12/22/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import MeshLib

class GameViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // create a new scene
    let scene = SCNScene()
    let material = SCNMaterial()
    material.isDoubleSided = true
    material.diffuse.contents = UIColor(red: 1, green: 0, blue: 0, alpha: 1.0)

    // Cloning the Geometry instance will share the SCNGeometry and Mesh objects
    // that will reduce the number of draw calls to 1 per SCNGeometry instance
    let shareGeometry = true
    let numCubes: Int = 50
    if shareGeometry {
      let cube = GeometryFactory.cube(material: material, width: 1.0, height: 1.0, length: 1.0)
      cube.build(force: false)
      for i in 0..<numCubes {
        let sharedCube = cube.clone()
        sharedCube.position = GLKVector3Make(Float(-numCubes / 2) + Float(i) * 1.1, 0, 0)
        scene.rootNode.addChildNode(sharedCube.node())
      }
    } else {
      for i in 0..<numCubes {
        let cube = GeometryFactory.cube(material: material, width: 1.0, height: 1.0, length: 1.0)
        cube.build(force: true)
        cube.position = GLKVector3Make(Float(-numCubes / 2) + Float(i) * 1.1, 0, 0)
        scene.rootNode.addChildNode(cube.node())
      }
    }

    // create and add a camera to the scene
    let cameraNode = SCNNode()
    cameraNode.camera = SCNCamera()
    scene.rootNode.addChildNode(cameraNode)

    // place the camera
    cameraNode.position = SCNVector3(x: 0, y: 0, z: 35)

    // create and add a light to the scene
    let lightNode = SCNNode()
    lightNode.light = SCNLight()
    lightNode.light!.type = .omni
    lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
    scene.rootNode.addChildNode(lightNode)

    // create and add an ambient light to the scene
    let ambientLightNode = SCNNode()
    ambientLightNode.light = SCNLight()
    ambientLightNode.light!.type = .ambient
    ambientLightNode.light!.color = UIColor.darkGray
    scene.rootNode.addChildNode(ambientLightNode)

    // retrieve the SCNView
    let scnView = self.view as! SCNView
    //scnView.debugOptions = [SCNDebugOptions.showWireframe]

    // set the scene to the view
    scnView.scene = scene

    // allows the user to manipulate the camera
    scnView.allowsCameraControl = true

    // show statistics such as fps and timing information
    scnView.showsStatistics = true

    // configure the view
    scnView.backgroundColor = UIColor.black
  }

  override var shouldAutorotate: Bool {
    return true
  }

  override var prefersStatusBarHidden: Bool {
    return true
  }

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return .allButUpsideDown
    } else {
      return .all
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }

}
