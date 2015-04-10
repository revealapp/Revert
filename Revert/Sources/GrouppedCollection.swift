//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

protocol Collectable {
  init(dictionary: [String: AnyObject])
}

struct GrouppedCollection<T: Collectable> {
  
  internal let groups: [[T]]
  
  init(resourceFileName: String) {
    self.groups = self.dynamicType.loadItems(resourceFileName)
  }
  
  subscript(i: Int) -> [T] {
    return self.groups[i]
  }
  
  var countOfGroups: Int {
    return self.groups.count
  }
  
  func countOfItemsInGroup(section: Int) -> Int {
    return self[section].count
  }
  
  func itemAtIndexPath(indexPath: NSIndexPath) -> T {
    return self[indexPath.section][indexPath.row]
  }
  
  private static func loadItems(resourceFileName: String) -> [[T]] {
    let items = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource(resourceFileName, ofType: "plist")!) as! [[[String: AnyObject]]]
    return items.map({$0.map({T(dictionary: $0)})})
  }
}
