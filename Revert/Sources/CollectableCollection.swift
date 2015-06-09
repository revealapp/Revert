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
  
  init(resourceFilename: String) {
    self.groups = self.dynamicType.collectableItemsFromRessource(resourceFilename)
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
  
  private static func collectableItemsFromRessource(resourceFilename: String) -> [CollectableGroup<T>] {
    if let items = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource(resourceFilename, ofType: "plist")!) as? [[String: AnyObject]] {
      return items.map({CollectableGroup<T>(dictionary: $0)})
    } else {
      fatalError("Invalid file: \(resourceFilename).plist")
    }
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
