//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit
import GLKit

final class OpenGLViewController: RevertGLKViewController {
  private let cube = RevealOpenGLCube()
  private var glkView: GLKView {
    return self.view as! GLKView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.glkView.context = self.cube.context
    self.glkView.delegate = self
  }

  func update() {
    let aspectRatio = Float(self.view.bounds.width / self.view.bounds.height)
    let rotation = 90 * Float(self.timeSinceLastUpdate)
    self.cube.updateWithAspectRatio(aspectRatio, rotation: rotation)
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
    self.paused = self.paused == false
  }

  override func glkView(view: GLKView, drawInRect rect: CGRect) {
    self.cube.draw()
  }
}
