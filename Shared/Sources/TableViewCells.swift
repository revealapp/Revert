//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class HomeCell: BasicCell {

  func updateSelectedBackgroundColor(_ isBlue: Bool) {
    if isBlue {
      let selectedBackgroundView = UIView()
      selectedBackgroundView.backgroundColor = UIColor.revertTintColor()
      self.selectedBackgroundView = selectedBackgroundView
    } else {
      self.selectedBackgroundView = nil
    }
  }

  // MARK: Private

  @IBOutlet fileprivate(set) weak var iconImageView: UIImageView!
}

class BasicCell: UITableViewCell {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    NotificationCenter.default.addObserver(self, selector: #selector(self.applyDynamicType(_:)), name:
      NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
  }

  deinit {
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    self.applyDynamicType()
  }

  func applyDynamicType(_ notification: Notification? = nil) {
    self.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
    self.subtitleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
  }

  // MARK: Private

  @IBOutlet fileprivate(set) weak var titleLabel: UILabel!
  @IBOutlet fileprivate(set) weak var subtitleLabel: UILabel!
}
