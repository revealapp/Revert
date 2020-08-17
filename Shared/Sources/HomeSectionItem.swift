// Copyright © 2020 Itty Bitty Apps. All rights reserved.

import Foundation

struct HomeSectionItem: SectionItem {
  typealias Item = HomeItem

  var title: String?
  var rows: [Item]
}
