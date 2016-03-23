//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class RevertSplitViewController: UISplitViewController {
  func focusDetailView() {
    self.preferDetailViewFocus = true
    
    setNeedsFocusUpdate()
    updateFocusIfNeeded()
  }
  
  override var preferredFocusedView: UIView? {
    var preferredView: UIView? = super.preferredFocusedView
    
    if self.preferDetailViewFocus {
      self.preferDetailViewFocus = false
      
      preferredView = self.viewControllers.last?.preferredFocusedView
    }
    
    return preferredView
    
  }
  
  // MARK:- Private
  private var preferDetailViewFocus = false
}
