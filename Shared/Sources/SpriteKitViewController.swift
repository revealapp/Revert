//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit
import SpriteKit

private final class IBAScene: SKScene {

  required override init(size: CGSize) {
    super.init(size: size)

    self.addChild(self.helloWorldLabel)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    self.addChild(self.helloWorldLabel)
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let firstTouch = touches.first {
      let location = firstTouch.location(in: self)
      let spaceship = type(of: self).packagedSpaceship(location)

      self.spaceship = spaceship
      self.addChild(spaceship)
    }
  }

  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let firstTouch = touches.first {
      let location = firstTouch.location(in: self)

      self.spaceship?.position = location
    }
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let spaceship = self.spaceship {
      type(of: self).actionSpaceship(spaceship)

      self.spaceship = nil
    }
  }

  // MARK: Private

  fileprivate var spaceship: SKSpriteNode?

  fileprivate lazy var helloWorldLabel: SKLabelNode = {
    let label = SKLabelNode(fontNamed: "HelveticaNeue-Light")
    label.text = NSLocalizedString("Tap to add sprite", comment: "SpriteKitViewController background label")
    label.fontSize = 28
    label.position = CGPoint(x: self.frame.midX, y: self.frame.midY)

    #if os(tvOS)
      label.text = NSLocalizedString("Touch the trackpad to add sprite, drag and release to animate it", comment: "SpriteKitViewController background label")
      label.fontColor = UIColor.darkGray
      label.fontSize = 60
    #endif

    return label
  }()

  fileprivate static func packagedSpaceship(_ startingPosition: CGPoint) -> SKSpriteNode {
    let spaceship = SKSpriteNode(imageNamed: "spritekit_reveal")
    spaceship.position = startingPosition

    return spaceship
  }

  fileprivate static func actionSpaceship(_ spaceship: SKSpriteNode) {
    let action = SKAction.rotate(byAngle: CGFloat(M_PI), duration: 1)
    spaceship.run(SKAction.repeatForever(action))
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
    scene.scaleMode = .aspectFill

    #if os(tvOS)
      self.skView.allowsTransparency = true
      scene.backgroundColor = UIColor.clear
    #endif

    self.skView.presentScene(scene)
  }

  // MARK: Private

  fileprivate var skView: SKView {
    return self.view as! SKView
  }
}
