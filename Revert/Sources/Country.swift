//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

struct Country: Collectable {
  private enum Attributes: String {
    case Name = "name"
    case Capital = "capital"
  }
  
  let name: String
  let capital: String?
  
  init(dictionary: [String: AnyObject]) {
    if let name = dictionary[Attributes.Name.rawValue] as? String {
      self.name = name
    } else {
      fatalError("Unable to deserialize Country name")
    }
    self.capital = dictionary[Attributes.Capital.rawValue] as? String
  }
}
