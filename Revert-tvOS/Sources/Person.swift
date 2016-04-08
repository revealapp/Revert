//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import Foundation

struct Person: Collectable {
  let name: String
  let city: String

  init(dictionary: [String: AnyObject]) {
    guard let name = dictionary[Attributes.Name.rawValue] as? String, let city = dictionary[Attributes.City.rawValue] as? String else {
      fatalError("Unable to deserialize `Person`")
    }

    self.name = name
    self.city = city
  }

  // MARK: Private
  private enum Attributes: String {
    case Name = "name"
    case City = "city"
  }
}
