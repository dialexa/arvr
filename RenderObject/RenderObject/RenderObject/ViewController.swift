//
//  ViewController.swift
//  RenderObject
//
//  Created by Seth Messimer on 9/25/18.
//  Copyright © 2018 Seth Messimer. All rights reserved.
//

import ARKit

// Starting positions for cubes
let kStartingPosition = SCNVector3(0, 0, -1)
let kStartingPosition2 = SCNVector3(0, 0, -2)

// Used to trigger animation update
var animTime: TimeInterval = 0
// Interval in seconds between animation updates
let animInterval: Float = 0.017
// We're going to bob these cubes up and down. Set oscillation amplitude.
// This is specified in meters. Let's try 10 cm.
let oscAmplitude: Float = 0.01
// Use this to track whether we're floating upwards or downwards. 1 = up. -1 = down.
var oscDirection: Float = 1
// How fast should we move the cube up and down?
let secondsPerOsc: Float = 1
// We know how many seconds an oscillation should last and the amplitude of an oscillation.
// So, the amount the cube should move in a given animInterval amount of time [METERS] is
// VELOCITY[m/s] * timeInterval[s] =
// TOTAL_OSC_DISTANCE[m] / secondsPerOsc[s] * timeInterval[s] =
// oscAmplitude[m] * 4 (up,down,down,up) / secondsPerOsc[s] * timeInterval[s] * oscDirection

class ViewController: UIViewController, SCNSceneRendererDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    
    var drone = Drone()
    
    func setupScene() {
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
    }
    
    func setupConfiguration() {
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    func addDrone() {
        let box = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0.01)
        let boxNode = SCNNode(geometry: box)
        boxNode.position = kStartingPosition
        sceneView.scene.rootNode.addChildNode(boxNode)
    }
    
    func addCube() {
        let box = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0.01)
        let boxNode = SCNNode(geometry: box)
        boxNode.position = kStartingPosition
        sceneView.scene.rootNode.addChildNode(boxNode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupScene()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Our stuff
        setupConfiguration()
        addCube()
        //addDrone()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // From comments above,
        // oscAmplitude[m] * 4 (up,down,down,up) / secondsPerOsc[s] * timeInterval[s] * oscDirection
        let yIncrement = ((oscAmplitude * 4) / secondsPerOsc) * animInterval * oscDirection
        if ( time > animTime ) {
            for node in sceneView.scene.rootNode.childNodes {
                node.position.y += yIncrement
                if (node.position.y >= oscAmplitude || node.position.y <= -oscAmplitude) {
                    oscDirection = -oscDirection
                }
            }
            animTime = time + TimeInterval(animInterval)
        }
    }


}

