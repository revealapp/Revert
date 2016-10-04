//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation

struct Country: Collectable {
  fileprivate enum Attributes: String {
    case Name = "name"
    case Capital = "capital"
  }

  let name: String
  let capital: String?

  init(dictionary: [String: AnyObject]) {
    guard let name = dictionary[Attributes.Name.rawValue] as? String else {
      fatalError("Unable to deserialize `Country.name`")
    }

    self.name = name
    self.capital = dictionary[Attributes.Capital.rawValue] as? String
  }
}
