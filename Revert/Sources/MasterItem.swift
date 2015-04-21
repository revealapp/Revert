//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

struct MasterItem: Collectable {
  internal let title: String
  internal let subtitle: String
  internal let iconName: String
  internal let segueIdentifier: String
  internal let isPush: Bool
  internal let resourceFilename: String?
  
  init(dictionary: [String: AnyObject]) {
    self.title = dictionary["title"] as! String
    self.subtitle = dictionary["subtitle"] as! String
    self.iconName = dictionary["iconName"] as! String
    self.segueIdentifier = dictionary["segueIdentifier"] as! String
    self.resourceFilename = dictionary["resourceFilename"] as? String
    self.isPush = dictionary["isPush"] as! Bool
  }
}
