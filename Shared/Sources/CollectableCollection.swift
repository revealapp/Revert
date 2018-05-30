//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation

struct CollectableCollection<CollectableCollectionObject: Collectable>: Collection {
  typealias CollectionObject = CollectableGroup<CollectableCollectionObject>
  typealias FilterClosure = ((CollectableCollectionObject) -> Bool)
  typealias GroupFilterClosure = ((TypedGroup) -> Bool)
  typealias TypedGroup = CollectableGroup<CollectableCollectionObject>

  let items: [CollectableGroup<CollectableCollectionObject>]

  init(items: RevertItems, flatten: Bool = false, sortClosure: TypedGroup.SortClosure? = nil) {
    if flatten == true {
      let flattenedData = items.data.map(TypedGroup.rowDataForDictionary).flatMap { $0 }
      self.items = [TypedGroup(items: flattenedData.map(CollectableCollectionObject.init), sortClosure: sortClosure)]
    } else {
      self.items = items.data
        .map({ TypedGroup(dictionary: $0, sortClosure: sortClosure) })
        .filter { $0.countOfItems > 0 }
    }
  }

  init(groups: [TypedGroup]) {
    self.items = groups
  }

  subscript(indexPath: IndexPath) -> CollectableCollectionObject {
    return self[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
  }

  func filteredCollectableCollection(_ itemFilter: FilterClosure) -> CollectableCollection {
    let groups: [TypedGroup] = self.items
      .map({
        let items = $0.items.filter(itemFilter)
        return TypedGroup(title: $0.title, items: items)
      })
      // After filtering items in each group, we need to filter out empty `CollectableGroup`s.
      .filter { $0.items.count > 0 }

    // Returns a new `CollectableCollection` with only matching items and groups containing them.
    return CollectableCollection(groups: groups)
  }

  func groupFilteredCollectableCollection(_ groupFilter: GroupFilterClosure) -> CollectableCollection {
    return CollectableCollection(groups: self.items.filter(groupFilter))
  }

  // MARK: IndexableBase

  func index(after i: Int) -> Int {
    return items.index(after: i)
  }
}
