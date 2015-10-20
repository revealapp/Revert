//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

protocol Requirement {
  var requiredClassName: String? { get }
}

extension Requirement {
  var isAvailable: Bool {
    if let name = requiredClassName {
      return NSClassFromString(name) != nil
    }
    
    return true
  }
}
