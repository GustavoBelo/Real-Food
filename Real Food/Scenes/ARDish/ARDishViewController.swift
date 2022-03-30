//
//  ARDishViewController.swift
//  ARDicee
//
//  Created by Gustavo Belo on 06/12/21.
//

import UIKit
import SceneKit
import ARKit
import FirebaseStorage

class ARDishViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet private var sceneView: ARSCNView!
    @IBAction func done(_ sender: UIBarButtonItem) {
    }
    var restaurant: String!
    var dish: String!
    
    private let storage = Storage.storage(url: "gs://real-food-d2eae.appspot.com")
    private var storageRef: StorageReference? = nil
    private var forestRef: StorageReference? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        storageRef = self.storage.reference()
        forestRef = storageRef!.child("\(restaurant!)/\(dish!).scn")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.write3DModelsToDirectory(modelPath: self.forestRef!, dish: dish)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Mousepad", bundle: Bundle.main) {
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 1
        }
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor,
           let dishString = dish {
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi/2
            
            node.addChildNode(planeNode)
            self.forestRef!.getMetadata { metadata, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self.load3DModelsFromDirectory(in: planeNode, dish: dishString)
                }
            }
        }
        return node
    }
    
    private func write3DModelsToDirectory(modelPath: StorageReference, dish: String){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let tempDirectory = URL.init(fileURLWithPath: paths, isDirectory: true)
        let targetUrl = tempDirectory.appendingPathComponent("\(dish).scn")
        modelPath.write(toFile: targetUrl) { (url, error) in
            if let e = error {
                print("ERROR: \(e.localizedDescription)")
            }
        }
    }
    
    private func load3DModelsFromDirectory(in planeNode: SCNNode, dish: String) {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let tempDirectory = URL.init(fileURLWithPath: paths, isDirectory: true)
        let targetUrl = tempDirectory.appendingPathComponent("/\(dish).scn")
        var sceneForNode: SCNScene? = nil
        do {
            // load the 3D-Model node from directory path
            sceneForNode = try SCNScene(url: targetUrl, options: nil)
        }catch{
            print(error.localizedDescription)
        }
        // create node to display on scene
        if let node = sceneForNode?.rootNode.childNodes.first {
            node.eulerAngles.x = .pi / 2
            planeNode.addChildNode(node)
        }
    }
}
