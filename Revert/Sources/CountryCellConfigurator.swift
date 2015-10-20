//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class CountryCellConfigurator {
  static func configureCell(cell: BasicCell, object: Country) {
    cell.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    cell.titleLabel.text = object.name

    cell.subtitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    cell.subtitleLabel.text = object.capital
  }

  static func identifyCellWithObject(object: Country) -> String {
    return SB.Cell.TableViewController
  }

  static func titleForFooter(group: CollectableGroup<Country>) -> String? {
    let count = group.countOfItems
    return NSString(format: NSLocalizedString("%lu Countries", comment: "CountriesViewController footer format"), count) as String
  }
}
