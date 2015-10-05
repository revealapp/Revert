//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class CountryCellConfigurator {
  func configureCell(cell: BasicCell, withCountry country: Country) {
    cell.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    cell.titleLabel.text = country.name

    cell.subtitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    cell.subtitleLabel.text = country.capital
  }
}
