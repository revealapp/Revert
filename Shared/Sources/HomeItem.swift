//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation

struct HomeItem: Collectable, Requirement {
  let title: String
  let infoFilename: String?
  let iconName: String
  let segueIdentifier: String
  let isPush: Bool
  let requiredClassName: String?

  init(dictionary: [String: AnyObject]) {
    guard
      let title = dictionary[Attributes.Title.rawValue] as? String,
      let iconName = dictionary[Attributes.Icon.rawValue] as? String,
      let segueIdentifier = dictionary[Attributes.Segue.rawValue] as? String
    else {
      fatalError("Invalid `HomeItem` attributes")
    }

    self.title = title
    self.infoFilename = dictionary[Attributes.InfoFilename.rawValue] as? String
    self.iconName = iconName
    self.segueIdentifier = segueIdentifier
    self.isPush = dictionary[Attributes.Push.rawValue] as? Bool ?? true
    self.requiredClassName = dictionary[Attributes.RequiredClassName.rawValue] as? String
  }

  // MARK: Private

  fileprivate enum Attributes: String {
    case Title = "title"
    case InfoFilename = "infoFilename"
    case Icon = "iconName"
    case Segue = "segueIdentifier"
    case Push = "isPush"
    case RequiredClassName = "requiredClassName"
  }
}

protocol SettableHomeItem: class {
  var item: HomeItem? { get set }
}
