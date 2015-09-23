//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

private enum Attributes: String {
  case Title = "title"
  case Rows = "rows"
}

struct CollectableGroup<T: Collectable>: CollectionType {
  let rows: [T]
  let title: String?
  
  var startIndex: Int { return 0 }
  var endIndex: Int { return self.rows.count }
  
  init(dictionary: [String: AnyObject]) {
    guard let rowsData = dictionary[Attributes.Rows.rawValue] as? [[String: AnyObject]] else {
      fatalError("Unable to deserialize Group rows")
    }

    self.title = dictionary[Attributes.Title.rawValue] as? String
    self.rows = rowsData.map { T(dictionary: $0) }
  }
  
  subscript(i: Int) -> T {
    return self.rows[i]
  }
  
  var countOfRows: Int {
    return self.rows.count
  }
}

extension CollectableGroup : SequenceType {
  typealias Generator = AnyGenerator<T>
  
  func generate() -> Generator {
    var index = 0
    return anyGenerator {
      if index < self.rows.count {
        return self.rows[index++]
      }
      return nil
    }
  }
}
