//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

struct Static {
  struct DateFormatter {
    static var ddmmyy: NSDateFormatter = {
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = "dd MMM YYYY"
      return dateFormatter
    }()
  }
}
