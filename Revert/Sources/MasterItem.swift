//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

struct MasterItem: Collectable {
  internal let title: String
  internal let subtitle: String
  internal let iconName: String
  internal let storyboardIdentifier: String
  internal let isPush: Bool
  
  init(dictionary: [String: AnyObject]) {
    self.title = dictionary["title"] as! String
    self.subtitle = dictionary["subtitle"] as! String
    self.iconName = dictionary["iconName"] as! String
    self.storyboardIdentifier = dictionary["storyboardIdentifier"] as! String
    self.isPush = dictionary["isPush"] as! Bool
  }
}
