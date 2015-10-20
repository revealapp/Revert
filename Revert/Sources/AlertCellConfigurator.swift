//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class AlertCellConfigurator {
  static func configureCell(cell: BasicCell, object: Item) {
    cell.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    cell.titleLabel.text = object.title
  }

  static func identifyCellWithObject(object: Item) -> String {
    return SB.Cell.Alert
  }
}
