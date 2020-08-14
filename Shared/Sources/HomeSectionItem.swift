// Copyright © 2020 Itty Bitty Apps. All rights reserved.

import Foundation

struct HomeSectionItem: SectionItem, Decodable {
  typealias item = HomeItem

  var title: String?
  var rows: [item]
}
