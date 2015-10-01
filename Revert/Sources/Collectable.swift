//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

protocol Collectable {
  var requiredClassName: String? { get }
  
  init(dictionary: [String: AnyObject])
}

protocol Collection: CollectionType, SequenceType {
  typealias T

  var items: [T] { get }

  var startIndex: Int { get }
  var endIndex: Int { get }
}

extension Collection {
  var startIndex: Int { return 0 }
  var endIndex: Int { return self.items.count }

  subscript(i: Int) -> T {
    return self.items[i]
  }

  var countOfItems: Int {
    return self.items.count
  }

  func generate() -> AnyGenerator<T> {
    var index = 0
    return anyGenerator {
      if index < self.items.count {
        return self.items[index++]
      }
      return nil
    }
  }
}
