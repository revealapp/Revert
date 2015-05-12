//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final internal class CollectionViewCellConfigurator {
  func configureCell(cell: CollectionViewCell) {
    cell.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    cell.subheadLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
  }
}
