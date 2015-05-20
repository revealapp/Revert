//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

private enum Attributes: String {
  case Title = "title"
  case Cell = "cellIdentifier"
}

struct Item: Collectable {
  let title: String
  let cellIdentifier: String
  
  init(dictionary: [String : AnyObject]) {
    self.title = dictionary[Attributes.Title.rawValue] as! String
    self.cellIdentifier = dictionary[Attributes.Cell.rawValue] as! String
  }
}