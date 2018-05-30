//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import Foundation

struct Person: Collectable {
  let name: String
  let city: String

  init(dictionary: [String: AnyObject]) {
    guard let name = dictionary[Attributes.name.rawValue] as? String, let city = dictionary[Attributes.city.rawValue] as? String else {
      fatalError("Unable to deserialize `Person`")
    }

    self.name = name
    self.city = city
  }

  // MARK: Private

  private enum Attributes: String {
    case name
    case city
  }
}
