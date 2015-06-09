//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class HomeCell: UITableViewCell {
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  
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
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
}
