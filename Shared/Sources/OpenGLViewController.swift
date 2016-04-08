//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit
import GLKit

final class OpenGLViewController: RevertGLKViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    self.cube.load()

    self.glkView.context = self.cube.context
    self.glkView.delegate = self
  }

  override func viewWillLayoutSubviews() {
    // Make CAEAGLLayer a square to ease the rotation process
    if self.view.layer.bounds.size.width > self.view.layer.bounds.size.height {
      self.view.layer.bounds.size.height = self.view.layer.bounds.size.width
    } else {
      self.view.layer.bounds.size.width = self.view.layer.bounds.size.height
    }

    super.viewWillLayoutSubviews()
  }

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    self.toggleState()
    
    super.touchesBegan(touches, withEvent: event)
  }

  override func glkView(view: GLKView, drawInRect rect: CGRect) {
    self.cube.draw()
  }

  func update() {
    let aspectRatio = Float(self.view.bounds.width / self.view.bounds.height)
    let rotation = 90 * Float(self.timeSinceLastUpdate)
    self.cube.updateWithAspectRatio(aspectRatio, rotation: rotation)
  }

  // MARK: Private

  private let cube = RevealOpenGLCube()
  private var glkView: GLKView {
    return self.view as! GLKView
  }
  
  private func toggleState() {
    self.paused = self.paused == false
  }
}

// MARK:- tvOS Only

#if os(tvOS)
  extension OpenGLViewController {
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
      self.toggleState()
      
      super.pressesBegan(presses, withEvent:event)
    }
  }
#endif
