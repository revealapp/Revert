//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class MasterCell: UITableViewCell {
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()

    // Programatically adding subtitleLabel.baseline = iconView.bottom as these
    // constraints cannot be added from IB
    
    let subtitleBaselineConstraint = NSLayoutConstraint(
      item: self.iconImageView,
      attribute: .Bottom,
      relatedBy: .Equal,
      toItem: self.subtitleLabel,
      attribute: .Baseline,
      multiplier: 1.0,
      constant: 0.0)

    self.addConstraint(subtitleBaselineConstraint)
  }
}
