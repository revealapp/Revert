//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

struct HomeItem: Collectable {
  let title: String
  let info: String
  let iconName: String
  let segueIdentifier: String
  let isPush: Bool
  
  init(dictionary: [String: AnyObject]) {
    self.title = dictionary["title"] as! String
    self.info = dictionary["info"] as! String
    self.iconName = dictionary["iconName"] as! String
    self.segueIdentifier = dictionary["segueIdentifier"] as! String
    self.isPush = dictionary["isPush"] as? Bool ?? true
  }
}

protocol SettableHomeItem: class {
  var item: HomeItem? { get set }
}