// Copyright © 2020 Itty Bitty Apps. All rights reserved.

import Foundation

struct HomeSectionItem: Decodable {
  let title: String?
  let rows: [HomeItem]
}
