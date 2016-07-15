//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.
//

import Foundation

extension Double {

  static func random(between min: Double, and max: Double) -> Double {
    let arc4randomMax = 0x100000000

    return Double(arc4random()) / Double(arc4randomMax) * (max - min) + min
  }

}
