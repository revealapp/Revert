//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

class Item: Collectable {
  internal let title: String
  internal let cellIdentifier: String
  
  required init(dictionary: [String : AnyObject]) {
    self.title = dictionary["title"] as! String
    self.cellIdentifier = dictionary["cellIdentifier"] as! String
  }
}