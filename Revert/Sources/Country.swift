//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

private enum Attributes: String {
  case Name = "name"
  case Capital = "capital"
}

struct Country: Collectable {
  let name: String
  let capital: String?
  
  init(dictionary: [String: AnyObject]) {
    self.name = dictionary[Attributes.Name.rawValue] as! String
    self.capital = dictionary[Attributes.Capital.rawValue] as? String
  }
}
