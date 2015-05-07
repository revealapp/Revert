//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

struct MasterItem: Collectable {
  internal let title: String
  internal let iconName: String
  internal let segueIdentifier: String
  internal let isPush: Bool
  
  init(dictionary: [String: AnyObject]) {
    self.title = dictionary["title"] as! String
    self.iconName = dictionary["iconName"] as! String
    self.segueIdentifier = dictionary["segueIdentifier"] as! String
    self.isPush = dictionary["isPush"] as? Bool ?? true
  }
}
