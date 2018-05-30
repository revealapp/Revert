//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation

protocol Collectable {
  init(dictionary: [String: AnyObject])
}

protocol Collection: Swift.Collection {
  associatedtype CollectionObject

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

  var countOfItems: Int {
    return self.items.count
  }

  subscript(i: Int) -> CollectionObject {
    return self.items[i]
  }
}
