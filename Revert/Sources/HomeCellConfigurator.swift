//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class HomeCellConfigurator {
  static func configureCell(cell: HomeCell, withItem item: HomeItem) {
    cell.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    cell.titleLabel.text = item.title
    
    cell.iconImageView.image = UIImage(named: item.iconName)
    cell.accessoryType = self.shouldDisplayDisclosureIndicatorForItem(item) ? .DisclosureIndicator : .None
  }

  static func identifyCellWithObject(item: HomeItem) -> String {
    return SB.Cell.Home
  }

  static private func shouldDisplayDisclosureIndicatorForItem(item: HomeItem) -> Bool {
    return item.isPush && UIDevice.currentDevice().userInterfaceIdiom == .Phone
  }
}
