//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation

extension UIStoryboardSegue {
  var destinationTopViewController: UIViewController {
    if let topViewController = (self.destinationViewController as? UINavigationController)?.topViewController {
      return topViewController
    } else {
      return self.destinationViewController
    }
  }
}
