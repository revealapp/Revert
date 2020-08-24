//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation

struct Item: Decodable {
  let title: String
  let cellIdentifier: String
  let requiredClassName: String?
}
