//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit
import OpenGLES
import GLKit

class OpenGLViewController: GLKViewController {
  
  private let context = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
  
  private var glView: GLKView {
    return self.view as! GLKView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    assert(self.context == nil, "Failed to initialize OpenGLES 2.0 context.")
    assert(EAGLContext.setCurrentContext(self.context) == false, "Failed to set current OpenGL context.")
  }
}
