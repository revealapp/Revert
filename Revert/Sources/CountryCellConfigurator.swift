//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class CountryCellConfigurator {
  func configureCell(cell: CountryCell, withCountry country: Country) {
    cell.titleLabel.text = country.name
    cell.subtitleLabel.text = country.capital
  }
}
