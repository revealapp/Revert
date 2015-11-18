//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class HomeCell: BasicCell {

  func updateSelectedBackgroundColor(isBlue isBlue: Bool) {
    if isBlue {
      let selectedBackgroundView = UIView()
      selectedBackgroundView.backgroundColor = UIColor.revertTintColor()
      self.selectedBackgroundView = selectedBackgroundView
    } else {
      self.selectedBackgroundView = nil
    }
  }

  // MARK: Private

  @IBOutlet private(set) weak var iconImageView: UIImageView!
}

class BasicCell: UITableViewCell {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    NSNotificationCenter.defaultCenter().addObserver(self, selector: "applyDynamicType:", name:
      UIContentSizeCategoryDidChangeNotification, object: nil)
  }

  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    self.applyDynamicType()
  }

  func applyDynamicType(notification: NSNotification? = nil) {
    self.titleLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    self.subtitleLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
  }

  // MARK: Private

  @IBOutlet private(set) weak var titleLabel: UILabel!
  @IBOutlet private(set) weak var subtitleLabel: UILabel!
}
