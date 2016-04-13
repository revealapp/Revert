//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation

struct CollectableCollection<CollectableCollectionObject: Collectable>: Collection {
  typealias CollectionObject = CollectableGroup<CollectableCollectionObject>

  let items: [CollectableGroup<CollectableCollectionObject>]

  init(items: RevertItems, flatten: Bool = false) {
    let items = items.data
      .map(CollectableGroup<CollectableCollectionObject>.init)
      .filter { $0.countOfItems > 0 }

    if flatten == true {
      self.items = [CollectableGroup<CollectableCollectionObject>(items: items.flatMap({$0.items}))]
    } else {
      self.items = items
    }
  }

  init(groups: [CollectableGroup<CollectableCollectionObject>]) {
    self.items = groups
  }

  subscript(indexPath: NSIndexPath) -> CollectableCollectionObject {
    return self[indexPath.section][indexPath.row]
  }

  typealias FilterClosure = ((CollectableCollectionObject) -> Bool)?
  func filteredCollectableCollection(itemFilter: FilterClosure = nil) -> CollectableCollection {
    if let filter = itemFilter {
      let groups = self.items.map({ group -> CollectableGroup<CollectableCollectionObject> in
        // Runs through every `CollectableGroup` in order to filter items using the received closure.
        let items = group.items.filter({ object -> Bool in
          filter(object)
        })
        return CollectableGroup<CollectableCollectionObject>(title: group.title, items: items)
        // After filtering items in each group, we need to filter out empty `CollectableGroup`s.
        }).filter({ group -> Bool in
          return group.items.count > 0
        })
      // Returns a new `CollectableCollection` with only matching items and groups containing them.
      return CollectableCollection(groups: groups)
    } else {
      return self
    }
  }

  typealias GroupFilterClosure = ((CollectableGroup<CollectableCollectionObject>) -> Bool)?
  func groupFilteredCollectableCollection(groupFilter: GroupFilterClosure = nil) -> CollectableCollection {
    if let filter = groupFilter {
      let groups = self.items.filter({ object -> Bool in
        filter(object)
      })
      return CollectableCollection(groups: groups)
    } else {
      return self
    }
  }
}
