//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

private enum Attributes: String {
  case Title = "title"
  case InfoFilename = "infoFilename"
  case Icon = "iconName"
  case Segue = "segueIdentifier"
  case Push = "isPush"
}

struct HomeItem: Collectable {
  let title: String
  let infoFilename: String
  let iconName: String
  let segueIdentifier: String
  let isPush: Bool
  
  init(dictionary: [String: AnyObject]) {
    if let title = dictionary[Attributes.Title.rawValue] as? String,
      infoFilename = dictionary[Attributes.InfoFilename.rawValue] as? String,
      iconName = dictionary[Attributes.Icon.rawValue] as? String,
      segueIdentifier = dictionary[Attributes.Segue.rawValue] as? String {
        self.title = title
        self.infoFilename = infoFilename
        self.iconName = iconName
        self.segueIdentifier = segueIdentifier
    } else {
      fatalError("Invalid HomeItem attributes")
    }
    
    self.isPush = dictionary[Attributes.Push.rawValue] as? Bool ?? true
  }
}

protocol SettableHomeItem: class {
  var item: HomeItem? { get set }
}