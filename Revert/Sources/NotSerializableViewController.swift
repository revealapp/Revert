//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class NonSerializableViewController: RevertViewController {
  @IBOutlet private weak var progressView: UIProgressView!
  @IBOutlet private weak var subView: UIView!
  @IBOutlet private weak var slider: UISlider!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // inf
    self.slider.maximumValue = 1 / 0
    
    // nan
    self.progressView.contentScaleFactor = 0 / 0
    
    // - inf
    self.subView.contentScaleFactor = -1 / 0
  }
}
