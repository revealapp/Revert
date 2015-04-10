//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class MasterCellConfigurator {
  
  func configureCell(cell: MasterCell, withItem item: MasterItem) {
    cell.titleLabel.text = item.title
    cell.subtitleLabel.text = item.subtitle
    cell.iconImageView.image = UIImage(named: item.iconName)
  }
  
}
