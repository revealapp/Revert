//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

struct Country: Collectable {
  internal let name: String
  internal let capital: String?
  
  init(dictionary: [String: AnyObject]) {
    self.name = dictionary["name"] as! String
    self.capital = dictionary["capital"] as? String
  }
}
