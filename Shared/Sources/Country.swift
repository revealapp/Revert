//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation

struct Country: Decodable {
  let name: String
  let capital: String?
}

struct CountrySection: RevertSection {
  var title: String?
  var rows: [Country]
}
