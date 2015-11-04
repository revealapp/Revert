//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation

protocol Collectable {  
  init(dictionary: [String: AnyObject])
}

protocol Collection: CollectionType, SequenceType {
  typealias CollectionObject

  var items: [CollectionObject] { get }

  var startIndex: Int { get }
  var endIndex: Int { get }
}

extension Collection {
  var startIndex: Int {
    return 0
  }

  var endIndex: Int {
    return self.items.count
  }

  subscript(i: Int) -> CollectionObject {
    return self.items[i]
  }

  var countOfItems: Int {
    return self.items.count
  }

  func generate() -> AnyGenerator<CollectionObject> {
    var index = 0
    return anyGenerator {
      if index < self.items.count {
        return self.items[index++]
      }
      return nil
    }
  }
}
