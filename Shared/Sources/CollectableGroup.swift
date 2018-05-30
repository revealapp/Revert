//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation

private enum Attributes: String {
  case title
  case rows
}

struct CollectableGroup<CollectableGroupObject: Collectable>: Collection {
  typealias CollectionObject = CollectableGroupObject
  typealias SortClosure = (CollectableGroupObject, CollectableGroupObject) -> Bool

  let items: [CollectableGroupObject]
  let title: String?

  static func rowDataForDictionary(_ dictionary: [String: AnyObject]) -> [[String: AnyObject]] {
    guard let rowsData = dictionary[Attributes.rows.rawValue] as? [[String: AnyObject]] else {
      fatalError("Unable to deserialize `CollectableGroup` rows")
    }
    return rowsData
  }

  init(dictionary: [String: AnyObject], sortClosure: SortClosure? = nil) {
    let title = dictionary[Attributes.title.rawValue] as? String
    let items = type(of: self).rowDataForDictionary(dictionary)
      .map(CollectableGroupObject.init)
      .filter { item -> Bool in
        if let requirementItem = item as? Requirement {
          return requirementItem.isAvailable
        }
        return true
      }

    self.init(title: title, items: items, sortClosure: sortClosure)
  }

  init(title: String? = nil, items: [CollectableGroupObject], sortClosure: SortClosure? = nil) {
    self.title = title

    if let sorter = sortClosure {
      self.items = items.sorted(by: sorter)
    } else {
      self.items = items
    }
  }

  // MARK: IndexableBase

  func index(after i: Int) -> Int {
    return self.items.index(after: i)
  }
}
