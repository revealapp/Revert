//
//  VisualEffectViewController.swift
//  Revert-iOS
//
//  Created by june chen on 12/6/19.
//  Copyright © 2019 Itty Bitty Apps. All rights reserved.
//

import Foundation

@available(iOS 9.0, *)
final class VisualEffectViewController: RevertViewController {

  override func loadView() {
    let nib = Bundle.main.loadNibNamed("VisualEffectView", owner: self, options: nil)
    guard let view = nib?.first as? UIView else {
      fatalError("Could not load Stack View from xib")
    }

    self.view = view
  }
}
