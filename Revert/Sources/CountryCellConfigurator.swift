//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class CountryCellConfigurator {
  func configureCell(cell: UITableViewCell, withCountry country: Country) {
    cell.textLabel!.text = country.name
    cell.detailTextLabel!.text = country.capital
  }
}
