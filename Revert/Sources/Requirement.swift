//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation

protocol Requirement {
  var requiredClassName: String? { get }
}

extension Requirement {
  var isAvailable: Bool {
    guard let name = requiredClassName else {
      return true
    }
    
    return NSClassFromString(name) != nil
  }
}
