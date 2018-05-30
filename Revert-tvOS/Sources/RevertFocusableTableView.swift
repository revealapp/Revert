//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit

final class RevertFocusableTableView: UITableView {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    self.remembersLastFocusedIndexPath = true
  }
}
