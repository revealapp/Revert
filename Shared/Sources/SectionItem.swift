// Copyright © 2020 Itty Bitty Apps. All rights reserved.

import Foundation

protocol SectionItem: Decodable {
  associatedtype item

  var title: String? { get set }
  var rows: [item] { get set }
}