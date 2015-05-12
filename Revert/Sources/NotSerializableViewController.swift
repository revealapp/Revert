//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class NonSerializableViewController: UIViewController, SettableMasterItem {
  var item: MasterItem?

  @IBOutlet weak var progressView: UIProgressView!
  @IBOutlet weak var subView: UIView!
  @IBOutlet weak var slider: UISlider!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    assert(self.item != nil, "Item must be set before `viewDidLoad`")
    
    // inf
    self.slider.maximumValue = 1.0 / 0.0
    
    // nan
    self.progressView.contentScaleFactor = 0.0 / 0.0
    
    // - inf
    self.subView.contentScaleFactor = -1.0 / 0.0
  }
  
  @IBAction func infoButtonTapped(sender: UIBarButtonItem) {
    self.presentInfoViewControllerWithItem(self.item!)
  }
}
