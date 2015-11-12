//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

extension UISplitViewController {
  var backwardCompatibleCollapsed: Bool {
    if #available(iOS 8.0, *) {
      return self.collapsed
    } else {
      return UIDevice.currentDevice().userInterfaceIdiom == .Phone
    }
  }
}
