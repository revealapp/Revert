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
      let title = dictionary[Attributes.title.rawValue] as? String,
      let iconName = dictionary[Attributes.iconName.rawValue] as? String,
      let segueIdentifier = dictionary[Attributes.segueIdentifier.rawValue] as? String
      else {
      fatalError("Invalid `HomeItem` attributes")
    }

    self.title = title
    self.infoFilename = dictionary[Attributes.infoFilename.rawValue] as? String
    self.iconName = iconName
    self.segueIdentifier = segueIdentifier
    self.isPush = dictionary[Attributes.push.rawValue] as? Bool ?? true
    self.requiredClassName = dictionary[Attributes.requiredClassName.rawValue] as? String
  }

  // MARK: Private

  private enum Attributes: String {
    case title = "title"
    case infoFilename = "infoFilename"
    case iconName = "iconName"
    case segueIdentifier = "segueIdentifier"
    case push = "isPush"
    case requiredClassName = "requiredClassName"
  }
}

protocol SettableHomeItem: class {
  var item: HomeItem? { get set }
}
