//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class MasterCell: UITableViewCell {
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    self.changeSelectionColor(selected)
  }
  
  override func setHighlighted(highlighted: Bool, animated: Bool) {
    super.setHighlighted(highlighted, animated: animated)

    self.changeSelectionColor(highlighted)
  }
  
  private func changeSelectionColor(state: Bool) {
    if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
      self.contentView.backgroundColor = state ? UIColor.revertTintColor() : UIColor.whiteColor()
    }
  }
}

final class CountryCell: UITableViewCell {
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
}
