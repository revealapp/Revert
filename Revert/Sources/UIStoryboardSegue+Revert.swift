//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

extension UIStoryboardSegue {
  var destinationTopViewController: UIViewController {
    if let topViewController = (self.destinationViewController as? UINavigationController)?.topViewController {
      return topViewController
    } else {
      return self.destinationViewController
    }
  }
}
