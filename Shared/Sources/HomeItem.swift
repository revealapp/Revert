//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation

struct HomeItem: Decodable {
  let title: String
  let infoFilename: String?
  let iconName: String
  let segueIdentifier: String
  let isPush: Bool
  let requiredClassName: String?
}

protocol SettableHomeItem: class {
  var item: HomeItem? { get set }
}
