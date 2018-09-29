//
//  Drone.swift
//  RenderObject
//
//  Created by Seth Messimer on 9/25/18.
//  Copyright © 2018 Seth Messimer. All rights reserved.
//

import SceneKit

class Drone: SCNNode {
    func loadModel() {
        print("Loading model")
        guard let virtualObjectScene = SCNScene(named: "Drone.scn") else {
            print("<<<<<<<<<>>>>>>>>>>FATAL - COULDN'T LOAD SCENE MODEL")
            return
        }
        print("Made scene")
        print(virtualObjectScene)
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes {
            wrapperNode.addChildNode(child)
        }
        addChildNode(wrapperNode)
    }
}
