//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class ControlCellConfigurator {
  func configureCell(cell: CollectionViewCell) {
    cell.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    cell.subheadLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
  }
}
