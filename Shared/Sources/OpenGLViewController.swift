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

    #if os(tvOS)
      self.view.layer.isOpaque = false
    #endif

    super.viewWillLayoutSubviews()
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.toggleState()

    super.touchesBegan(touches, with: event)
  }

  override func glkView(_ view: GLKView, drawIn rect: CGRect) {
    self.cube.draw()
  }

  func update() {
    let aspectRatio = Float(self.view.bounds.width / self.view.bounds.height)
    let rotation = 90 * Float(self.timeSinceLastUpdate)
    self.cube.updateWithAspectRatio(aspectRatio, rotation: rotation)
  }

  // MARK: Private

  fileprivate let cube = RevealOpenGLCube()
  fileprivate var glkView: GLKView {
    return self.view as! GLKView
  }

  fileprivate func toggleState() {
    self.isPaused = self.isPaused == false
  }
}

// MARK: - tvOS Only

#if os(tvOS)

  extension OpenGLViewController {

    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
      self.toggleState()

      super.pressesBegan(presses, with: event)
    }
  }
#endif
