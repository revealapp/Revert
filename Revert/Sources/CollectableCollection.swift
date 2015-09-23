//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

protocol Collectable {
  init(dictionary: [String: AnyObject])
}

struct CollectableCollection<T: Collectable>: CollectionType {
  let groups: [CollectableGroup<T>]
  
  var startIndex: Int { return 0 }
  var endIndex: Int { return self.groups.count }
  
  init(items: RevertItems) {
    self.groups = items.data.map { CollectableGroup<T>(dictionary: $0) }
  }

  subscript(i: Int) -> CollectableGroup<T> {
    return self.groups[i]
  }

  subscript(indexPath: NSIndexPath) -> T {
    return self.groups[indexPath.section][indexPath.row]
  }
  
  var countOfGroups: Int {
    return self.groups.count
  }
}

extension CollectableCollection : SequenceType {
  typealias Generator = AnyGenerator<CollectableGroup<T>>
  
  func generate() -> Generator {
    var index = 0
    return anyGenerator {
      if index < self.groups.count {
        return self.groups[index++]
      }
      return nil
    }
  }
}
