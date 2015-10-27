//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

struct CollectableCollection<CollectableCollectionObject: Collectable>: Collection {
  typealias CollectionObject = CollectableGroup<CollectableCollectionObject>

  let items: [CollectableGroup<CollectableCollectionObject>]

  init(items: RevertItems) {
    let unfilteredItems = items.data.map(CollectableGroup<CollectableCollectionObject>.init)
    self.items = unfilteredItems.filter { $0.countOfItems > 0 }
  }

  subscript(indexPath: NSIndexPath) -> CollectableCollectionObject {
    return self[indexPath.section][indexPath.row]
  }
}
