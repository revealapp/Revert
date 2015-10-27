//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class HomeCell: UITableViewCell {
  @IBOutlet private(set) weak var iconImageView: UIImageView!
  @IBOutlet private(set) weak var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()

    if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
      self.backgroundView = UIView()
      self.selectedBackgroundView = UIView()
      self.selectedBackgroundView?.backgroundColor = UIColor.revertTintColor()
    }
  }
}

final class BasicCell: UITableViewCell {
  @IBOutlet private(set) weak var titleLabel: UILabel!
  @IBOutlet private(set) weak var subtitleLabel: UILabel!
}
