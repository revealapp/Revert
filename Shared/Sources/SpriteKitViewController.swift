//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit
import SpriteKit

final private class IBAScene: SKScene {
  override required init(size: CGSize) {
    super.init(size: size)

    self.addChild(self.helloWorldLabel)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    self.addChild(self.helloWorldLabel)
  }

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if let firstTouch = touches.first {
      let location = firstTouch.locationInNode(self)
      let spaceship = self.dynamicType.packagedSpaceship(location)

      self.spaceship = spaceship
      self.addChild(spaceship)
    }
  }

  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if let firstTouch = touches.first {
      let location = firstTouch.locationInNode(self)

      self.spaceship?.position = location
    }
  }

  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if let spaceship = self.spaceship {
      self.dynamicType.actionSpaceship(spaceship)

      self.spaceship = nil
    }
  }

  // MARK: Private

  private var spaceship: SKSpriteNode?

  private lazy var helloWorldLabel: SKLabelNode = {
    let label = SKLabelNode(fontNamed: "HelveticaNeue-Light")
    label.text = NSLocalizedString("Tap to add sprite", comment: "SpriteKitViewController background label")
    label.fontSize = 28
    label.position = CGPoint(x: self.frame.midX, y: self.frame.midY)

    #if os(tvOS)
      label.text = NSLocalizedString("Touch the trackpad to add sprite, drag and release to animate it", comment: "SpriteKitViewController background label")
      label.fontColor = UIColor.darkGrayColor()
      label.fontSize = 60
    #endif

    return label
  }()

  private static func packagedSpaceship(startingPosition: CGPoint) -> SKSpriteNode {
    let spaceship = SKSpriteNode(imageNamed: "spritekit_reveal")
    spaceship.position = startingPosition

    return spaceship
  }

  private static func actionSpaceship(spaceship: SKSpriteNode) {
    let action = SKAction.rotateByAngle(CGFloat(M_PI), duration: 1)
    spaceship.runAction(SKAction.repeatActionForever(action))
  }
}

final class SpriteKitViewController: RevertViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    // Configure the view
    self.skView.showsFPS = true
    self.skView.showsNodeCount = true

    // Create and configure the scene
    let scene = IBAScene(size: self.skView.bounds.size)
    scene.scaleMode = .AspectFill

    #if os(tvOS)
      self.skView.allowsTransparency = true
      scene.backgroundColor = UIColor.clearColor()
    #endif

    self.skView.presentScene(scene)
  }

  // MARK: Private

  private var skView: SKView {
    return self.view as! SKView
  }
}
