//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

struct Item: Collectable {
  private enum Attributes: String {
    case Title = "title"
    case Cell = "cellIdentifier"
  }
  
  let title: String
  let cellIdentifier: String
  
  init(dictionary: [String : AnyObject]) {
    guard let title = dictionary[Attributes.Title.rawValue] as? String,
      cellIdentifier = dictionary[Attributes.Cell.rawValue] as? String else {
        fatalError("Invalid Item attributes")
    }

    self.title = title
    self.cellIdentifier = cellIdentifier
  }
}
