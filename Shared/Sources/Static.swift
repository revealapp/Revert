//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation
import MapKit

struct Static {

  struct Formatter {
    static var ddmmyy: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd MMM YYYY"
      return dateFormatter
    }()

    static var decimal: NumberFormatter = {
      let numberFormatter = NumberFormatter()
      numberFormatter.alwaysShowsDecimalSeparator = true
      numberFormatter.locale = Locale.current
      numberFormatter.maximumFractionDigits = 2
      numberFormatter.minimumFractionDigits = 1
      numberFormatter.minimumIntegerDigits = 1
      return numberFormatter
    }()
  }

  struct Region {
    static let Australia: MKCoordinateRegion = {
      let center = CLLocationCoordinate2D(latitude: -24.291451, longitude: 134.126772)
      let span = MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
      return MKCoordinateRegion(center: center, span: span)
    }()
  }
}
