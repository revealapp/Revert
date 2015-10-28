//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

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
    let unfilteredItems = rowsData.map(CollectableGroupObject.init)
    self.items = unfilteredItems.filter { ($0 as? Requirement)?.isAvailable ?? true }
  }
}
