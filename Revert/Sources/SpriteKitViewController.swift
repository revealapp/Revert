//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit
import SpriteKit

final private class IBAScene: SKScene {
  private lazy var helloWorldLabel: SKLabelNode = {
    let label = SKLabelNode(fontNamed: "HelveticaNeue-Light")
    
    label.text = NSLocalizedString("spritekitviewcontroller.label.helloworld", comment: "SpriteKitViewController background label")
    label.fontSize = 28
    label.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
    return label
    }()
  
  private func addSpaceshipAtLocation(location: CGPoint) {
    let spaceShip = SKSpriteNode(imageNamed: "spritekit_reveal")
    let action = SKAction.rotateByAngle(CGFloat(M_PI), duration: 1.0)
    
    spaceShip.position = location
    spaceShip.runAction(SKAction.repeatActionForever(action))
    
    self.addChild(spaceShip)
  }
  
  override required init(size: CGSize) {
    super.init(size: size)

    self.addChild(self.helloWorldLabel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.addChild(self.helloWorldLabel)
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    for touch in touches as! Set<UITouch> {
      let location = touch.locationInNode(self)
      self.addSpaceshipAtLocation(location)
    }
  }
}

final class SpriteKitViewController: ViewController {
  private var skView: SKView {
    return self.view as! SKView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Configure the view
    self.skView.showsFPS = true
    self.skView.showsNodeCount = true
    
    // Create and configure the scene
    let scene = IBAScene(size: self.skView.bounds.size)
    scene.scaleMode = .AspectFill
    
    self.skView.presentScene(scene)
  }
}
