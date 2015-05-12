//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final internal class MasterCellConfigurator {
  func configureCell(cell: MasterCell, withItem item: MasterItem) {
    cell.titleLabel.text = item.title
    cell.iconImageView.image = UIImage(named: item.iconName)
    cell.accessoryType = item.isPush && UIDevice.currentDevice().userInterfaceIdiom == .Phone ? .DisclosureIndicator : .None
  }
}
