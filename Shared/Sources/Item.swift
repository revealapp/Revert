//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation

struct Item: Collectable, Requirement {
  let title: String
  let cellIdentifier: String
  let requiredClassName: String?

  init(dictionary: [String: AnyObject]) {
    guard
      let title = dictionary[Attributes.title.rawValue] as? String,
      let cellIdentifier = dictionary[Attributes.cellIdentifier.rawValue] as? String
    else {
      fatalError("Invalid `Item` attributes")
    }

    self.title = title
    self.cellIdentifier = cellIdentifier
    self.requiredClassName = dictionary[Attributes.requiredClassName.rawValue] as? String
  }

  // MARK: Private

  fileprivate enum Attributes: String {
    case title = "title"
    case cellIdentifier = "cellIdentifier"
    case requiredClassName = "requiredClassName"
  }
}
