//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation

extension Bundle {
  var revealWebsiteURL: URL {
    guard let URLString = infoDictionary?["revealWebsiteURL"] as? String, let URL = URL(string: URLString) else {
      fatalError("Reveal website URL missing or invalid")
    }
    return URL
  }
}
