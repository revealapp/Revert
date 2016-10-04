//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import Foundation

extension UITableView {
  fileprivate static let tvOverscanInsets = UIEdgeInsets(top: 60, left: 90, bottom: 60, right: 90)

  func adjustContentInsetsForTVOs() {
    self.layoutMargins = type(of: self).tvOverscanInsets

    // We also have to account for overscan on the top and the bottom of the table view itself.
    // Content is initially offset so the table view doesn't jump when the inset update takes place.
    self.contentInset.top = self.layoutMargins.top
    self.contentInset.bottom = self.layoutMargins.bottom
    self.contentOffset.y = -self.layoutMargins.top
  }
}
