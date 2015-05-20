//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

private enum Attributes: String {
  case Title = "title"
  case Info = "info"
  case Icon = "iconName"
  case Segue = "segueIdentifier"
  case Push = "isPush"
}

struct HomeItem: Collectable {
  let title: String
  let info: String
  let iconName: String
  let segueIdentifier: String
  let isPush: Bool
  
  init(dictionary: [String: AnyObject]) {
    self.title = dictionary[Attributes.Title.rawValue] as! String
    self.info = dictionary[Attributes.Info.rawValue] as! String
    self.iconName = dictionary[Attributes.Icon.rawValue] as! String
    self.segueIdentifier = dictionary[Attributes.Segue.rawValue] as! String
    self.isPush = dictionary[Attributes.Push.rawValue] as? Bool ?? true
  }
}

protocol SettableHomeItem: class {
  var item: HomeItem? { get set }
}