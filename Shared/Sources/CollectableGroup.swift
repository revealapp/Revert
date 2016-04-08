//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation

private enum Attributes: String {
  case Title = "title"
  case Rows = "rows"
}

struct CollectableGroup<CollectableGroupObject: Collectable>: Collection {
  typealias CollectionObject = CollectableGroupObject

  let items: [CollectableGroupObject]
  let title: String?

  init(dictionary: [String: AnyObject]) {
    guard let rowsData = dictionary[Attributes.Rows.rawValue] as? [[String: AnyObject]] else {
      fatalError("Unable to deserialize `CollectableGroup` rows")
    }

    self.title = dictionary[Attributes.Title.rawValue] as? String
    self.items = rowsData
      .map(CollectableGroupObject.init)
      .filter { item -> Bool in
        if let requirementItem = item as? Requirement {
          return requirementItem.isAvailable
        }
        return true
    }
  }
}
