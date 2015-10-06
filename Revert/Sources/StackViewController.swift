//
//  StackViewController.swift
//  Revert
//
//  Created by Ben Thomas on 1/10/2015.
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

class StackViewController : RevertViewController {
  override func loadView() {
    if #available(iOS 9.0, *) {
      let nib = NSBundle.mainBundle().loadNibNamed("StackView", owner: self, options: nil)
      self.view = nib.first as! UIView
    }
  }
}
